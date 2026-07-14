codeunit 50120 "Hospital Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        HospitalSetup: Record "Hospital Setup";
    begin
        if not HospitalSetup.Get('SETUP') then begin
            HospitalSetup.Init();
            HospitalSetup."Primary Key" := 'SETUP';
            HospitalSetup.Insert();
        end;
    end;
}