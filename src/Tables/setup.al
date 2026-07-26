table 50119 "PenRemit Setup"
{
    Caption = 'PenRemit Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Base URL"; Text[250])
        {
            Caption = 'Base URL';
        }

        field(3; "Login URL"; Text[100])
        {
            Caption = 'Login URL';
        }

        field(4; "Schedule URL"; Text[100])
        {
            Caption = 'Schedule URL';
        }

        field(5; Email; Text[100])
        {
            Caption = 'Email';
        }

        field(6; Password; Text[100])
        {
            Caption = 'Password';
            ExtendedDatatype = Masked;
        }

        field(7; "Access Token"; Text[2048])
        {
            Editable = false;
        }

        field(8; "Access Token Expiry"; DateTime)
        {
            Editable = false;
        }

        field(9; "Refresh Token"; Text[2048])
        {
            Editable = false;
        }

        field(10; "Refresh Token Expiry"; DateTime)
        {
            Editable = false;
        }

        field(11; "User ID"; Guid)
        {
            Editable = false;
        }

        field(12; Username; Text[100])
        {
            Editable = false;
        }

        field(13; "Company Name"; Text[100])
        {
            Editable = false;
        }

        field(14; "Employer Code"; Code[30])
        {
            Editable = false;
        }

        field(15; Role; Text[50])
        {
            Editable = false;
        }

        field(16; "Role Category"; Text[50])
        {
            Editable = false;
        }

        field(17; "Default Branch ID"; Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Primary Key" = '' then
            "Primary Key" := 'SETUP';
    end;
}