package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.CategoryItem;

public interface CategoryItemMapper {
	
	@Select("select ifnull(max(group_code),0) from category_item")
	int maxgroup_code();
	
	@Insert("insert into category_item (group_code,code,name)" + 
	                     "values (#{group_code},#{code},#{name})")
	int insert(CategoryItem categoryitem); 
}
