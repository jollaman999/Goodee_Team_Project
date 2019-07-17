package dao;

import logic.AdminMail;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class AdminMailDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.AdminMailMapper.";
    private Map<String, Object> param = new HashMap<>();

    public AdminMail selectOne(int num) {
        param.clear();
        param.put("num", num);

        return sqlSessionTemplate.selectOne(NS + "list", param);
    }
}
