table 50107 Drug
{
    Caption = 'Drug';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(3; "Item No"; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
            Editable = false;
        }

        field(4; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }

        field(5; "Reorder Quantity"; Integer)
        {
            Caption = 'Reorder Quantity';
            DataClassification = CustomerContent;
        }

        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if Code = '' then begin
            HospitalSetup.Get('SETUP');
            HospitalSetup.TestField("Drug Nos.");

            "No. Series" := HospitalSetup."Drug Nos.";
            Code := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    var
        NoSeries: Codeunit "No. Series";
}