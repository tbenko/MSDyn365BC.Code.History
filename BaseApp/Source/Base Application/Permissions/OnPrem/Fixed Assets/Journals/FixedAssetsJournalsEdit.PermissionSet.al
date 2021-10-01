permissionset 505 "Fixed Assets Journals - Edit"
{
    Access = Public;
    Assignable = false;
    Caption = 'Create entries in FA journals';

    Permissions = tabledata "Bank Account" = R,
                  tabledata Currency = R,
                  tabledata "Currency Exchange Rate" = R,
                  tabledata Customer = R,
                  tabledata "Default Dimension" = R,
                  tabledata "Default Dimension Priority" = R,
#if not CLEAN18
                  tabledata "Depreciation Group" = R,
#endif
                  tabledata "Depreciation Table Header" = R,
                  tabledata "Depreciation Table Line" = R,
                  tabledata "FA Allocation" = R,
                  tabledata "FA Class" = R,
                  tabledata "FA Depreciation Book" = R,
#if not CLEAN18
                  tabledata "FA Extended Posting Group" = R,
                  tabledata "FA History Entry" = Rim,
#endif
                  tabledata "FA Journal Batch" = RI,
                  tabledata "FA Journal Line" = RIMD,
                  tabledata "FA Journal Setup" = R,
                  tabledata "FA Journal Template" = RI,
                  tabledata "FA Ledger Entry" = R,
                  tabledata "FA Location" = R,
                  tabledata "FA Posting Group" = R,
                  tabledata "FA Posting Type Setup" = R,
                  tabledata "FA Reclass. Journal Batch" = RI,
                  tabledata "FA Reclass. Journal Line" = RIMD,
                  tabledata "FA Reclass. Journal Template" = RI,
                  tabledata "FA Subclass" = R,
                  tabledata "Fixed Asset" = R,
                  tabledata "G/L Account" = R,
                  tabledata "Gen. Business Posting Group" = R,
                  tabledata "Gen. Jnl. Allocation" = RIMD,
                  tabledata "Gen. Journal Batch" = RI,
                  tabledata "Gen. Journal Line" = RIMD,
                  tabledata "Gen. Journal Template" = RI,
                  tabledata "Gen. Product Posting Group" = R,
                  tabledata "General Ledger Setup" = RM,
                  tabledata "General Posting Setup" = R,
                  tabledata "Ins. Coverage Ledger Entry" = R,
                  tabledata Insurance = R,
                  tabledata "Main Asset Component" = R,
                  tabledata Maintenance = R,
                  tabledata "Maintenance Ledger Entry" = R,
                  tabledata "Maintenance Registration" = R,
                  tabledata "Native - Payment" = RIMD,
                  tabledata "Reason Code" = R,
                  tabledata "Source Code Setup" = R,
                  tabledata "Tax Area" = R,
                  tabledata "Tax Area Line" = R,
                  tabledata "Tax Detail" = R,
                  tabledata "Tax Group" = R,
                  tabledata "Tax Jurisdiction" = R,
                  tabledata "VAT Assisted Setup Bus. Grp." = R,
                  tabledata "VAT Assisted Setup Templates" = R,
                  tabledata "VAT Business Posting Group" = R,
                  tabledata "VAT Posting Setup" = R,
                  tabledata "VAT Product Posting Group" = R,
                  tabledata "VAT Rate Change Conversion" = R,
                  tabledata "VAT Rate Change Log Entry" = Ri,
                  tabledata "VAT Rate Change Setup" = R,
                  tabledata "VAT Setup Posting Groups" = R,
                  tabledata Vendor = R;
}
