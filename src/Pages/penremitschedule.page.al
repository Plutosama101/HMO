page 50129 "PenRemit Setup"
{
    PageType = Card;
    SourceTable = "PenRemit Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'PenRemit Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Base URL"; Rec."Base URL") { ApplicationArea = All; }
                field("Login URL"; Rec."Login URL") { ApplicationArea = All; }
                field("Schedule URL"; Rec."Schedule URL") { ApplicationArea = All; }
                field(Email; Rec.Email) { ApplicationArea = All; }
                field(Password; Rec.Password) { ApplicationArea = All; }
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