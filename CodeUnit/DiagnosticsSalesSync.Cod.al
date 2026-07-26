codeunit 50121 "Diagnostics Sales Sync"
{
    procedure Run(var DiagnosticsHeader: Record "Diagnostics Header")
    var
        Patient: Record Patient;
        SalesHeader: Record "Sales Header";
    begin
        Patient.Get(DiagnosticsHeader."Patient No.");
        Patient.TestField("Customer No.");

        // Create Sales Order if one does not exist
        if DiagnosticsHeader."Sales Order No." = '' then begin

            SalesHeader.Init();
            SalesHeader.Validate(
                "Document Type",
                SalesHeader."Document Type"::Order);

            SalesHeader.Insert(true);

            SalesHeader.Validate(
                "Sell-to Customer No.",
                Patient."Customer No.");

            SalesHeader.Validate(
                "External Document No.",
                DiagnosticsHeader."Document No.");

            SalesHeader.Modify(true);

            DiagnosticsHeader."Sales Order No." := SalesHeader."No.";
            DiagnosticsHeader.Modify(true);

        end
        else begin

            SalesHeader.Get(
                SalesHeader."Document Type"::Order,
                DiagnosticsHeader."Sales Order No.");

        end;


        // Sync diagnostics lines
        SyncSalesLines(
            DiagnosticsHeader,
            SalesHeader);
    end;



    local procedure SyncSalesLines(
        DiagnosticsHeader: Record "Diagnostics Header";
        SalesHeader: Record "Sales Header")
    var
        DiagnosticsLine: Record "Diagnostics Line";
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
    begin

        NextLineNo := GetLastSalesLineNo(SalesHeader);


        DiagnosticsLine.SetRange(
            "Document No.",
            DiagnosticsHeader."Document No.");


        if DiagnosticsLine.FindSet() then begin

            repeat

                // Prevent duplicates
                if not SalesLineExists(
                    SalesHeader,
                    DiagnosticsLine) then begin


                    NextLineNo += 10000;


                    SalesLine.Init();

                    SalesLine.Validate(
                        "Document Type",
                        SalesHeader."Document Type");


                    SalesLine.Validate(
                        "Document No.",
                        SalesHeader."No.");


                    SalesLine.Validate(
                        "Line No.",
                        NextLineNo);



                    case DiagnosticsLine.Type of


                        DiagnosticsLine.Type::Drug,
                        DiagnosticsLine.Type::Others:

                            begin
                                SalesLine.Validate(
                                    Type,
                                    SalesLine.Type::Item);

                                SalesLine.Validate(
                                    "No.",
                                    DiagnosticsLine."Test No.");
                            end;



                        DiagnosticsLine.Type::Diagnosis,
                        DiagnosticsLine.Type::Ward:

                            begin
                                SalesLine.Validate(
                                    Type,
                                    SalesLine.Type::"G/L Account");

                                SalesLine.Validate(
                                    "No.",
                                    DiagnosticsLine."Test No.");
                            end;

                    end;



                    SalesLine.Validate(
                        Description,
                        DiagnosticsLine.Description);


                    SalesLine.Validate(
                        Quantity,
                        DiagnosticsLine.Quantity);


                    SalesLine.Validate(
                        "Unit Price",
                        DiagnosticsLine."Unit Price");


                    SalesLine.Insert(true);

                end;


            until DiagnosticsLine.Next() = 0;

        end;

    end;




    local procedure GetLastSalesLineNo(
        SalesHeader: Record "Sales Header"): Integer

    var
        SalesLine: Record "Sales Line";

    begin

        SalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");


        SalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");


        if SalesLine.FindLast() then
            exit(SalesLine."Line No.");

        exit(0);

    end;





    local procedure SalesLineExists(
        SalesHeader: Record "Sales Header";
        DiagnosticsLine: Record "Diagnostics Line"): Boolean

    var
        SalesLine: Record "Sales Line";

    begin

        SalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");


        SalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");


        SalesLine.SetRange(
            Description,
            DiagnosticsLine.Description);


        exit(SalesLine.FindFirst());

    end;
}