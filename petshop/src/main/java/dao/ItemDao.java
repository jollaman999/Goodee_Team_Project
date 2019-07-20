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

    public int count(Integer category_group, Integer category_item, String searchtype, String searchcontent) {
        param.clear();

        if (category_group != null && category_group != 0 &&
                category_item != null && category_item != 0) {
            param.put("category_group", category_group);
            param.put("category_item", category_item);
        }

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        return sqlSessionTemplate.selectOne(NS + "count", param);
    }

    public List<Item> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }

    public List<Item> list(Integer category_group, Integer category_item,
                           Integer pageNum, int limit, String searchtype, String searchcontent) {
        param.clear();

        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);

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

        return sqlSessionTemplate.selectList(NS + "list", param);
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

    public Item selectOne(Integer item_no) {
        param.clear();
        param.put("item_no", item_no);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public Item selectOne(String name) {
        param.clear();
        param.put("name", name);
        return sqlSessionTemplate.selectOne(NS + "list", param);
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
}
