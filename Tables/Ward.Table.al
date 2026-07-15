table 50102 Ward
{
    Caption = 'Ward';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Ward List";
    LookupPageID = "Ward List";

    fields
    {
        field(1; "Ward No."; Code[20])
        {
            Caption = 'Ward No.';
            DataClassification = CustomerContent;
        }

        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; Category; Enum "Ward Category")
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }

        field(5; "Bed Allocation"; Integer)
        {
            Caption = 'Bed Allocation';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Ward No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Ward No.", Description, Category)
        {
        }
    }

    trigger OnInsert()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if "Ward No." = '' then begin
            HospitalSetup.Get('SETUP');
            HospitalSetup.TestField("Ward Nos.");

            "No. Series" := HospitalSetup."Ward Nos.";
            "Ward No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    var
        NoSeries: Codeunit "No. Series";
}