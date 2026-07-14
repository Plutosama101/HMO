page 50101 "Hospital Staff Card"
{
    PageType = Card;
    SourceTable = "Hospital Staff";
    ApplicationArea = All;
    Caption = 'Hospital Staff Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Editable = false;
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