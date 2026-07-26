page 50102 "Patient List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Patient;
    Caption = 'Patients';

    CardPageId = "Patient Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }

                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }

                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }

                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                }

                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}