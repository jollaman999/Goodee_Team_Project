package dao;

import dao.mapper.OrdersMapper;
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
    
    public List<Orders> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }
	
}
