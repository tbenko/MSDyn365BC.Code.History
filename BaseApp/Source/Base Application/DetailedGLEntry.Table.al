table 11778 "Detailed G/L Entry"
{
    Caption = 'Detailed G/L Entry';
#if CLEAN19
    ObsoleteState = Removed;
#else
    ObsoleteState = Pending;
#endif
    ObsoleteReason = 'Moved to Advanced Localization Pack for Czech.';
    ObsoleteTag = '19.0';

    DataCaptionFields = "G/L Account No.";
#if not CLEAN19
    DrillDownPageID = "Detailed G/L Entries";
    LookupPageID = "Detailed G/L Entries";
#endif

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            NotBlank = true;
        }
        field(2; "G/L Entry No."; Integer)
        {
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry"."Entry No.";
        }
        field(3; "Applied G/L Entry No."; Integer)
        {
            Caption = 'Applied G/L Entry No.';
            TableRelation = "G/L Entry"."Entry No.";
        }
        field(4; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; Unapplied; Boolean)
        {
            Caption = 'Unapplied';
        }
        field(10; "Unapplied by Entry No."; Integer)
        {
            Caption = 'Unapplied by Entry No.';
#if not CLEAN19
            TableRelation = "Detailed G/L Entry";
#endif
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "G/L Entry No.", "Posting Date")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

