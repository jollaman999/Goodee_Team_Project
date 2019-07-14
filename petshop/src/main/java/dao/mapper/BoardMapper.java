package dao.mapper;

import logic.Board;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface BoardMapper {
    @Select("select ifnull(max(num), 0) from board")
    int maxnum();

    @Insert("insert into board (num, member_id, title, content, file1, regdate) " +
                            "values (#{num}, #{member_id}, #{title}, #{content}, #{fileurl}, now())")
    int insert(Board board);

    @Update("update board set title = #{title}, content = #{content}, file1 = #{fileurl}, regdate = now() where num = #{num}")
    int update(Board board);

    @Delete("delete from board where num = #{num}")
    int delete(int num);
}
