table 50130 "Penremit Get Schedule"
{
    Caption = 'Penremit Get Schedule';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Schedule ID"; Guid)
        {
            Caption = 'Schedule ID';
        }

        field(2; "Employer ID"; Integer)
        {
            Caption = 'Employer ID';
        }

        field(3; "Created On"; DateTime)
        {
            Caption = 'Created On';
        }

        field(4; Comment; Text[250])
        {
            Caption = 'Comment';
        }

        field(5; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }

        field(6; "Schedule Name"; Text[100])
        {
            Caption = 'Schedule Name';
        }

        field(7; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
        }

        field(8; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
        }

        field(9; "Transaction Reference"; Code[50])
        {
            Caption = 'Transaction Reference';
        }

        field(10; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
        }

        field(11; "Payment Status"; Text[30])
        {
            Caption = 'Payment Status';
        }

        field(12; "Payment Method"; Text[30])
        {
            Caption = 'Payment Method';
        }

        field(13; "Schedule Reference"; Code[30])
        {
            Caption = 'Schedule Reference';
        }

        field(14; "PFC Reference"; Code[30])
        {
            Caption = 'PFC Reference';
        }

        field(15; "PFC Name"; Text[100])
        {
            Caption = 'PFC Name';
        }

        field(16; "Payment Date"; DateTime)
        {
            Caption = 'Payment Date';
        }

        field(17; "Schedule Detail Count"; Integer)
        {
            Caption = 'Schedule Detail Count';
        }

        field(18; "PFA Code"; Code[10])
        {
            Caption = 'PFA Code';
        }

        field(19; "PFA Name"; Text[100])
        {
            Caption = 'PFA Name';
        }

        field(20; "PFA Reference"; Code[30])
        {
            Caption = 'PFA Reference';
        }
    }

    keys
    {
        key(PK; "Schedule ID")
        {
            Clustered = true;
        }

        key(ScheduleReference; "Schedule Reference")
        {
        }

        key(TransactionReference; "Transaction Reference")
        {
        }
    }
}