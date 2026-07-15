page 50112 "Diagnostics Subform"
{
    PageType = ListPart;
    SourceTable = "Diagnostics Line";
    ApplicationArea = All;
    Caption = 'Diagnostics Lines';

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }

                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}