page 50100 "Hospital Staff List"
{
    PageType = List;
    SourceTable = "Hospital Staff";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Hospital Staff';

    CardPageId = "Hospital Staff Card";
    SourceTableView = sorting("Staff No.");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Staff No."; Rec."Staff No.")
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

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}