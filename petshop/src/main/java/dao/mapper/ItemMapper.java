package dao.mapper;

import logic.Item;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ItemMapper {
    @Select("select ifnull(max(id), 0) from item")
    int maxid();

    @Insert("insert into item (item_no, category_group_code, category_item_code, name, mainpic, price, description, content, origin, mfr, mfr_tel, expr_date, quantity) " +
            "values (#{item_no}, #{category_group_code}, #{category_item_code}, #{name}, #{mainpic}, #{price}, #{description}, #{content}, #{origin}, #{mfr}, #{mfr_tel}, #{expr_date}, #{quantity})")
    void insert(Item item);

    @Update("update item set category_group_code = #{category_group_code}, category_item_code = #{category_item_code}, name = #{name}, price = #{price}, description = #{description}, " +
            "content = #{content}, origin = #{origin}, mfr = #{mfr}, mfr_tel = #{mfr_tel}, expr_date = #{expr_date}, quantity = #{quantity} " +
            "where item_no = #{item_no}")
    void update(Item item);

    @Delete("delete from item where item_no = #{item_no}")
    void delete(Integer item_no);
}
