package dao;

import dao.mapper.CategoryGroupMapper;
import logic.CategoryGroup;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("CategoryGroupDao")
public class CategoryGroupDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.CategoryGroupMapper.";
    private Map<String, Object> param = new HashMap<>();

    public List<CategoryGroup> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }

    public CategoryGroup selectOne(int group_code) {
        param.clear();
        param.put("group_code", group_code);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public void insert(CategoryGroup categorygroup) {
        int group_code = sqlSessionTemplate.getMapper(CategoryGroupMapper.class).maxgroup_code();
        categorygroup.setGroup_code(++group_code);
        sqlSessionTemplate.getMapper(CategoryGroupMapper.class).insert(categorygroup);
    }
}
