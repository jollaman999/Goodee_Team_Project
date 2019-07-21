package dao;

import logic.Deposit;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class DepositDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.DepositMapper.";
    private Map<String, Object> param = new HashMap<>();

    public Deposit selectOne(int num) {
        param.clear();
        param.put("num", num);

        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public List<Deposit> list() {
        return sqlSessionTemplate.selectList(NS + "list");
    }
}
