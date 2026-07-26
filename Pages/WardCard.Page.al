page 50105 "Ward Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Ward;
    Caption = 'Ward Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No. Series"; Rec."No. Series")
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

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default quantity to use when creating purchase or sales documents for this ward.';
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Business Central location associated with this ward.';
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
                Image = SalesOrder;
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

            action(NewWard)
            {
                Caption = 'New Ward';
                ApplicationArea = All;
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                ToolTip = 'Create a new ward.';

                trigger OnAction()
                var
                    Ward: Record Ward;
                begin
                    Clear(Ward);
                    Page.RunModal(Page::"Ward Card", Ward);
                end;
            }
        }
    }
}