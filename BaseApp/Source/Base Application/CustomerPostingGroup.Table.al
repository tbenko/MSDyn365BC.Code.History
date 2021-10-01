table 92 "Customer Posting Group"
{
    Caption = 'Customer Posting Group';
    LookupPageID = "Customer Posting Groups";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Receivables Account"; Code[20])
        {
            Caption = 'Receivables Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Receivables Account")
                else
                    LookupGLAccount(
#if not CLEAN19
                      "Receivables Account", GLAccountCategory."Account Category"::Assets,
                      GLAccountCategoryMgt.GetCII21TradeReceivables()); // NAVCZ
#else
                      "Receivables Account", GLAccountCategory."Account Category"::Assets, GLAccountCategoryMgt.GetAR);
#endif

                Validate("Receivables Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Receivables Account", false, false)
                else
                    CheckGLAccount(
#if not CLEAN19                        
                      FieldNo("Receivables Account"), "Receivables Account", false, false, GLAccountCategory."Account Category"::Assets,
                      GLAccountCategoryMgt.GetCII21TradeReceivables()); // NAVCZ
#else
                      FieldNo("Receivables Account"), "Receivables Account", false, false, GLAccountCategory."Account Category"::Assets, GLAccountCategoryMgt.GetAR);
#endif
#if not CLEAN18
                CheckOpenCustLedgEntries(false); // NAVCZ
#endif
            end;
        }
        field(7; "Service Charge Acc."; Code[20])
        {
            Caption = 'Service Charge Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Service Charge Acc.")
                else
                    LookupGLAccount(
#if not CLEAN19
                      "Service Charge Acc.", GLAccountCategory."Account Category"::Income,
                      GLAccountCategoryMgt.GetVIIOtherFinancialRevenues()); // NAVCZ
#else
                      "Service Charge Acc.", GLAccountCategory."Account Category"::Income, GLAccountCategoryMgt.GetIncomeService);
#endif

                Validate("Service Charge Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Service Charge Acc.", true, true)
                else
                    CheckGLAccount(
#if not CLEAN19
                      FieldNo("Service Charge Acc."), "Service Charge Acc.", true, true, GLAccountCategory."Account Category"::Income,
                      GLAccountCategoryMgt.GetVIIOtherFinancialRevenues()); // NAVCZ
#else
                      FieldNo("Service Charge Acc."), "Service Charge Acc.", true, true, GLAccountCategory."Account Category"::Income, GLAccountCategoryMgt.GetIncomeService);
#endif
            end;
        }
        field(8; "Payment Disc. Debit Acc."; Code[20])
        {
            Caption = 'Payment Disc. Debit Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Disc. Debit Acc.")
                else
                    LookupGLAccount("Payment Disc. Debit Acc.", GLAccountCategory."Account Category"::Expense, '');

                Validate("Payment Disc. Debit Acc.")
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Disc. Debit Acc.", false, false)
                else
                    CheckGLAccount(FieldNo("Payment Disc. Debit Acc."), "Payment Disc. Debit Acc.", false, false, GLAccountCategory."Account Category"::Expense, '');
            end;
        }
        field(9; "Invoice Rounding Account"; Code[20])
        {
            Caption = 'Invoice Rounding Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Invoice Rounding Account")
                else
                    LookupGLAccount("Invoice Rounding Account", GLAccountCategory."Account Category"::Income, '');

                Validate("Invoice Rounding Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Invoice Rounding Account", true, false)
                else
                    CheckGLAccount(FieldNo("Invoice Rounding Account"), "Invoice Rounding Account", true, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(10; "Additional Fee Account"; Code[20])
        {
            Caption = 'Additional Fee Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Additional Fee Account")
                else
                    LookupGLAccount("Additional Fee Account", GLAccountCategory."Account Category"::Income, '');

                Validate("Additional Fee Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Additional Fee Account", true, true)
                else
                    CheckGLAccount(FieldNo("Additional Fee Account"), "Additional Fee Account", true, true, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(11; "Interest Account"; Code[20])
        {
            Caption = 'Interest Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Interest Account")
                else
                    LookupGLAccount("Interest Account", GLAccountCategory."Account Category"::Income, '');

                Validate("Interest Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Interest Account", true, false)
                else
                    CheckGLAccount(FieldNo("Interest Account"), "Interest Account", true, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(12; "Debit Curr. Appln. Rndg. Acc."; Code[20])
        {
            Caption = 'Debit Curr. Appln. Rndg. Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Debit Curr. Appln. Rndg. Acc.")
                else
                    LookupGLAccount("Debit Curr. Appln. Rndg. Acc.", GLAccountCategory."Account Category"::Income, '');

                Validate("Debit Curr. Appln. Rndg. Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Debit Curr. Appln. Rndg. Acc.", false, false)
                else
                    CheckGLAccount(
                      FieldNo("Debit Curr. Appln. Rndg. Acc."), "Debit Curr. Appln. Rndg. Acc.", false, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(13; "Credit Curr. Appln. Rndg. Acc."; Code[20])
        {
            Caption = 'Credit Curr. Appln. Rndg. Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Credit Curr. Appln. Rndg. Acc.")
                else
                    LookupGLAccount("Credit Curr. Appln. Rndg. Acc.", GLAccountCategory."Account Category"::Income, '');

                Validate("Credit Curr. Appln. Rndg. Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Credit Curr. Appln. Rndg. Acc.", false, false)
                else
                    CheckGLAccount(
                      FieldNo("Credit Curr. Appln. Rndg. Acc."), "Credit Curr. Appln. Rndg. Acc.", false, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(14; "Debit Rounding Account"; Code[20])
        {
            Caption = 'Debit Rounding Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Debit Rounding Account")
                else
                    LookupGLAccount("Debit Rounding Account", GLAccountCategory."Account Category"::Income, '');

                Validate("Debit Rounding Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Debit Rounding Account", false, false)
                else
                    CheckGLAccount(
                      FieldNo("Debit Rounding Account"), "Debit Rounding Account", false, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(15; "Credit Rounding Account"; Code[20])
        {
            Caption = 'Credit Rounding Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Credit Rounding Account")
                else
                    LookupGLAccount("Credit Rounding Account", GLAccountCategory."Account Category"::Income, '');
                Validate("Credit Rounding Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Credit Rounding Account", false, false)
                else
                    CheckGLAccount(FieldNo("Credit Rounding Account"), "Credit Rounding Account", false, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(16; "Payment Disc. Credit Acc."; Code[20])
        {
            Caption = 'Payment Disc. Credit Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Disc. Credit Acc.")
                else
                    LookupGLAccount("Payment Disc. Credit Acc.", GLAccountCategory."Account Category"::Expense, '');

                Validate("Payment Disc. Credit Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Disc. Credit Acc.", false, false)
                else
                    CheckGLAccount(FieldNo("Payment Disc. Credit Acc."), "Payment Disc. Credit Acc.", false, false, GLAccountCategory."Account Category"::Expense, '');
            end;
        }
        field(17; "Payment Tolerance Debit Acc."; Code[20])
        {
            Caption = 'Payment Tolerance Debit Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Tolerance Debit Acc.")
                else
                    LookupGLAccount("Payment Tolerance Debit Acc.", GLAccountCategory."Account Category"::Expense, '');

                Validate("Payment Tolerance Debit Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Tolerance Debit Acc.", false, false)
                else
                    CheckGLAccount(
                      FieldNo("Payment Tolerance Debit Acc."), "Payment Tolerance Debit Acc.", false, false, GLAccountCategory."Account Category"::Expense, '');
            end;
        }
        field(18; "Payment Tolerance Credit Acc."; Code[20])
        {
            Caption = 'Payment Tolerance Credit Acc.';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Tolerance Credit Acc.")
                else
                    LookupGLAccount(
#if not CLEAN19
                      "Payment Tolerance Credit Acc.", GLAccountCategory."Account Category"::Expense, ''); // NAVCZ
#else
                      "Payment Tolerance Credit Acc.", GLAccountCategory."Account Category"::Expense, GLAccountCategoryMgt.GetInterestExpense);
#endif

                Validate("Payment Tolerance Credit Acc.");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Tolerance Credit Acc.", false, false)
                else
                    CheckGLAccount(
                      FieldNo("Payment Tolerance Credit Acc."), "Payment Tolerance Credit Acc.", false, false,
#if not CLEAN19
                      GLAccountCategory."Account Category"::Expense, ''); // NAVCZ
#else
                      GLAccountCategory."Account Category"::Expense, GLAccountCategoryMgt.GetInterestExpense);
#endif
            end;
        }
        field(19; "Add. Fee per Line Account"; Code[20])
        {
            Caption = 'Add. Fee per Line Account';
            TableRelation = "G/L Account";

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Add. Fee per Line Account")
                else
                    LookupGLAccount("Add. Fee per Line Account", GLAccountCategory."Account Category"::Income, '');

                Validate("Add. Fee per Line Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Add. Fee per Line Account", true, false)
                else
                    CheckGLAccount(FieldNo("Add. Fee per Line Account"), "Add. Fee per Line Account", true, false, GLAccountCategory."Account Category"::Income, '');
            end;
        }
        field(20; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(21; "View All Accounts on Lookup"; Boolean)
        {
            Caption = 'View All Accounts on Lookup';
        }
        field(31000; "Advance Account"; Code[20])
        {
            Caption = 'Advance Account';
            TableRelation = "G/L Account";
#if CLEAN19
            ObsoleteState = Removed;
#else
            ObsoleteState = Pending;
#endif
            ObsoleteReason = 'Replaced by Advance Payments Localization for Czech.';
            ObsoleteTag = '19.0';
#if not CLEAN19

            trigger OnLookup()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Advance Account")
                else
                    LookupGLAccount("Advance Account", GLAccountCategory."Account Category"::Liabilities,
                        GLAccountCategoryMgt.GetCII3ShorttermAdvancePaymentsReceived());

                Validate("Advance Account");
            end;

            trigger OnValidate()
            begin
                if "View All Accounts on Lookup" then
                    GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Advance Account", false, false)
                else
                    CheckGLAccount(FieldNo("Advance Account"), "Advance Account", false, false, GLAccountCategory."Account Category"::Liabilities,
                        GLAccountCategoryMgt.GetCII3ShorttermAdvancePaymentsReceived());
#if not CLEAN18

                CheckOpenCustLedgEntries(true);
#endif
            end;
#endif
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Code")
        {
        }
    }

    trigger OnDelete()
    begin
        CheckCustEntries;
#if not CLEAN18
        DeleteSubstPostingGroups; // NAVCZ
#endif
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLAccountCategory: Record "G/L Account Category";
        GLAccountCategoryMgt: Codeunit "G/L Account Category Mgt.";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        YouCannotDeleteErr: Label 'You cannot delete %1.', Comment = '%1 = Code';

    local procedure CheckCustEntries()
    var
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Customer.SetRange("Customer Posting Group", Code);
        if not Customer.IsEmpty() then
            Error(YouCannotDeleteErr, Code);

        CustLedgerEntry.SetRange("Customer Posting Group", Code);
        if not CustLedgerEntry.IsEmpty() then
            Error(YouCannotDeleteErr, Code);
    end;

    procedure GetReceivablesAccount() Result: Code[20]
    begin
        if "Receivables Account" = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Receivables Account"));

        Result := "Receivables Account";
        OnAfterGetReceivablesAccount(Rec, Result);
    end;

    procedure GetPmtDiscountAccount(Debit: Boolean): Code[20]
    begin
        if Debit then begin
            if "Payment Disc. Debit Acc." = '' then
                PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Payment Disc. Debit Acc."));

            exit("Payment Disc. Debit Acc.");
        end;
        if "Payment Disc. Credit Acc." = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Payment Disc. Credit Acc."));

        exit("Payment Disc. Credit Acc.");
    end;

    procedure GetPmtToleranceAccount(Debit: Boolean): Code[20]
    begin
        if Debit then begin
            if "Payment Tolerance Debit Acc." = '' then
                PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Payment Tolerance Debit Acc."));

            exit("Payment Tolerance Debit Acc.");
        end;
        if "Payment Tolerance Credit Acc." = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Payment Tolerance Credit Acc."));

        exit("Payment Tolerance Credit Acc.");
    end;

    procedure GetRoundingAccount(Debit: Boolean): Code[20]
    begin
        if Debit then begin
            if "Debit Rounding Account" = '' then
                PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Debit Rounding Account"));

            exit("Debit Rounding Account");
        end;
        if "Credit Rounding Account" = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Credit Rounding Account"));

        exit("Credit Rounding Account");
    end;

    procedure GetApplRoundingAccount(Debit: Boolean): Code[20]
    begin
        if Debit then begin
            if "Debit Curr. Appln. Rndg. Acc." = '' then
                PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Debit Curr. Appln. Rndg. Acc."));

            exit("Debit Curr. Appln. Rndg. Acc.");
        end;
        if "Credit Curr. Appln. Rndg. Acc." = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Credit Curr. Appln. Rndg. Acc."));

        exit("Credit Curr. Appln. Rndg. Acc.");
    end;

    procedure GetInvRoundingAccount(): Code[20]
    var
        GLAccount: Record "G/L Account";
    begin
        if "Invoice Rounding Account" <> '' then begin
            GLAccount.Get("Invoice Rounding Account");
            GLAccount.CheckGenProdPostingGroup();
        end else
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Invoice Rounding Account"));

        exit("Invoice Rounding Account");
    end;

    procedure GetServiceChargeAccount(): Code[20]
    begin
        if "Service Charge Acc." = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Service Charge Acc."));

        exit("Service Charge Acc.");
    end;

    procedure GetAdditionalFeeAccount(): Code[20]
    begin
        if "Additional Fee Account" = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Additional Fee Account"));

        exit("Additional Fee Account");
    end;

    procedure GetAddFeePerLineAccount(): Code[20]
    begin
        if "Add. Fee per Line Account" = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Add. Fee per Line Account"));

        exit("Add. Fee per Line Account");
    end;

    procedure GetInterestAccount(): Code[20]
    begin
        if "Interest Account" = '' then
            PostingSetupMgt.LogCustPostingGroupFieldError(Rec, FieldNo("Interest Account"));

        exit("Interest Account");
    end;

    procedure SetAccountVisibility(var PmtToleranceVisible: Boolean; var PmtDiscountVisible: Boolean; var InvRoundingVisible: Boolean; var ApplnRoundingVisible: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        PaymentTerms: Record "Payment Terms";
    begin
        GLSetup.Get();
        PmtToleranceVisible := GLSetup.GetPmtToleranceVisible;
        PmtDiscountVisible := PaymentTerms.UsePaymentDiscount;

        SalesSetup.Get();
        InvRoundingVisible := SalesSetup."Invoice Rounding";
        ApplnRoundingVisible := SalesSetup."Appln. between Currencies" <> SalesSetup."Appln. between Currencies"::None;
    end;

#if not CLEAN18
    [Scope('OnPrem')]
    [Obsolete('Moved to Core Localization Pack for Czech.', '18.0')]
    procedure GetReceivablesAccNo(PostingGroupCode: Code[20]; Advance: Boolean): Code[20]
    begin
        // NAVCZ
        Get(PostingGroupCode);
        if Advance then begin
            if "Advance Account" = '' then
                PostingSetupMgt.SendCustPostingGroupNotification(Rec, FieldCaption("Advance Account"));
            TestField("Advance Account");
            exit("Advance Account");
        end;
        if "Receivables Account" = '' then
            PostingSetupMgt.SendCustPostingGroupNotification(Rec, FieldCaption("Receivables Account"));
        TestField("Receivables Account");
        exit("Receivables Account");
    end;

    [Scope('OnPrem')]
    [Obsolete('Moved to Core Localization Pack for Czech.', '18.0')]
    procedure DeleteSubstPostingGroups()
    var
        SubstCustPostingGroup: Record "Subst. Customer Posting Group";
    begin
        // NAVCZ
        SubstCustPostingGroup.SetRange("Parent Cust. Posting Group", Code);
        SubstCustPostingGroup.DeleteAll();
        SubstCustPostingGroup.Reset();
        SubstCustPostingGroup.SetRange("Customer Posting Group", Code);
        SubstCustPostingGroup.DeleteAll();
    end;

    [Obsolete('Moved to Core Localization Pack for Czech.', '18.0')]
    local procedure CheckOpenCustLedgEntries(Prepayment1: Boolean)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ConfirmManagement: Codeunit "Confirm Management";
        Caption1: Text[250];
        ChangeText: Label 'Do you really want to change %1 although open entries exist?';
        IsHandled: Boolean;
    begin
        // NAVCZ
        IsHandled := false;
        OnBeforeCheckOpenCustLedgEntries(Prepayment1, IsHandled);
        if IsHandled then
            exit;

        CustLedgerEntry.SetCurrentKey(Open);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetRange("Customer Posting Group", Code);
        CustLedgerEntry.SetRange(Prepayment, Prepayment1);
        if not CustLedgerEntry.IsEmpty() then begin
            if Prepayment1 then
                Caption1 := FieldCaption("Advance Account")
            else
                Caption1 := FieldCaption("Receivables Account");
            if not ConfirmManagement.GetResponse(StrSubstNo(ChangeText, Caption1), false) then
                Error('');
        end;
    end;

    [Obsolete('Moved to Core Localization Pack for Czech.', '18.0')]
    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckOpenCustLedgEntries(var Prepayment1: Boolean; var IsHandled: Boolean);
    begin
    end;
#endif

    local procedure CheckGLAccount(ChangedFieldNo: Integer; AccNo: Code[20]; CheckProdPostingGroup: Boolean; CheckDirectPosting: Boolean; AccountCategory: Option; AccountSubcategory: Text)
    begin
        GLAccountCategoryMgt.CheckGLAccount(Database::"Customer Posting Group", ChangedFieldNo, AccNo, CheckProdPostingGroup, CheckDirectPosting, AccountCategory, AccountSubcategory);
    end;

    local procedure LookupGLAccount(var AccountNo: Code[20]; AccountCategory: Option; AccountSubcategoryFilter: Text)
    begin
        GLAccountCategoryMgt.LookupGLAccount(Database::"Customer Posting Group", CurrFieldNo, AccountNo, AccountCategory, AccountSubcategoryFilter);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetReceivablesAccount(var CustomerPostingGroup: Record "Customer Posting Group"; var Result: Code[20])
    begin
    end;
}

