table 50100 "Hospital Staff"
{
    Caption = 'Hospital Staff';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Hospital Staff List";
    LookupPageID = "Hospital Staff List";

    fields
    {
        field(1; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
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

        field(5; Type; Enum "Hospital Staff Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Staff No.", "First Name", "Last Name", Type)
        {
        }
    }

    trigger OnInsert()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if "Staff No." = '' then begin
            HospitalSetup.Get('SETUP');

            HospitalSetup.TestField("Staff Nos.");

            "No. Series" := HospitalSetup."Staff Nos.";

            "Staff No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    var
        NoSeries: Codeunit "No. Series";
}