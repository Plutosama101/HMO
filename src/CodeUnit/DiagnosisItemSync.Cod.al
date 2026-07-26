#pragma warning disable AL0264
codeunit 50125 "Diagnosis Item Sync"
#pragma warning restore AL0264
{
    procedure SyncToItem(var DiagnosisDescription: Record "Diagnosis Description")
    var
        Item: Record Item;
    begin
        if Item.Get(DiagnosisDescription.Code) then begin
            Item.Validate(Description, DiagnosisDescription.Description);
            Item.Validate("Unit Price", DiagnosisDescription."Unit Price");
            Item.Modify(true);
        end else begin
            Item.Init();
            Item.Validate("No.", DiagnosisDescription.Code);
            Item.Validate(Description, DiagnosisDescription.Description);
            Item.Validate(Type, Item.Type::Inventory);
            Item.Validate("Base Unit of Measure", 'PCS');
            Item.Validate("Unit Price", DiagnosisDescription."Unit Price");
            Item.Insert(true);
        end;
    end;
}