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

    public int count(String searchtype, String searchcontent) {
        if (searchtype != null && searchtype.length() != 0 &&
            searchcontent != null && searchcontent.length() != 0) {
            param.clear();
            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);

            return sqlSessionTemplate.selectOne(NS + "count", param);
        }
        return sqlSessionTemplate.selectOne(NS + "count");
    }

    public int maxnum() {
        return sqlSessionTemplate.getMapper(BoardMapper.class).maxnum();
    }

    public List<Board> list(int pageNum, int limit, String searchtype, String searchcontent) {
        param.clear();
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

    public void readcntadd(int num) {
        param.clear();
        param.put("num", num);

        sqlSessionTemplate.getMapper(BoardMapper.class).readcntadd(num);
    }

    public int insert(Board board) {
        return sqlSessionTemplate.getMapper(BoardMapper.class).insert(board);
    }

    public void updateRefStep(int ref, int refstep) {
        param.clear();
        param.put("ref", ref);
        param.put("refstep", refstep);

        sqlSessionTemplate.getMapper(BoardMapper.class).updaterefstep(param);
    }

    public int update(Board board) {
        return sqlSessionTemplate.getMapper(BoardMapper.class).update(board);
    }

    public int delete(Integer num) {
        param.clear();
        param.put("num", num);

        return sqlSessionTemplate.getMapper(BoardMapper.class).delete(num);
    }

    public List<Map<String,Object>> graph(){
        return sqlSessionTemplate.getMapper(BoardMapper.class).graph();
    }
}
