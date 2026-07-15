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
        }

        field(4; "Test No."; Code[20])
        {
            Caption = 'Test No.';
            TableRelation = "Diagnosis Description".Code;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                DiagnosisDescription: Record "Diagnosis Description";
            begin
                if DiagnosisDescription.Get("Test No.") then begin
                    Description := DiagnosisDescription.Description;
                    "Unit Price" := DiagnosisDescription."Unit Price";
                    CalculateAmount();
                end;
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
    begin
        if Quantity = 0 then
            Quantity := 1;
    end;

    trigger OnModify()
    begin
        UpdateHeaderTotal();
    end;

    trigger OnDelete()
    begin
        UpdateHeaderTotal();
    end;

    local procedure CalculateAmount()
    begin
        Amount := Quantity * "Unit Price";
        UpdateHeaderTotal();
    end;

    local procedure UpdateHeaderTotal()
    var
        DiagnosticsHeader: Record "Diagnostics Header";
    begin
        if DiagnosticsHeader.Get("Document No.") then
            DiagnosticsHeader.UpdateTotalAmount();
    end;
}