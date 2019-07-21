package dao.mapper;

import logic.Orders_list;
import org.apache.ibatis.annotations.Insert;

public interface Orders_listMapper {
    @Insert("insert into orders_list (order_num, list_num, item_no, quantity) values (#{order_num}, #{list_num}, #{item_no}, #{quantity})")
    int insert(Orders_list orders_list);
}
