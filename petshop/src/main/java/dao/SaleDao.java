package dao;

import dao.mapper.SaleMapper;
import logic.Sale;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SaleDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.SaleMapper.";
    private RowMapper<Sale> mapper = new BeanPropertyRowMapper<>(Sale.class);
    private Map<String, Object> param = new HashMap<>();

    public int getMaxSaleId() {
        int max = sqlSessionTemplate.getMapper(SaleMapper.class).maxsaleid();
        return max + 1;
    }

    public void insert(Sale sale) {
        sqlSessionTemplate.getMapper(SaleMapper.class).insert(sale);
    }

    public List<Sale> list(String id) {
        param.clear();
        param.put("userid", id);
        return sqlSessionTemplate.selectList(NS + "list", param);
    }
}
