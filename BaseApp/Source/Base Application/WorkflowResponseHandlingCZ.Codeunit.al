#if not CLEAN19
codeunit 31111 "Workflow Response Handling CZ"
{
    ObsoleteState = Pending;
    ObsoleteReason = 'The codeunit is replaced by codeunits in CZ applications.';
    ObsoleteTag = '19.0';

    trigger OnRun()
    begin
    end;

    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowEventHandlingCZ: Codeunit "Workflow Event Handling CZ";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SetStatusToApprovedTxt: Label 'Set document status to Approved (Obsolete)';
        CheckReleaseDocumentTxt: Label 'Check release the document (Obsolete)';
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToApprovedCode, 0, SetStatusToApprovedTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(CheckReleaseDocumentCode, 0, CheckReleaseDocumentTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    begin
        case ResponseFunctionName of
            SetStatusToApprovedCode:
                WorkflowResponseHandling.AddResponsePredecessor(
                  SetStatusToApprovedCode,
                  WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode);
#if not CLEAN17
            CheckReleaseDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(
                  CheckReleaseDocumentCode,
                  WorkflowEventHandlingCZ.RunWorkflowOnSendCashDocForApprovalCode);
#endif
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPaymentOrderForApprovalCode);
#if not CLEAN17
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCashDocForApprovalCode);
#endif
#if not CLEAN18
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCreditDocForApprovalCode);
#endif
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendSalesAdvanceLetterForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPurchaseAdvanceLetterForApprovalCode);
                end;
            WorkflowResponseHandling.CreateApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CreateApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPaymentOrderForApprovalCode);
#if not CLEAN17
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CreateApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCashDocForApprovalCode);
#endif
#if not CLEAN18
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CreateApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCreditDocForApprovalCode);
#endif
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CreateApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendSalesAdvanceLetterForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CreateApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPurchaseAdvanceLetterForApprovalCode);
                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPaymentOrderForApprovalCode);
#if not CLEAN17
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCashDocForApprovalCode);
#endif
#if not CLEAN18
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendCreditDocForApprovalCode);
#endif
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendSalesAdvanceLetterForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnSendPurchaseAdvanceLetterForApprovalCode);
                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.OpenDocumentCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelPaymentOrderApprovalRequestCode);
#if not CLEAN17
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.OpenDocumentCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelCashDocApprovalRequestCode);
#endif
#if not CLEAN18
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.OpenDocumentCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelCreditApprovalRequestCode);
#endif
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.OpenDocumentCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelSalesAdvanceLetterApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.OpenDocumentCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelPurchaseAdvanceLetterApprovalRequestCode);
                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelPaymentOrderApprovalRequestCode);
#if not CLEAN17
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelCashDocApprovalRequestCode);
#endif
#if not CLEAN18
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelCreditApprovalRequestCode);
#endif
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelSalesAdvanceLetterApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                      WorkflowEventHandlingCZ.RunWorkflowOnCancelPurchaseAdvanceLetterApprovalRequestCode);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure ExecuteWorkflowResponse(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    begin
        case ResponseWorkflowStepInstance."Function Name" of
            SetStatusToApprovedCode:
                begin
                    SetStatusToApproved(Variant);
                    ResponseExecuted := true;
                end;
#if not CLEAN17
            CheckReleaseDocumentCode:
                begin
                    CheckReleaseDocument(Variant);
                    ResponseExecuted := true;
                end;
#endif
        end;
    end;

    [Scope('OnPrem')]
    procedure SetStatusToApprovedCode(): Code[128]
    begin
        exit(UpperCase('SetStatusToApproved'));
    end;

    [Scope('OnPrem')]
    procedure CheckReleaseDocumentCode(): Code[128]
    begin
        exit(UpperCase('CheckReleaseDocument'));
    end;

    local procedure SetStatusToApproved(var Variant: Variant)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.SetStatusToApproved(Variant);
    end;
#if not CLEAN17

    local procedure CheckReleaseDocument(var Variant: Variant)
    var
        CashDocumentHeader: Record "Cash Document Header";
        CashDocumentRelease: Codeunit "Cash Document-Release";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            DATABASE::"Cash Document Header":
                begin
                    CashDocumentHeader := Variant;
                    CashDocumentRelease.CheckCashDocument(CashDocumentHeader);
                end;
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;
#endif
}

#endif