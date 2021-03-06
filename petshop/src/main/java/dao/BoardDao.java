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
		if (type != 0) {
			param.put("id", id);
		}

		if (searchtype != null && searchtype.length() != 0 && searchcontent != null && searchcontent.length() != 0) {
			if (searchtype.equals("name")) {
				if (id != null && id.equals("admin")) {
					param.put("name", searchcontent);

					return sqlSessionTemplate.getMapper(BoardMapper.class).search_by_name_count(param);
				}

				return 0;
			}
			if (searchtype.equals("item_name")) {
				if (id != null) {
					param.put("item_name", searchcontent);

					return sqlSessionTemplate.getMapper(BoardMapper.class).search_by_item_name_count(param);
				}
				return 0;
			}

			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}

		return sqlSessionTemplate.selectOne(NS + "count", param);
	}

	public int maxnum() {
		return sqlSessionTemplate.getMapper(BoardMapper.class).maxnum();
	}

	private List<Board> get_boardList(List<Board> boardList, int type) {
		if (boardList != null  && type != 0) {
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

	public List<Board> list(int type, int pageNum, int limit, String searchtype, String searchcontent, String id) {
		param.clear();
		param.put("type", type);
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit", limit);
		if (type != 0) {
			param.put("id", id);
		}

		if (searchtype != null && searchtype.length() != 0 && searchcontent != null && searchcontent.length() != 0) {
			if (searchtype.equals("name")) {
				if (id != null && id.equals("admin")) {
					param.put("name", searchcontent);

					List<Board> boardList = sqlSessionTemplate.getMapper(BoardMapper.class).search_by_name(param);
					return get_boardList(boardList, type);
				}

				return null;

			}
			if (searchtype.equals("item_name")) {
				if (id != null) {
					param.put("item_name", searchcontent);

					List<Board> boardList = sqlSessionTemplate.getMapper(BoardMapper.class).search_by_item_name(param);
					return get_boardList(boardList, type);
				}
				return null;
			}
			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}

		List<Board> boardList = sqlSessionTemplate.selectList(NS + "list", param);
		return get_boardList(boardList, type);
	}

	public Board selectOne(int num, int type) {
		param.clear();
		param.put("num", num);

		Board board = sqlSessionTemplate.selectOne(NS + "list", param);
		if (board != null && type != 0) {
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
