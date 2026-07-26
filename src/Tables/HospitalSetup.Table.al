table 50110 "Hospital Setup"
{
    Caption = 'Hospital Setup';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Hospital Setup";
    LookupPageID = "Hospital Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }

        field(2; "Staff Nos."; Code[20])
        {
            Caption = 'Staff Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(3; "Patient Nos."; Code[20])
        {
            Caption = 'Patient Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(4; "Ward Nos."; Code[20])
        {
            Caption = 'Ward Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(5; "Diagnostics Nos."; Code[20])
        {
            Caption = 'Diagnostics Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Drug Nos."; Code[20])
        {
            Caption = 'Drug Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}