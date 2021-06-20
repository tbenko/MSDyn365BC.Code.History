table 11504 "Swiss QRBill Billing Info"
{
    ObsoleteState = Removed;
    ObsoleteReason = 'moved to Swiss QR-Bill extension table 11511 Swiss QR-Bill Billing Info';

    fields
    {
        field(1; "Code"; Code[20]) { }
        field(2; "Document No."; Boolean) { }
        field(3; "Document Date"; Boolean) { }
        field(5; "VAT Number"; Boolean) { }
        field(6; "VAT Date"; Boolean) { }
        field(7; "VAT Details"; Boolean) { }
        field(9; "Payment Terms"; Boolean) { }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}