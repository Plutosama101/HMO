codeunit 50115 "Diagnostics Invoice Sync"
{
    procedure Run(var DiagnosticsHeader: Record "Diagnostics Header")
    var
        Patient: Record Patient;
        DiagnosticsLine: Record "Diagnostics Line";
        DiagnosisDescription: Record "Diagnosis Description";
        Ward: Record Ward;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        Patient.Get(DiagnosticsHeader."Patient No.");
        Patient.TestField("Customer No.");

        if DiagnosticsHeader."Invoice No." = '' then begin
            SalesHeader.Init();
            SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
            SalesHeader.Insert(true);
            SalesHeader.Validate("Sell-to Customer No.", Patient."Customer No.");
            SalesHeader.Modify(true);

            DiagnosticsHeader."Invoice No." := SalesHeader."No.";
            DiagnosticsHeader.Modify(true);
        end else
            SalesHeader.Get(SalesHeader."Document Type"::Invoice, DiagnosticsHeader."Invoice No.");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.DeleteAll(true);

        LineNo := 0;

        DiagnosticsLine.SetRange("Document No.", DiagnosticsHeader."Document No.");

        if DiagnosticsLine.FindSet() then
            repeat
                LineNo += 10000;

                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;

                case DiagnosticsLine.Type of

                    DiagnosticsLine.Type::Diagnosis:
                        begin
                            DiagnosisDescription.Get(DiagnosticsLine."Test No.");
                            DiagnosisDescription.TestField("G/L Account No.");

                            SalesLine.Type := SalesLine.Type::"G/L Account";
                            SalesLine.Validate("No.", DiagnosisDescription."G/L Account No.");
                            SalesLine.Validate(Quantity, DiagnosticsLine.Quantity);
                            SalesLine.Validate("Unit Price", DiagnosticsLine."Unit Price");
                        end;

                    DiagnosticsLine.Type::Drug:
                        begin
                            Item.Get(DiagnosticsLine."Test No.");

                            SalesLine.Type := SalesLine.Type::Item;
                            SalesLine.Validate("No.", Item."No.");
                            SalesLine.Validate(Quantity, DiagnosticsLine.Quantity);
                        end;

                    DiagnosticsLine.Type::Ward:
                        begin
                            Ward.Get(DiagnosticsLine."Test No.");
                            Ward.TestField("G/L Account No.");

                            SalesLine.Type := SalesLine.Type::"G/L Account";
                            SalesLine.Validate("No.", Ward."G/L Account No.");
                            SalesLine.Validate(Quantity, DiagnosticsLine.Quantity);
                            SalesLine.Validate("Unit Price", DiagnosticsLine."Unit Price");
                        end;

                    DiagnosticsLine.Type::Others:
                        begin
                            SalesLine.Type := SalesLine.Type::"G/L Account";
                            SalesLine.Validate("No.", DiagnosticsLine."Test No.");
                            SalesLine.Validate(Quantity, DiagnosticsLine.Quantity);
                            SalesLine.Validate("Unit Price", DiagnosticsLine."Unit Price");
                        end;
                end;

                SalesLine.Insert(true);

            until DiagnosticsLine.Next() = 0;
    end;
}