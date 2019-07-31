package dao;

import dao.mapper.ItemMapper;
import logic.Item;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("ItemDao")
public class ItemDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.ItemMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int max_item_no() {
        return sqlSessionTemplate.getMapper(ItemMapper.class).max_item_no();
    }

    public int count(Integer category_group, Integer category_item, String searchtype, String searchcontent,
                     Integer min_price, Integer max_price) {
        param.clear();

        if (category_group != null && category_group != 0) {
            param.put("category_group", category_group);
        }

        if (category_item != null && category_item != 0) {
            param.put("category_item", category_item);
        }

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        if (min_price != null && max_price != null) {
            param.put("min_price", min_price);
            param.put("max_price", max_price);
        }

        return sqlSessionTemplate.selectOne(NS + "count", param);
    }

    public int min_price(Integer category_group, Integer category_item) {
        param.clear();

        if (category_group != null && category_group != 0) {
            param.put("category_group", category_group);
        }

        if (category_item != null && category_item != 0) {
            param.put("category_item", category_item);
        }

        return sqlSessionTemplate.selectOne(NS + "min_price", param);
    }

    public int max_price(Integer category_group, Integer category_item) {
        param.clear();

        if (category_group != null && category_group != 0) {
            param.put("category_group", category_group);
        }

        if (category_item != null && category_item != 0) {
            param.put("category_item", category_item);
        }

        return sqlSessionTemplate.selectOne(NS + "max_price", param);
    }

    public List<Item> list(Integer category_group, Integer category_item,
                           Integer pageNum, Integer limit, String searchtype, String searchcontent,
                           Integer min_price, Integer max_price, boolean get_quantity_details) {
        param.clear();

        if (pageNum != null && pageNum != 0 && limit != null && limit != 0) {
            param.put("startrow", (pageNum - 1) * limit);
            param.put("limit", limit);
        }

        if (category_group != null && category_group != 0) {
            param.put("category_group", category_group);
        }

        if (category_item != null && category_item != 0) {
            param.put("category_item", category_item);
        }

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        if (min_price != null && max_price != null) {
            param.put("min_price", min_price);
            param.put("max_price", max_price);
        }

        List<Item> itemList =  sqlSessionTemplate.selectList(NS + "list", param);
        if (itemList != null && get_quantity_details) {
            for (Item item : itemList) {
                item.setSold_quantity(getSold_quantity(item.getItem_no()));
                item.setRemained_quantity(getRemained_quantity(item.getItem_no()));
            }
        }

        return itemList;
    }

    public boolean check_new(Integer category_group, Integer category_item, Integer item_no) {
        param.clear();

        if (item_no != null && item_no != 0) {
            param.put("item_no", item_no);
        }

        if (category_group != null && category_group != 0) {
            param.put("category_group", category_group);
        }

        if (category_item != null && category_item != 0) {
            param.put("category_item", category_item);
        }

        List<Item> recent_item_list = sqlSessionTemplate.selectList(NS + "recent", param);
        return recent_item_list != null && !recent_item_list.isEmpty();
    }

    public Item selectOne(Integer item_no, boolean get_quantity_details) {
        param.clear();
        param.put("item_no", item_no);

        Item item =  sqlSessionTemplate.selectOne(NS + "list", param);
        if (item != null && get_quantity_details) {
            item.setSold_quantity(getSold_quantity(item.getItem_no()));
            item.setRemained_quantity(getRemained_quantity(item.getItem_no()));
        }

        return item;
    }

    public Item selectOne(String name, boolean get_quantity_details) {
        param.clear();
        param.put("name", name);

        Item item =  sqlSessionTemplate.selectOne(NS + "list", param);
        if (item != null && get_quantity_details) {
            item.setSold_quantity(getSold_quantity(item.getItem_no()));
            item.setRemained_quantity(getRemained_quantity(item.getItem_no()));
        }

        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public List<Item> get_latest_items(int limit) {
        param.clear();
        param.put("limit", limit);

        return sqlSessionTemplate.getMapper(ItemMapper.class).get_latest_items(param);
    }

    public List<Item> get_sold_items(int category_group_code, int limit) {
        param.clear();
        param.put("category_group_code", category_group_code);
        param.put("limit", limit);

        return sqlSessionTemplate.getMapper(ItemMapper.class).get_sold_items(param);
    }

    public int insert(Item item) {
        int no = sqlSessionTemplate.getMapper(ItemMapper.class).max_item_no();
        item.setItem_no(++no);
        return sqlSessionTemplate.getMapper(ItemMapper.class).insert(item);
    }

    public int update(Item item) {
        return sqlSessionTemplate.getMapper(ItemMapper.class).update(item);
    }

    public int delete(Integer item_no) {
        return sqlSessionTemplate.getMapper(ItemMapper.class).delete(item_no);
    }

    private int getSold_quantity(Integer item_no) {
        return sqlSessionTemplate.getMapper(ItemMapper.class).sold_quantity(item_no);
    }

    private int getRemained_quantity(Integer item_no) {
        return sqlSessionTemplate.getMapper(ItemMapper.class).remained_quantity(item_no);
    }
}
