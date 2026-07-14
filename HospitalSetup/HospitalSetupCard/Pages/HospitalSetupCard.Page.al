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