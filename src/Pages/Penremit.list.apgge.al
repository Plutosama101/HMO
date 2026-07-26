page 50130 "PenRemit Schedule List"
{
    PageType = List;
    SourceTable = "PenRemit Get Schedule";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'PenRemit Schedules';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Schedule Id"; Rec."Schedule Id") { ApplicationArea = All; }
                field("Employer Name"; Rec."Employer Name") { ApplicationArea = All; }
                field("Schedule Name"; Rec."Schedule Name") { ApplicationArea = All; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; }
                field("Payment Status"; Rec."Payment Status") { ApplicationArea = All; }
                field("Payment Date"; Rec."Payment Date") { ApplicationArea = All; }
                field("PFA Name"; Rec."PFA Name") { ApplicationArea = All; }
                field("PFC Name"; Rec."PFC Name") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportSchedules)
            {
                ApplicationArea = All;
                Caption = 'Import PFC Report Schedules';
                Image = Import;
                trigger OnAction()
                var
                    PenRemitPfcReportMgt: Codeunit Cyberpay;
                begin
                    PenRemitPfcReportMgt.ImportPfcReportSchedules();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}