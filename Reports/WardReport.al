report 50130 "Ward Report"
{
    Caption = 'Ward Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/WardReport.rdl';

    dataset
    {
        dataitem(Ward; Ward)
        {
            RequestFilterFields = "Ward No.", Category, "Location Code";

            column(CompanyName; CompanyProperty.DisplayName())
            {
            }

            column(Today; Today)
            {
            }

            column(UserID; UserId)
            {
            }

            column(WardNo; "Ward No.")
            {
            }

            column(Description; Description)
            {
            }

            column(Category; Category)
            {
            }

            column(BedAllocation; "Bed Allocation")
            {
            }

            column(GLAccountNo; "G/L Account No.")
            {
            }

            column(UnitPrice; "Unit Price")
            {
            }

            column(OrderQuantity; "Order Quantity")
            {
            }

            column(LocationCode; "Location Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Filters';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitle = 'Hospital Ward Report';
    }

    trigger OnPreReport()
    begin
    end;
}