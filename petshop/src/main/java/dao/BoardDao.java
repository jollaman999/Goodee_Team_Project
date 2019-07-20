package dao;

import dao.mapper.BoardMapper;
import logic.Board;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.BoardMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int count(int type, String searchtype, String searchcontent) {
        param.clear();
        param.put("type", type);

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        return sqlSessionTemplate.selectOne(NS + "count", param);
    }

    public int maxnum() {
        return sqlSessionTemplate.getMapper(BoardMapper.class).maxnum();
    }

    public List<Board> list(int type, int pageNum, int limit, String searchtype, String searchcontent) {
        param.clear();
        param.put("type", type);
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        return sqlSessionTemplate.selectList(NS + "list", param);
    }

    public Board selectOne(int num) {
        param.clear();
        param.put("num", num);

        return sqlSessionTemplate.selectOne(NS + "list", param);
    }

    public int insert(Board board) {
        return sqlSessionTemplate.getMapper(BoardMapper.class).insert(board);
    }

    public int update(Board board) {
        return sqlSessionTemplate.getMapper(BoardMapper.class).update(board);
    }

    public int delete(Integer num) {
        param.clear();
        param.put("num", num);

        return sqlSessionTemplate.getMapper(BoardMapper.class).delete(num);
    }
}
