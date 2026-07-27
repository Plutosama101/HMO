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

                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L Account used when this ward is billed.';
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default quantity when this ward is added to a diagnostics document.';
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location associated with this ward.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewWard)
            {
                Caption = 'New Ward';
                ApplicationArea = All;
                Image = New;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    NewWard: Record Ward;
                begin
                    Clear(NewWard);
                    Page.RunModal(Page::"Ward Card", NewWard);
                end;
            }

            action(UpdateWard)
            {
                Caption = 'Update Ward';
                ApplicationArea = All;
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SaveRecord();
                    Message('Ward updated successfully.');
                end;
            }

            action(SyncWard)
            {
                Caption = 'Sync Ward';
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Synchronizes this ward with its corresponding Business Central Item.';

                trigger OnAction()
                var
                    WardSync: Codeunit "Ward Sync";
                begin
                    CurrPage.SaveRecord();
                    WardSync.SyncToItem(Rec);
                    Message('Ward synchronized successfully.');
                end;
            }
        }
    }
}