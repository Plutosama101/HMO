page 50104 "Ward List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Ward;
    Caption = 'Ward List';

    CardPageId = "Ward Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }

                field("Bed Allocation"; Rec."Bed Allocation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}