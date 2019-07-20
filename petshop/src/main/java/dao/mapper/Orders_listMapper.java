package dao.mapper;

import logic.Orders_list;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface Orders_listMapper {
    @Select("select ifnull(max(order_num), 0) from orderslist")
    int maxorder_num();

    @Insert("insert into orders_list (order_num, list_num, item_no, quantity) values (#{order_num}, #{list_num}, #{item_no},#{quantity})")
    void insert(Orders_list orders_list);
}
