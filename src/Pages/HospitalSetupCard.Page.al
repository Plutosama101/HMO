page 50110 "Hospital Setup"
{
    PageType = Card;
    SourceTable = "Hospital Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Hospital Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Staff Nos."; Rec."Staff Nos.")
                {
                    ApplicationArea = All;
                }

                field("Patient Nos."; Rec."Patient Nos.")
                {
                    ApplicationArea = All;
                }

                field("Ward Nos."; Rec."Ward Nos.")
                {
                    ApplicationArea = All;
                }

                field("Diagnostics Nos."; Rec."Diagnostics Nos.")
                {
                    ApplicationArea = All;
                }

                field("Drug Nos."; Rec."Drug Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}