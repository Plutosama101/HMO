codeunit 50122 "Drug Item Sync"
{
    procedure SyncToItem(var DiagnosisDescription: Record "Diagnosis Description")
    var
        Item: Record Item;
    begin
        // Only sync Diagnosis records
        if DiagnosisDescription.Type <> DiagnosisDescription.Type::Diagnosis then
            exit;

        if Item.Get(DiagnosisDescription.Code) then begin
            // Update existing Item
            Item.Validate(Description, DiagnosisDescription.Description);
            Item.Validate("Unit Price", DiagnosisDescription."Unit Price");
            Item.Modify(true);
        end else begin
            // Create new Item
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