codeunit 50119 "Drug Item Sync"
{
    procedure Run(var Drug: Record Drug)
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
        IsNewItem: Boolean;
    begin
        IsNewItem := Drug."Item No" = '';

        if IsNewItem then begin
            InventorySetup.Get();
            InventorySetup.TestField("Item Nos.");

            Item.Init();
            Item."No." := NoSeries.GetNextNo(InventorySetup."Item Nos.", WorkDate());
        end else
            Item.Get(Drug."Item No");

        Item.Description := Drug.Description;

        if IsNewItem then begin
            Item.Insert(true);
            Drug."Item No" := Item."No.";
            Drug.Modify(true);
        end else
            Item.Modify(true);
    end;
}