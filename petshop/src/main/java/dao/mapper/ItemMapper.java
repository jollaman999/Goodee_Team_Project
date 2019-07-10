package dao.mapper;

import logic.Item;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ItemMapper {
    @Select("select ifnull(max(id), 0) from item")
    int maxid();

    @Insert("insert into item (id, name, price, description, pictureUrl) values (#{id}, #{name}, #{price}, #{description}, #{pictureUrl})")
    void insert(Item item);

    @Update("update item set name = #{name}, price = #{price}, description = #{description}, pictureUrl = #{pictureUrl} where id = #{id}")
    void update(Item item);

    @Delete("delete from item where id = #{id}")
    void delete(Integer id);
}
