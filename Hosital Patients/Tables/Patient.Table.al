table 50101 Patient
{
    Caption = 'Patient';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Patient List";
    LookupPageID = "Patient List";

    fields
    {
        field(1; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
            DataClassification = CustomerContent;
        }

        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(3; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }

        field(4; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }

        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }

        field(6; "Blood Group"; Enum "Blood Group")
        {
            Caption = 'Blood Group';
            DataClassification = CustomerContent;
        }

        field(7; Genotype; Enum "Genotype")
        {
            Caption = 'Genotype';
            DataClassification = CustomerContent;
        }

        field(8; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
        }

        field(9; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }

        field(10; "Next of Kin Name"; Text[100])
        {
            Caption = 'Next of Kin Name';
            DataClassification = CustomerContent;
        }

        field(11; "Next of Kin Contact No."; Text[30])
        {
            Caption = 'Next of Kin Contact No.';
            DataClassification = CustomerContent;
        }

        field(12; Insurance; Code[20])
        {
            Caption = 'Insurance';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Patient No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Patient No.", "First Name", "Last Name")
        {
        }
    }

    trigger OnInsert()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if "Patient No." = '' then begin
            HospitalSetup.Get('SETUP');

            HospitalSetup.TestField("Patient Nos.");

            "No. Series" := HospitalSetup."Patient Nos.";

            "Patient No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    var
        NoSeries: Codeunit "No. Series";

}