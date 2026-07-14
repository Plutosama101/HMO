page 50106 "Diagnosis Description List"
{
    PageType = List;
    SourceTable = "Diagnosis Description";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Diagnosis Descriptions';

    CardPageId = "Diagnosis Description Card";

    layout
    {
        area(Content)
        {
            repeater(General)
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

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}