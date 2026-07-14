page 50103 "Patient Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Patient;
    Caption = 'Patient Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No. Series"; Rec."No. Series")
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

                field("Date of Birth"; Rec."Date of Birth")
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

                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }

                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }

                field("Next of Kin Name"; Rec."Next of Kin Name")
                {
                    ApplicationArea = All;
                }

                field("Next of Kin Contact No."; Rec."Next of Kin Contact No.")
                {
                    ApplicationArea = All;
                }

                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}