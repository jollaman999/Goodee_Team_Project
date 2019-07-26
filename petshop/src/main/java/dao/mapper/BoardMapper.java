package dao.mapper;

import logic.Board;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface BoardMapper {
    @Select("select ifnull(max(num), 0) from board")
    int maxnum();

    @Select("select count(*) from board b, member m where type = #{type} and b.member_id = m.id and m.name like '%${name}%'")
    int search_by_name_count(Map map);
    
    @Select("select count(*) from board b, item i where type = #{type} and b.item_no = i.item_no and i.name like '%${item_name}%'")
    int search_by_item_name_count(Map map);

    @Select("select b.num, b.item_no, b.member_id, m.name, b.title, b.content, b.file1 fileurl, b.regdate from board b, member m " +
            "where type = #{type} and b.member_id = m.id and m.name like '%${name}%' order by num desc limit #{startrow}, #{limit}")
    List<Board> search_by_name(Map map);
    
    @Select("select b.num, b.item_no, b.member_id, i.name, b.title, b.content, b.file1 fileurl, b.regdate from board b, item i " + 
    		"where type = #{type} and b.item_no = i.item_no and i.name like '%${item_name}%' order by b.num desc limit #{startrow}, #{limit}")
    List<Board> search_by_item_name(Map map);

    @Insert("insert into board (num, item_no, type, member_id, title, content, file1, regdate) " +
                            "values (#{num}, #{item_no}, #{type}, #{member_id}, #{title}, #{content}, #{fileurl}, now())")
    int insert(Board board);

    @Update("update board set title = #{title}, content = #{content}, file1 = #{fileurl}, regdate = now() where num = #{num}")
    int update(Board board);

    @Delete("delete from board where num = #{num}")
    int delete(int num);
}
