package dao;

import dao.mapper.RecommendMapper;
import logic.Recommend;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class RecommendDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.BasketMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int getCount(String type, Integer itemno) {
        if (type == null || type.length() == 0|| itemno == null || itemno == 0) {
            return -1;
        }

        param.clear();
        param.put("type", type);
        param.put("itemno", itemno);

        return sqlSessionTemplate.getMapper(RecommendMapper.class).recom_cnt(param);
    }

    public int recomCheck(Recommend recommend) {
        return sqlSessionTemplate.getMapper(RecommendMapper.class).recom_check(recommend);
    }

    public int recomAdd(Recommend recommend) {
        return sqlSessionTemplate.getMapper(RecommendMapper.class).recom_add(recommend);
    }

    public int recomDelete(Recommend recommend) {
        return sqlSessionTemplate.getMapper(RecommendMapper.class).recom_delete(recommend);
    }
}
