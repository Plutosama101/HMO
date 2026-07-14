table 50110 "Hospital Setup"
{
    Caption = 'Hospital Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Staff Nos."; Code[20])
        {
            Caption = 'Staff Nos.';
            TableRelation = "No. Series";
        }

        field(3; "Patient Nos."; Code[20])
        {
            Caption = 'Patient Nos.';
            TableRelation = "No. Series";
        }

        field(4; "Ward Nos."; Code[20])
        {
            Caption = 'Ward Nos.';
            TableRelation = "No. Series";
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