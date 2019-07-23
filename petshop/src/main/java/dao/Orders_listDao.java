package dao;

import dao.mapper.Orders_listMapper;
import logic.Orders_list;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("Orders_listDao")
public class Orders_listDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.Orders_listMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int insert(Orders_list ordersList) {
        return sqlSessionTemplate.getMapper(Orders_listMapper.class).insert(ordersList);
    }

    public List<Orders_list> list(int order_num) {
        param.clear();
        param.put("order_num", order_num);
        return sqlSessionTemplate.selectList(NS + "list", param);
    }
}
