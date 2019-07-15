package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.CategoryGroup;


public interface CategoryGroupMapper {
	
	@Select("select ifnull(max(group_code),0) from category_group")
	int maxgroup_code();
	
	
	@Insert("insert into category_group (group_code,group_name)" + 
	                     "values (#{group_code},#{group_name})")
	int insert(CategoryGroup categorygroup); 
}
