package dao;

import dao.mapper.SaleItemMapper;
import logic.SaleItem;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SaleItemDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.SaleItemMapper.";
    private Map<String, Object> param = new HashMap<>();

    public void insert(SaleItem saleItem) {
        sqlSessionTemplate.getMapper(SaleItemMapper.class).insert(saleItem);
    }

    public List<SaleItem> list(int saleId) {
        param.clear();
        param.put("saleid", saleId);
        return  sqlSessionTemplate.selectList(NS + "list", param);
    }
}
