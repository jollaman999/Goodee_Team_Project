package dao;

import dao.mapper.BoardMapper;
import logic.Board;
import logic.Item;

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

    public int count(int type, String searchtype, String searchcontent, String id) {
        param.clear();
        param.put("type", type);
        param.put("id", id);

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            if (searchtype.equals("name")) {
                param.put("name", searchcontent);

                return sqlSessionTemplate.getMapper(BoardMapper.class).search_by_name_count(param);
            }

            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        return sqlSessionTemplate.selectOne(NS + "count", param);
    }

    public int maxnum() {
        return sqlSessionTemplate.getMapper(BoardMapper.class).maxnum();
    }

    public List<Board> list(int type, int pageNum, int limit, String searchtype, String searchcontent, String id) {
        param.clear();
        param.put("type", type);
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);
        param.put("id", id);

        if (searchtype != null && searchtype.length() != 0 &&
                searchcontent != null && searchcontent.length() != 0) {
            if (searchtype.equals("name")) {
                param.put("name", searchcontent);

                return sqlSessionTemplate.getMapper(BoardMapper.class).search_by_name(param);
            }

            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        List<Board> boardList = sqlSessionTemplate.selectList(NS + "list", param);
        if (boardList != null) {
            final String ItemMapper = "dao.mapper.ItemMapper.";

            for (Board board : boardList) {
            	param.clear();
                param.put("item_no", board.getItem_no());
                
                Item item = sqlSessionTemplate.selectOne(ItemMapper + "list", param);
                if (item != null) {
                    board.setItem_name(item.getName());
                }
            }
        }

        return boardList;
    }

    public Board selectOne(int num) {
        param.clear();
        param.put("num", num);

        Board board = sqlSessionTemplate.selectOne(NS + "list", param);
        if (board != null) {
        	param.clear();
            param.put("item_no", board.getItem_no());
            
            final String ItemMapper = "dao.mapper.ItemMapper.";
            Item item = sqlSessionTemplate.selectOne(ItemMapper + "list", param);
            if (item != null) {
                board.setItem_name(item.getName());
            }
        }

        return board;
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
