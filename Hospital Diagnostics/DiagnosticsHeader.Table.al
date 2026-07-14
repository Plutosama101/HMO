table 50104 "Diagnostics Header"
{
    Caption = 'Diagnostics Header';
    TableType = Normal;
    DataClassification = CustomerContent;

    // Uncomment after the pages have been created
    // DrillDownPageID = "Diagnostics List";
    // LookupPageID = "Diagnostics List";

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
            DataClassification = CustomerContent;
        }

        field(5; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
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

        field(8; "Ward No."; Code[20])
        {
            Caption = 'Ward No.';
            TableRelation = Ward."Ward No.";
            DataClassification = CustomerContent;
        }

        field(9; Doctor; Code[20])
        {
            Caption = 'Doctor';
            TableRelation = "Hospital Staff"."Staff No.";
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
            Editable = false;
            DecimalPlaces = 0 : 2;
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
    procedure UpdateTotalAmount()
    var
        DiagnosticsLine: Record "Diagnostics Line";
    begin
        "Total Amount" := 0;

        DiagnosticsLine.SetRange("Document No.", "Document No.");

        if DiagnosticsLine.FindSet() then
            repeat
                "Total Amount" += DiagnosticsLine.Amount;
            until DiagnosticsLine.Next() = 0;

        Modify();
    end;
}