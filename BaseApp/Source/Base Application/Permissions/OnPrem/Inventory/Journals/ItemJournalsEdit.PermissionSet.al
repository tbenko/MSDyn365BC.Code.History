permissionset 3627 "Item Journals - Edit"
{
    Access = Public;
    Assignable = false;
    Caption = 'Create entries in item jnls.';

    Permissions = tabledata Bin = R,
                  tabledata "Comment Line" = R,
                  tabledata "Country/Region" = R,
                  tabledata "Default Dimension" = R,
                  tabledata "Default Dimension Priority" = R,
                  tabledata "Entry Summary" = RIMD,
                  tabledata "Gen. Business Posting Group" = R,
                  tabledata "Gen. Product Posting Group" = R,
                  tabledata "General Ledger Setup" = R,
                  tabledata "General Posting Setup" = R,
                  tabledata "Inventory Posting Group" = R,
                  tabledata "Inventory Posting Setup" = R,
                  tabledata Item = R,
                  tabledata "Item Journal Batch" = RI,
                  tabledata "Item Journal Line" = RIMD,
                  tabledata "Item Journal Template" = RI,
                  tabledata "Item Ledger Entry" = Rm,
                  tabledata "Item Tracking Code" = R,
                  tabledata "Item Tracking Comment" = RIMD,
                  tabledata "Item Unit of Measure" = R,
                  tabledata "Item Variant" = R,
                  tabledata Location = R,
                  tabledata "Lot No. Information" = RIMD,
                  tabledata "Package No. Information" = RIMD,
                  tabledata "Phys. Invt. Counting Period" = RIMD,
                  tabledata "Phys. Invt. Item Selection" = RIMD,
                  tabledata "Planning Component" = Rm,
                  tabledata "Prod. Order Component" = Rm,
                  tabledata "Prod. Order Line" = Rm,
                  tabledata "Purchase Line" = Rm,
                  tabledata "Reason Code" = R,
                  tabledata "Requisition Line" = Rim,
                  tabledata "Reservation Entry" = Rimd,
                  tabledata "Sales Line" = Rm,
                  tabledata "Salesperson/Purchaser" = R,
                  tabledata "Serial No. Information" = RIMD,
                  tabledata "Source Code Setup" = R,
                  tabledata "Stockkeeping Unit" = R,
                  tabledata "Tracking Specification" = Rimd,
                  tabledata "Transaction Type" = R,
                  tabledata "Transport Method" = R,
                  tabledata "Unit of Measure" = R,
                  tabledata "Value Entry" = Rm,
                  tabledata "VAT Assisted Setup Bus. Grp." = R,
                  tabledata "VAT Assisted Setup Templates" = R,
                  tabledata "VAT Business Posting Group" = R,
                  tabledata "VAT Posting Setup" = R,
                  tabledata "VAT Product Posting Group" = R,
                  tabledata "VAT Rate Change Conversion" = R,
                  tabledata "VAT Rate Change Log Entry" = Ri,
                  tabledata "VAT Rate Change Setup" = R,
#if CLEAN17
                  tabledata "VAT Setup Posting Groups" = R;
#else
                  tabledata "VAT Setup Posting Groups" = R,
                  tabledata "Whse. Net Change Template" = R;
#endif
}
