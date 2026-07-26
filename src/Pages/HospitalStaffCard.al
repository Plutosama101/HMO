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
    actions
    {
        area(Processing)
        {
            action("Sync to Employee")
            {
                Caption = 'Sync to Employee';
                ApplicationArea = All;
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create or update an Employee record from this Hospital Staff record.';

                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    if Employee.Get(Rec."Staff No.") then begin
                        // Update existing employee
                        Employee."First Name" := Rec."First Name";
                        Employee."Last Name" := Rec."Last Name";

                        Employee.Modify(true);

                        Message('Employee synchronized successfully.');
                    end else begin
                        // Create new employee
                        Employee.Init();
                        Employee."No." := Rec."Staff No.";
                        Employee."First Name" := Rec."First Name";
                        Employee."Last Name" := Rec."Last Name";

                        Employee.Insert(true);

                        Message('Employee synchronized successfully.');
                    end;
                end;
            }
        }
    }
}