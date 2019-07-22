package dao.mapper;

import logic.Item;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ItemMapper {
    @Select("select ifnull(max(item_no), 0) from item")
    int max_item_no();

    @Insert("insert into item (item_no, category_group_code, category_item_code, name, mainpic, price, description, content, origin, mfr, mfr_tel, expr_date, quantity, update_time) " +
            "values (#{item_no}, #{category_group_code}, #{category_item_code}, #{name}, #{mainpicurl}, #{price}, #{description}, #{content}, #{origin}, #{mfr}, #{mfr_tel}, #{expr_date}, #{quantity}, now())")
    int insert(Item item);

    @Update("update item set category_group_code = #{category_group_code}, category_item_code = #{category_item_code}, name = #{name}, mainpic = #{mainpicurl}, price = #{price}, description = #{description}, " +
            "content = #{content}, origin = #{origin}, mfr = #{mfr}, mfr_tel = #{mfr_tel}, expr_date = #{expr_date}, quantity = #{quantity}, update_time = now() " +
            "where item_no = #{item_no}")
    int update(Item item);

    @Delete("delete from item where item_no = #{item_no}")
    int delete(Integer item_no);

    @Select("select ifnull(sum(quantity), 0) from orders_list where item_no = #{item_no}")
    int sold_quantity(Integer item_no);

    @Select("select i.quantity - ifnull(sum(ol.quantity), 0) from item i, orders_list ol where i.item_no = #{item_no} and ol.item_no = #{item_no}")
    int remained_quantity(Integer item_no);
}
