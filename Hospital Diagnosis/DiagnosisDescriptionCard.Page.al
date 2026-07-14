page 50107 "Diagnosis Description Card"
{
    PageType = Card;
    SourceTable = "Diagnosis Description";
    ApplicationArea = All;
    Caption = 'Diagnosis Description';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}