codeunit 50121 "Diagnostics Sales Sync"
{
    procedure Run(var DiagnosticsHeader: Record "Diagnostics Header")
    var
        Patient: Record Patient;
        SalesHeader: Record "Sales Header";
        DiagnosticsLine: Record "Diagnostics Line";
        SalesLine: Record "Sales Line";
    begin
        Patient.Get(DiagnosticsHeader."Patient No.");
        Patient.TestField("Customer No.");

        if DiagnosticsHeader."Sales Order No." <> '' then
            Error('A Sales Order has already been created.');

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", Patient."Customer No.");
        SalesHeader.Validate("External Document No.", DiagnosticsHeader."Document No.");

        SalesHeader.Modify(true);

        DiagnosticsHeader."Sales Order No." := SalesHeader."No.";
        DiagnosticsHeader.Modify(true);

        DiagnosticsLine.SetRange("Document No.", DiagnosticsHeader."Document No.");

        if DiagnosticsLine.FindSet() then
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := DiagnosticsLine."Line No.";

                if DiagnosticsLine.Type = DiagnosticsLine.Type::Drug then begin
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", DiagnosticsLine."Test No.");
                end;

                SalesLine.Insert(true);

            until DiagnosticsLine.Next() = 0;
    end;
}