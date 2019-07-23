package dao;

import dao.mapper.OrdersMapper;
import logic.Orders;
import logic.Orders_list;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OrdersDao {
	
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.OrdersMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int max_num() {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).max_num();
    }

    public Orders selectOne(Integer num) {
        param.clear();
        param.put("num", num);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }
    
    public int insert(Orders order) {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).insert(order);
    }

    public int update(Orders order) {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).update(order);
    }

    public int delete(Integer num) {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).delete(num);
    }
    
    public List<Orders> list(String member_id, Integer day) {
        param.clear();

        if (member_id != null && member_id.length() != 0) {
            param.put("member_id", member_id);
        }

        if (day != null && day != 0) {
            param.put("day", day);
        }

        List<Orders> ordersList =  sqlSessionTemplate.selectList(NS + "list", param);
        if (ordersList != null) {
            for(Orders order : ordersList) {
                final String OrdersListMapper = "dao.mapper.Orders_listMapper.";

                param.clear();
                param.put("order_num", order.getNum());

                List<Orders_list> orders_listList = sqlSessionTemplate.selectList(OrdersListMapper + "list", param);
                order.setOrders_lists(orders_listList);
            }
        }

        return ordersList;
    }
	
}
