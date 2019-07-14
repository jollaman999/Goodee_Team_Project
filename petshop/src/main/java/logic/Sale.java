package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sale {
    private int saleId;
    private Member member;
    private Date updatetime;
    private List<SaleItem> itemList = new ArrayList<>();
    private long totAmount;

    public long getTotAmount() {
        long sum = 0;

        for (SaleItem si : itemList) {
            sum += si.getItem().getPrice() * si.getQuantity();
        }
        return sum;
    }

    public void setTotAmount(long totAmount) {
        this.totAmount = totAmount;
    }

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public List<SaleItem> getItemList() {
        return itemList;
    }

    public void setItemList(List<SaleItem> itemList) {
        this.itemList = itemList;
    }
}
