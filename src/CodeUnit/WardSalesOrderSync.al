codeunit 50124 "Ward Sales Order Sync"
{
    procedure Run(var Ward: Record Ward)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        // Validate required Ward fields
        Ward.TestField("G/L Account No.");
        Ward.TestField("Order Quantity");

        // Create Sales Header
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Insert(true);

        // Create Sales Line
        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", 10000);

        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", Ward."G/L Account No.");
        SalesLine.Validate(Description, StrSubstNo('Ward stay - %1', Ward.Description));
        SalesLine.Validate(Quantity, Ward."Order Quantity");

        if Ward."Location Code" <> '' then
            SalesLine.Validate("Location Code", Ward."Location Code");

        SalesLine.Insert(true);
    end;
}