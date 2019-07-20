package dao.mapper;

import logic.Basket;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.Map;

public interface BasketMapper {
    @Select("select count(*) from basket where member_id = #{member_id}")
    int count(String member_id);

    @Insert("insert into basket (member_id, list_num, item_no, quantity) " +
            "values (#{member_id}, #{list_num}, #{item_no}, #{quantity})")
    int insert(Basket basket);

    @Update("update basket set quantity = #{quantity} where member_id = #{member_id} and item_no = #{item_no}")
    int update(Basket basket);

    @Delete("delete from basket where member_id = #{member_id} and item_no = #{item_no}")
    int delete(Map map);

    @Update("update basket set list_num = list_num - 1 where member_id = #{member_id} and list_num > #{list_num}")
    void update_list_num(Map map);

    @Delete("delete from basket where member_id = #{member_id}")
    int clear(Map map);
}
