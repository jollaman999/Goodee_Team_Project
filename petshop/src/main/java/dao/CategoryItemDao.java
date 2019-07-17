package dao;

import dao.mapper.CategoryItemMapper;
import logic.CategoryItem;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CategoryItemDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.CategoryItemMapper.";
    private Map<String, Object> param = new HashMap<>();

    public List<CategoryItem> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }

    public CategoryItem selectOne(int code) {
        param.clear();
        param.put("code", code);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public void insert(CategoryItem categoryitem) {
        int code = sqlSessionTemplate.getMapper(CategoryItemMapper.class).maxitem_code();
        categoryitem.setCode(++code);
        sqlSessionTemplate.getMapper(CategoryItemMapper.class).insert(categoryitem);
    }
}
