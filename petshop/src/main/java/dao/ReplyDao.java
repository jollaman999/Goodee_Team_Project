package dao;

import dao.mapper.ReplyMapper;
import logic.Reply;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReplyDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.ReplyMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int getMaxNum() {
        return sqlSessionTemplate.getMapper(ReplyMapper.class).maxnum();
    }

    public Reply selectOne(int num) {
        return sqlSessionTemplate.getMapper(ReplyMapper.class).selectOne(num);
    }

    public int getReplyCount(String type, int itemno) {
        param.clear();
        param.put("type", type);
        param.put("itemno", itemno);

        return sqlSessionTemplate.getMapper(ReplyMapper.class).reply_count(param);
    }

    public List<Reply> list(String type, int itemno, int pageNum, int limit) {
        param.clear();
        param.put("type", type);
        param.put("itemno", itemno);
        param.put("pageNum", (pageNum - 1) * limit);
        param.put("limit", limit);

        return sqlSessionTemplate.getMapper(ReplyMapper.class).list(param);
    }

    public int insert(Reply reply) {
        return sqlSessionTemplate.getMapper(ReplyMapper.class).insert(reply);
    }

    public int update(int num, String content) {
        param.clear();
        param.put("num", num);
        param.put("content", content);

        return sqlSessionTemplate.getMapper(ReplyMapper.class).update(param);
    }

    public int delete(int num) {
        return sqlSessionTemplate.getMapper(ReplyMapper.class).delete(num);
    }
}
