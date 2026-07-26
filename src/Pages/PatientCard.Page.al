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

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Sync to Customer")
            {
                Caption = 'Sync to Customer';
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    if Customer.Get(Rec."Patient No.") then begin
                        Customer.Validate(Name, StrSubstNo('%1 %2', Rec."First Name", Rec."Last Name"));
                        Customer.Validate("E-Mail", Rec."Email Address");
                        Customer.Validate("Phone No.", Rec."Phone Number");

                        Customer.Modify(true);
                    end else begin
                        Customer.Init();

                        Customer.Validate("No.", Rec."Patient No.");
                        Customer.Validate(Name, StrSubstNo('%1 %2', Rec."First Name", Rec."Last Name"));
                        Customer.Validate("E-Mail", Rec."Email Address");
                        Customer.Validate("Phone No.", Rec."Phone Number");

                        // Default Posting Groups
                        Customer.Validate("Customer Posting Group", 'DOMESTIC');
                        Customer.Validate("Gen. Bus. Posting Group", 'DOMESTIC');
                        Customer.Validate("VAT Bus. Posting Group", 'DOMESTIC');

                        Customer.Insert(true);
                    end;

                    Rec."Customer No." := Customer."No.";
                    Rec.Modify(true);

                    Message('Customer synchronized successfully.');
                end;
            }
        }
    }
}