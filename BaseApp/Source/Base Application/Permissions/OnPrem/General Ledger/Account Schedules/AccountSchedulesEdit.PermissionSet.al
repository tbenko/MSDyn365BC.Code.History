permissionset 3632 "Account Schedules - Edit"
{
    Access = Public;
    Assignable = false;
    Caption = 'Edit account schedules';

    Permissions = tabledata "Acc. Sched. Chart Setup Line" = RIMD,
                  tabledata "Acc. Sched. Expression Buffer" = RIMD,
                  tabledata "Acc. Schedule Extension" = RIMD,
                  tabledata "Acc. Schedule Filter Line" = RIMD,
                  tabledata "Acc. Schedule Line" = RIMD,
                  tabledata "Acc. Schedule Name" = RIMD,
                  tabledata "Acc. Schedule Result Column" = RIMD,
                  tabledata "Acc. Schedule Result Header" = RIMD,
                  tabledata "Acc. Schedule Result History" = RIMD,
                  tabledata "Acc. Schedule Result Line" = RIMD,
                  tabledata "Acc. Schedule Result Value" = RIMD,
                  tabledata "Account Schedules Chart Setup" = RIMD,
                  tabledata "Analysis View" = R,
                  tabledata "Analysis View Budget Entry" = R,
                  tabledata "Analysis View Entry" = R,
                  tabledata "Business Unit" = R,
                  tabledata "Business Unit Information" = R,
                  tabledata "Business Unit Setup" = R,
                  tabledata "Column Layout" = RIMD,
                  tabledata "Column Layout Name" = RIMD,
                  tabledata Dimension = R,
                  tabledata "Dimension Value" = R,
                  tabledata "Excel Template" = RIMD,
                  tabledata "Export Acc. Schedule" = RIMD,
                  tabledata "G/L Account Category" = RIMD,
                  tabledata "G/L Budget Name" = RI,
                  tabledata "Statement File Mapping" = RIMD;
}