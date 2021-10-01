permissionset 8823 "Item Journals - Post"
{
    Access = Public;
    Assignable = false;
    Caption = 'Post item journals';

    Permissions = tabledata "Accounting Period" = R,
                  tabledata "Avg. Cost Adjmt. Entry Point" = Ri,
                  tabledata "Dimension Combination" = R,
                  tabledata "Dimension Value Combination" = R,
                  tabledata "Gen. Business Posting Group" = R,
                  tabledata "Gen. Product Posting Group" = R,
                  tabledata "General Ledger Setup" = R,
                  tabledata "Invt. Document Header" = RIMD,
                  tabledata "Invt. Document Line" = RIMD,
                  tabledata "Invt. Receipt Header" = Ri,
                  tabledata "Invt. Receipt Line" = Ri,
                  tabledata "Invt. Shipment Header" = Ri,
                  tabledata "Invt. Shipment Line" = Ri,
                  tabledata Item = Rm,
                  tabledata "Item Application Entry" = Ri,
                  tabledata "Item Journal Batch" = RID,
                  tabledata "Item Journal Line" = RIMD,
                  tabledata "Item Journal Template" = RI,
                  tabledata "Item Ledger Entry" = Rim,
                  tabledata "Item Register" = Rim,
                  tabledata "Item Tracking Code" = R,
                  tabledata "Item Tracking Comment" = RIMD,
                  tabledata "Item Unit of Measure" = R,
                  tabledata "Item Variant" = R,
                  tabledata "Lot No. Information" = R,
                  tabledata "Package No. Information" = R,
                  tabledata "Phys. Invt. Counting Period" = RIMD,
                  tabledata "Phys. Invt. Item Selection" = RIMD,
                  tabledata "Planning Component" = Rm,
                  tabledata "Prod. Order Component" = Rm,
                  tabledata "Prod. Order Line" = Rm,
                  tabledata "Serial No. Information" = R,
                  tabledata "Stockkeeping Unit" = R,
                  tabledata "Unit of Measure" = R,
                  tabledata "User Setup" = R,
                  tabledata "Value Entry" = Rim,
                  tabledata "VAT Business Posting Group" = R,
#if not CLEAN17
                  tabledata "VAT Period" = R,
#endif
                  tabledata "VAT Product Posting Group" = R,
                  tabledata "VAT Rate Change Conversion" = R,
                  tabledata "VAT Rate Change Log Entry" = Ri,
#if CLEAN17
                  tabledata "Warehouse Register" = r;
#else
                  tabledata "Warehouse Register" = r,
                  tabledata "Whse. Net Change Template" = R;
#endif                  
}
