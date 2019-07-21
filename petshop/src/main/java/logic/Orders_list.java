package logic;

public class Orders_list {
    private int order_num;
    private int list_num;
    private int item_no;
    private int quantity;

    public Orders_list(int order_num, int list_num, int item_no, int quantity) {
        this.order_num = order_num;
        this.list_num = list_num;
        this.item_no = item_no;
        this.quantity = quantity;
    }

    public int getOrder_num() {
        return order_num;
    }

    public void setOrder_num(int order_num) {
        this.order_num = order_num;
    }

    public int getList_num() {
        return list_num;
    }

    public void setList_num(int list_num) {
        this.list_num = list_num;
    }

    public int getItem_no() {
        return item_no;
    }

    public void setItem_no(int item_no) {
        this.item_no = item_no;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
