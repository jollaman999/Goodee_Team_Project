package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import dao.mapper.CategoryItemMapper;
import logic.CategoryItem;

@Repository
public class CategoryItemDao {
	 @Autowired
	    public SqlSessionTemplate sqlSessionTemplate;
	    private final String NS = "dao.mapper.CategoryItemMapper.";
	    private Map<String, Object> param = new HashMap<>();
	    
	    public List<CategoryItemMapper> list() {
	        return sqlSessionTemplate.selectList(NS + "list");
	    }    
	    public CategoryItemMapper selectOne(int group_code){
	    	param.clear();
	        param.put("group_code",group_code);
	        return sqlSessionTemplate.selectOne(NS + "list", param);
	    }
	    public void insert(CategoryItem categoryitem) {
	        int group_code = sqlSessionTemplate.getMapper(CategoryItemMapper.class).maxgroup_code();
	        categoryitem.setGroup_code(++group_code);
	        //item.setItem_no(++id);
	        sqlSessionTemplate.getMapper(CategoryItemMapper.class).insert(categoryitem);
	    }

	    

}
