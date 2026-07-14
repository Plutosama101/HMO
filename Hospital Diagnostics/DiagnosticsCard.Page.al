page 50109 "Diagnostics Card"
{
    PageType = Card;
    SourceTable = "Diagnostics Header";
    ApplicationArea = All;
    Caption = 'Diagnostics Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }

                field("Patient No."; Rec."Patient No.")
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

                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }

                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                }

                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                }

                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}