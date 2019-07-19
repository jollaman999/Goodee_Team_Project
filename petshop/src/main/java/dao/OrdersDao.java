package dao;

import dao.mapper.OrdersMapper;
import logic.Item;
import logic.Orders;
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
    
    public int insert(Orders orders) {
        int num = sqlSessionTemplate.getMapper(OrdersMapper.class).max_num();
        orders.setNum(++num);
        return sqlSessionTemplate.getMapper(OrdersMapper.class).insert(orders);
    }

    public int update(Orders orders) {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).update(orders);
    }

    public int delete(Integer num) {
        return sqlSessionTemplate.getMapper(OrdersMapper.class).delete(num);
    }
    
    public Item selectOne(Integer num) {
        param.clear();
        param.put("num", num);
        return sqlSessionTemplate.selectOne(NS + "list", param);
    }
    
    public List<Orders> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }
	
}
