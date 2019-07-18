package dao;

import dao.mapper.ItemMapper;
import logic.Item;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ItemDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.ItemMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int max_item_no() {
        return sqlSessionTemplate.getMapper(ItemMapper.class).max_item_no();
    }

    public List<Item> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }

    public Item selectOne(int item_no) {
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

    public int delete(int item_no) {
        return sqlSessionTemplate.getMapper(ItemMapper.class).delete(item_no);
    }
}
