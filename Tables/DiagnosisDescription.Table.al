table 50103 "Diagnosis Description"
{
    Caption = 'Diagnosis Description';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Diagnosis Description List";
    LookupPageID = "Diagnosis Description List";

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
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
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

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, Type)
        {
        }
    }
}