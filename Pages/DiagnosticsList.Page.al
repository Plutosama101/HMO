page 50108 "Diagnostics List"
{
    PageType = List;
    SourceTable = "Diagnostics Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Diagnostics';

    CardPageId = "Diagnostics Card";

    layout
    {
        area(Content)
        {
            repeater(General)
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