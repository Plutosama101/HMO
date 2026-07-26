table 50115 "Diagnosis Description 1"
{
    Caption = 'Diagnosis Description';
    TableType = Normal;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }

        field(2; Type; Enum "Diagnosis Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
        }

        field(6; Treatment; Text[250])
        {
            Caption = 'Treatment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}