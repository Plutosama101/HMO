table 50104 "Diagnostics Header"
{
    Caption = 'Diagnostics Header';
    TableType = Normal;
    DataClassification = CustomerContent;

    DrillDownPageID = "Diagnostics List";
    LookupPageID = "Diagnostics List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(3; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
            TableRelation = Patient."Patient No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Patient: Record Patient;
            begin
                if Patient.Get("Patient No.") then begin
                    "First Name" := Patient."First Name";
                    "Last Name" := Patient."Last Name";
                    "Blood Group" := Patient."Blood Group";
                    Genotype := Patient.Genotype;
                end;
            end;
        }

        field(4; "First Name"; Text[100])
        {
            Caption = 'First Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(5; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(6; "Blood Group"; Enum "Blood Group")
        {
            Caption = 'Blood Group';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(7; Genotype; Enum "Genotype")
        {
            Caption = 'Genotype';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(8; "Ward No."; Code[20])
        {
            Caption = 'Ward No.';
            TableRelation = Ward."Ward No.";
            DataClassification = CustomerContent;
        }

        field(9; Doctor; Code[20])
        {
            Caption = 'Doctor';
            TableRelation = "Hospital Staff"."Staff No."
                where(Type = const(Doctor));
            DataClassification = CustomerContent;
        }

        field(10; Status; Enum "Diagnostic Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Diagnostics Line".Amount WHERE("Document No." = FIELD("Document No.")));
            Editable = false;
        }

        field(12; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(13; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if "Document No." = '' then begin
            HospitalSetup.Get('SETUP');
            HospitalSetup.TestField("Diagnostics Nos.");

            "No. Series" := HospitalSetup."Diagnostics Nos.";
            "Document No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    var
        NoSeries: Codeunit "No. Series";
}