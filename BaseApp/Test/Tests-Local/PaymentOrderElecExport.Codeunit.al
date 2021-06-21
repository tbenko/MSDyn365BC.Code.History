codeunit 147508 "Payment Order Elec. Export"
{
    // // [FEATURE] [Payment Order] [Export Electronic Payment]

    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
    end;

    var
        LibraryCarteraPayables: Codeunit "Library - Cartera Payables";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryPurchase: Codeunit "Library - Purchase";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryRandom: Codeunit "Library - Random";
        Assert: Codeunit Assert;
        ConfirmTxt: Label 'Are you SURE you want to Void all of the Cartera Electronic Payments in Order';
        MessageTxt: Label 'has been voided';
        FileExportHasErrorsErr: Label 'The file export has one or more errors.';
        MustHaveIBANErr: Label 'must have a value in IBAN';
        ExportElecPaymentMustBeYesErr: Label 'Export Electronic Payment must be equal to ''Yes''  in Payment Order: No.=%1', Comment = '.';

    local procedure Initialize()
    begin
        LibraryVariableStorage.Clear;
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestElecPmtFalseOnPaymOrderError()
    var
        PaymentOrder: Record "Payment Order";
    begin
        // [SCENARIO] Payment Order, where "Export Electronic Payment" set to No, should not be exported
        Initialize;

        // [GIVEN] Payment Order, where "Export Electronic Payment" set to "No"
        CreatePaymentOrderWithOneLine(PaymentOrder, false);

        // [WHEN] Export To File
        asserterror PaymentOrder.ExportToFile;

        // [THEN] Error message: 'Export Electronic Payment must be Yes'
        Assert.ExpectedError(StrSubstNo(ExportElecPaymentMustBeYesErr, PaymentOrder."No."));
    end;

    [Test]
    [HandlerFunctions('VoidPaymentOrderReqPageHandler,ConfirmHandler,MessageHandler')]
    [Scope('OnPrem')]
    procedure TestVoidPOAfterExport()
    var
        PaymentOrder: Record "Payment Order";
    begin
        // [FEATURE] [Void PO - Export]
        // [SCENARIO] "Void PO - Export" job should mark an exported Payment Order as not exported
        Initialize;

        // [GIVEN] Payment Order with one line is marked as exported
        CreatePaymentOrderWithOneLine(PaymentOrder, true);

        // [WHEN] Run "Void PO - Export" on Payment Order
        // Normally here you would run PaymentOrder.ExportToFile. This opens a SaveAs which we can't catch.
        // In this case, I don't care about the file so I set the exported manually the same way as the function does after export.
        PaymentOrder.Validate("Elect. Pmts Exported", true);
        PaymentOrder.Modify;
        Commit; // need commit before running the report
        LibraryVariableStorage.Enqueue(PaymentOrder."No.");
        LibraryVariableStorage.Enqueue(ConfirmTxt);
        LibraryVariableStorage.Enqueue(MessageTxt);
        REPORT.Run(REPORT::"Void PO - Export");

        // [THEN] Payment Order is marked as not exported
        Commit;
        PaymentOrder.Get(PaymentOrder."No.");
        PaymentOrder.TestField("Elect. Pmts Exported", false);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestPaymentOrderElectPmtsExpOnValidate()
    var
        PaymentOrder: Record "Payment Order";
        PostedDocNo: Code[20];
        PostedDocNo2: Code[20];
    begin
        // [FEATURE] [CarteraDoc] [UT]
        // [SCENARIO] CarteraDoc should be marked as exported if linked Payment Order marked as exported
        Initialize;

        // [GIVEN] CarteraDoc "A" is posted and added to a Payment Order
        PostedDocNo := CreatePaymentOrderWithOneLine(PaymentOrder, true);
        // [GIVEN] CarteraDoc "B" is posted and NOT added to a Payment Order
        PostedDocNo2 := CreateAndPostPurchaseInvoice(CreateVendorWithBankAccount(true));

        // [WHEN] Mark Payment Order as exported
        PaymentOrder.Validate("Elect. Pmts Exported", true);
        PaymentOrder.Modify;

        // [THEN] CarteraDoc "A" is marked as exported
        VerifyCarteraDocElecPmtExported(PostedDocNo, true);
        // [THEN] CarteraDoc "B" is NOT marked as exported
        VerifyCarteraDocElecPmtExported(PostedDocNo2, false);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ErrorShownIfNotLastLineHasPaymentError()
    var
        PaymentOrder: Record "Payment Order";
        BankAccNo: Code[20];
        VendorNo: array[2] of Code[20];
        CarteraDocEntryNo: array[2] of Integer;
        PostedDocNo: array[2] of Code[20];
    begin
        // [FEATURE] [SEPA] [Credit Transfer] [Payment Export Error]
        // [SCENARIO 375303] Payment Order with two lines should not be exported if there is a payment error in the first line
        Initialize;

        // [GIVEN] Vendor 10000 has Vendor Bank Account "ANT" with a blank IBAN
        VendorNo[1] := CreateVendorWithBankAccount(true);
        BlankIBANonVendorBankAccount(VendorNo[1]);
        // [GIVEN] Vendor 20000 has Vendor Bank Account "ANT" with a defined IBAN
        VendorNo[2] := CreateVendorWithBankAccount(true);

        // [GIVEN] 2 Purchase Invoices posted for Vendors 10000 and 20000
        PostedDocNo[1] := CreateAndPostPurchaseInvoice(VendorNo[1]);
        PostedDocNo[2] := CreateAndPostPurchaseInvoice(VendorNo[2]); // good Doc must be posted last

        // [GIVEN] Payment Order with two lines: first one for Vendor 10000, second one for Vendor 20000
        BankAccNo := CreateBankAccount;
        CreatePaymentOrderWithSpecificBankAccount(PaymentOrder, BankAccNo, true);
        CarteraDocEntryNo[1] := AddDocToBillGroup(PaymentOrder."No.", PostedDocNo[1], VendorNo[1]);
        CarteraDocEntryNo[2] := AddDocToBillGroup(PaymentOrder."No.", PostedDocNo[2], VendorNo[2]);

        // [WHEN] Export To File
        asserterror PaymentOrder.ExportToFile;

        // [THEN] Error message: "The file export has one or more errors"
        Assert.ExpectedError(FileExportHasErrorsErr);
        // [THEN] File Export Errors FactBox contains error for the first line: "Vendor Bank Account ANT must have a value in IBAN."
        VerifyFirstPaymentLineExportError(PaymentOrder, CarteraDocEntryNo[1], MustHaveIBANErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure PmtExportBufGetsPaymentOrderLines()
    var
        GenJnlLine: Record "Gen. Journal Line";
        TempPaymentExportData: Record "Payment Export Data" temporary;
        PaymentOrder: Record "Payment Order";
        SEPACTFillExportBuffer: Codeunit "SEPA CT-Fill Export Buffer";
        CarteraDocNo: Code[20];
    begin
        // [FEATURE] [SEPA] [Credit Transfer] [UT] [Payment Export Data]
        // [SCENARIO 375303] Payment Export Data "Document No." should be Cartera Document "No."
        Initialize;

        // [GIVEN] Payment Order with one line, where Cartera Document No. is "X"
        CarteraDocNo := CreatePaymentOrderWithOneLine(PaymentOrder, true);

        // [WHEN] Fill Export Buffer
        PaymentOrder.FilterSourceForExport(GenJnlLine);
        SEPACTFillExportBuffer.FillExportBuffer(GenJnlLine, TempPaymentExportData);

        // [THEN] Export Buffer contains one line where "Document No." is "X"
        Assert.AreEqual(1, TempPaymentExportData.Count, 'There must be 1 line in the buffer');
        TempPaymentExportData.FindFirst;
        TempPaymentExportData.TestField("Document No.", CarteraDocNo);
    end;

    local procedure CreateBankAccount(): Code[20]
    var
        BankAccount: Record "Bank Account";
    begin
        LibraryCarteraPayables.CreateBankAccount(BankAccount, ''); // blank currency code
        BankAccount.IBAN := LibraryUtility.GenerateRandomCode(BankAccount.FieldNo(IBAN), DATABASE::"Bank Account");
        BankAccount."SWIFT Code" := LibraryUtility.GenerateRandomCode(BankAccount.FieldNo("SWIFT Code"), DATABASE::"Bank Account");
        BankAccount.Validate("Payment Export Format", FindSEPACTExportFormat);
        BankAccount.Validate("Credit Transfer Msg. Nos.", CreateNoSeries);
        BankAccount.Validate("E-Pay Export File Path", '');
        BankAccount.Modify(true);
        exit(BankAccount."No.");
    end;

    local procedure CreateVendorWithBankAccount(ElecPmt: Boolean): Code[20]
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PaymentMethod: Record "Payment Method";
    begin
        PaymentMethod.SetRange("Invoices to Cartera", true);
        PaymentMethod.SetRange("Bill Type", PaymentMethod."Bill Type"::Transfer);
        PaymentMethod.FindFirst;

        LibraryCarteraPayables.CreateCarteraVendor(Vendor, '', PaymentMethod.Code); // blank currency code
        LibraryCarteraPayables.CreateVendorBankAccount(Vendor, '');
        VendorBankAccount.Get(Vendor."No.", Vendor."Preferred Bank Account Code");
        VendorBankAccount.Validate("Use For Electronic Payments", ElecPmt);
        VendorBankAccount.IBAN := LibraryUtility.GenerateRandomCode(VendorBankAccount.FieldNo(IBAN), DATABASE::"Vendor Bank Account");
        VendorBankAccount.Modify(true);
        exit(Vendor."No.");
    end;

    local procedure CreateNoSeries(): Code[20]
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        LibraryUtility.CreateNoSeries(NoSeries, true, false, false);
        LibraryUtility.CreateNoSeriesLine(NoSeriesLine, NoSeries.Code, '', ''); // numbering is not important
        exit(NoSeries.Code);
    end;

    local procedure CreateAndPostPurchaseInvoice(VendorNo: Code[20]): Code[20]
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        DocumentNo: Code[20];
    begin
        Item.FindFirst;
        LibraryPurchase.CreatePurchHeader(PurchaseHeader, PurchaseHeader."Document Type"::Invoice, VendorNo);
        LibraryPurchase.CreatePurchaseLine(PurchaseLine, PurchaseHeader, PurchaseLine.Type::Item, Item."No.",
          LibraryRandom.RandInt(10));
        PurchaseLine.Validate("Direct Unit Cost", LibraryRandom.RandDecInRange(100, 200, 2));
        PurchaseLine.Modify(true);
        DocumentNo := LibraryPurchase.PostPurchaseDocument(PurchaseHeader, true, true); // Receive & Invoice
        exit(DocumentNo);
    end;

    local procedure CreatePaymentOrderWithOneLine(var PaymentOrder: Record "Payment Order"; ExportElectronicPayment: Boolean): Code[20]
    var
        BankAccNo: Code[20];
        VendorNo: Code[20];
        PostedDocNo: Code[20];
    begin
        BankAccNo := CreateBankAccount;
        VendorNo := CreateVendorWithBankAccount(ExportElectronicPayment);
        PostedDocNo := CreateAndPostPurchaseInvoice(VendorNo);
        CreatePaymentOrderWithSpecificBankAccount(PaymentOrder, BankAccNo, ExportElectronicPayment);
        AddDocToBillGroup(PaymentOrder."No.", PostedDocNo, VendorNo);
        exit(PostedDocNo);
    end;

    local procedure CreatePaymentOrderWithSpecificBankAccount(var PaymentOrder: Record "Payment Order"; BankAccNo: Code[20]; ExportElectronicPayment: Boolean)
    begin
        LibraryCarteraPayables.CreatePaymentOrder(PaymentOrder, '', BankAccNo);
        PaymentOrder.Validate("Export Electronic Payment", ExportElectronicPayment);
        PaymentOrder.Modify(true);
    end;

    local procedure AddDocToBillGroup(BillGroupNo: Code[20]; InvoiceNo: Code[20]; VendorNo: Code[20]): Integer
    var
        CarteraDoc: Record "Cartera Doc.";
    begin
        LibraryCarteraPayables.AddCarteraDocumentToBillGroup(CarteraDoc, InvoiceNo, VendorNo, BillGroupNo);
        exit(CarteraDoc."Entry No.");
    end;

    local procedure BlankIBANonVendorBankAccount(VendorNo: Code[20])
    var
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        with VendorBankAccount do begin
            SetRange("Vendor No.", VendorNo);
            FindFirst;
            IBAN := '';
            Modify(true);
        end;
    end;

    local procedure FindSEPACTExportFormat(): Code[20]
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        BankExportImportSetup.SetRange("Processing Codeunit ID", CODEUNIT::"SEPA CT-Export File");
        BankExportImportSetup.FindFirst;
        exit(BankExportImportSetup.Code);
    end;

    local procedure VerifyCarteraDocElecPmtExported(DocumentNo: Code[20]; Exported: Boolean)
    var
        CarteraDoc: Record "Cartera Doc.";
    begin
        CarteraDoc.SetRange(Type, CarteraDoc.Type::Payable);
        CarteraDoc.SetRange("Document No.", DocumentNo);
        CarteraDoc.FindSet;
        repeat
            CarteraDoc.TestField("Elect. Pmts Exported", Exported);
        until CarteraDoc.Next = 0;
    end;

    local procedure VerifyFirstPaymentLineExportError(PaymentOrder: Record "Payment Order"; LineNo: Integer; ExpectedErrorText: Text)
    var
        PaymentOrders: TestPage "Payment Orders";
    begin
        PaymentOrders.OpenView;
        PaymentOrders.GotoRecord(PaymentOrder);
        // First line has an expected error in the FactBox
        PaymentOrders.Docs.First;
        PaymentOrders.Docs."Entry No.".AssertEquals(LineNo);
        PaymentOrders.Control1901420307.First;
        asserterror Error(PaymentOrders."Payment File Errors"."Error Text".Value);
        Assert.ExpectedError(ExpectedErrorText);

        // Second line has no errors
        PaymentOrders.Docs.Next;
        PaymentOrders.Control1901420307.First; // somehow FIRST returns true on the empty factbox
        PaymentOrders."Payment File Errors"."Error Text".AssertEquals('');
        PaymentOrders.Close;
    end;

    [RequestPageHandler]
    [Scope('OnPrem')]
    procedure VoidPaymentOrderReqPageHandler(var VoidPOExport: TestRequestPage "Void PO - Export")
    var
        PaymentOrderNo: Variant;
    begin
        LibraryVariableStorage.Dequeue(PaymentOrderNo);
        VoidPOExport.PaymentOrderNo.SetValue(PaymentOrderNo);
        VoidPOExport.OK.Invoke;
    end;

    [ConfirmHandler]
    [Scope('OnPrem')]
    procedure ConfirmHandler(Question: Text; var Reply: Boolean)
    var
        ConfirmText: Variant;
    begin
        LibraryVariableStorage.Dequeue(ConfirmText);
        if StrPos(Question, ConfirmText) <> 0 then
            Reply := true;
    end;

    [MessageHandler]
    [Scope('OnPrem')]
    procedure MessageHandler(Message: Text)
    var
        MessageText: Variant;
    begin
        LibraryVariableStorage.Dequeue(MessageText);
        Assert.IsTrue(StrPos(Message, MessageText) <> 0, 'Unexpected message');
    end;
}
