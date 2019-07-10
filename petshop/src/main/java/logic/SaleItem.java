package logic;

public class SaleItem {
    private int saleId;
    private int saleItemId;
    private int itemId;
    private int quantity;
    private Item item;

    SaleItem() {
    }
    SaleItem(int saleId, int saleItemId, ItemSet itemSet) {
        this.saleId = saleId;
        this.saleItemId = saleItemId;
        this.item = itemSet.getItem();
        this.itemId = item.getId();
        this.quantity = itemSet.getQuantity();
    }

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public int getSaleItemId() {
        return saleItemId;
    }

    public void setSaleItemId(int saleItemId) {
        this.saleItemId = saleItemId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }
}
