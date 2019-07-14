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

    public List<Item> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }

    public Item selectOne(int item_no) {
        param.clear();
        param.put("item_no", item_no);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public void insert(Item item) {
        int id = sqlSessionTemplate.getMapper(ItemMapper.class).maxid();
        item.setItem_no(++id);
        sqlSessionTemplate.getMapper(ItemMapper.class).insert(item);
    }

    public void update(Item item) {
        sqlSessionTemplate.getMapper(ItemMapper.class).update(item);
    }

    public void delete(int item_no) {
        sqlSessionTemplate.getMapper(ItemMapper.class).delete(item_no);
    }
}
