table 50105 "Diagnostics Line"
{
    Caption = 'Diagnostics Line';
    TableType = Normal;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Diagnostics Header"."Document No.";
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(3; Type; Enum "Diagnosis Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Clear("Test No.");
                Clear(Description);
                Clear("Unit Price");
                Clear(Amount);
            end;
        }

        field(4; "Test No."; Code[20])
        {
            Caption = 'Test No.';
            DataClassification = CustomerContent;

            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const(Diagnosis)) "Diagnosis Description"
            else
            if (Type = const(Drug)) Item
            else
            if (Type = const(Ward)) Ward
            else
            if (Type = const(Others)) Item;


            trigger OnValidate()
            var
                DiagnosisDescription: Record "Diagnosis Description";
                Item: Record Item;
                Ward: Record Ward;
            begin

                case Type of

                    Type::Diagnosis:
                        begin
                            if DiagnosisDescription.Get("Test No.") then begin
                                Description := DiagnosisDescription.Description;
                                "Unit Price" := DiagnosisDescription."Unit Price";
                            end;
                        end;


                    Type::Drug:
                        begin
                            if Item.Get("Test No.") then begin
                                Description := Item.Description;
                                "Unit Price" := Item."Unit Price";
                            end;
                        end;


                    Type::Ward:
                        begin
                            if Ward.Get("Test No.") then begin
                                Description := Ward.Description;
                                "Unit Price" := Ward."Unit Price";
                            end;
                        end;


                    Type::Others:
                        begin
                            if Item.Get("Test No.") then begin
                                Description := Item.Description;
                                "Unit Price" := Item."Unit Price";
                            end;
                        end;

                end;


                CalculateAmount();

            end;
        }


        field(5; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
            DataClassification = CustomerContent;
        }


        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 2;
            MinValue = 1;
            InitValue = 1;
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }


        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            Editable = false;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }


        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

    }


    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        DiagnosticsHeader: Record "Diagnostics Header";
        DiagnosticsSalesSync: Codeunit "Diagnostics Sales Sync";
    begin

        if Quantity = 0 then
            Quantity := 1;


        CalculateAmount();


        // Automatically update Sales Order
        if DiagnosticsHeader.Get("Document No.") then
            DiagnosticsSalesSync.Run(DiagnosticsHeader);

    end;



    local procedure CalculateAmount()
    begin
        Amount := Quantity * "Unit Price";
    end;

}