codeunit 50124 "Ward Sync"
{
    procedure SyncToItem(var Ward: Record Ward)
    var
        Item: Record Item;
        IsNew: Boolean;
    begin
        if Ward."Ward No." = '' then
            exit;

        IsNew := not Item.Get(Ward."Ward No.");

        if IsNew then begin
            Item.Init();
            Item.Validate("No.", Ward."Ward No.");
            Item.Insert(true);

            Item.Validate("Base Unit of Measure", 'PCS');
        end;

        Item.Validate(Description, Ward.Description);
        Item.Validate("Unit Price", Ward."Unit Price");

        // Optional: keep cost in sync with selling price
        Item.Validate("Unit Cost", Ward."Unit Price");

        Item.Modify(true);
    end;
}