page 50105 "Ward Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Ward;
    Caption = 'Ward Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No. Series"; Rec."No. Series")
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
