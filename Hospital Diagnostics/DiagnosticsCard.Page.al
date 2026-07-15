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
                    Editable = false;
                }

                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
            }

            part(Lines; "Diagnostics Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Document No.");
                UpdatePropagation = Both;
            }
        }
    }
}