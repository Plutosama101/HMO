page 50104 "Ward List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Ward;
    Caption = 'Ward List';

    CardPageId = "Ward Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Ward No."; Rec."Ward No.")
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

                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                }

                field("Location Code"; Rec."Location Code")
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
            action(CreateSalesOrder)
            {
                Caption = 'Create Sales Order';
                ApplicationArea = All;
                Image = Order;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Creates a Sales Order for the selected ward.';

                trigger OnAction()
                var
                    WardSalesOrderSync: Codeunit "Ward Sales Order Sync";
                begin
                    WardSalesOrderSync.Run(Rec);
                    Message('Sales Order created successfully.');
                end;
            }
        }
    }
}