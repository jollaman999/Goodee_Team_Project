package logic;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<ItemSet> itemSetList = new ArrayList<>();

    public List<ItemSet> getItemSetList() {
        return itemSetList;
    }

    public void push(ItemSet itemSet) {
        for (ItemSet set : itemSetList) {
            if (set.getItem().getId().equals(itemSet.getItem().getId())) {
                int quantity = set.getQuantity();
                set.setQuantity(quantity + itemSet.getQuantity());

                return;
            }
        }
        itemSetList.add(itemSet);
    }

    public boolean isEmpty() {
        return itemSetList == null || itemSetList.size() == 0;
    }

    public long getTotal() {
        long sum = 0;

        for (ItemSet set : itemSetList) {
            sum += set.getItem().getPrice() * set.getQuantity();
        }

        return sum;
    }

    public void clearAll(HttpSession session) {
        itemSetList.clear();
        session.setAttribute("CART", this);
    }
}
