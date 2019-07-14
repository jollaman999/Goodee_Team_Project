package dao.mapper;

import logic.Board;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface BoardMapper {
    @Update("update board set readcnt = readcnt + 1 where num = #{num}")
    void readcntadd(int num);

    @Select("select ifnull(max(num), 0) from board")
    int maxnum();

    @Insert("insert into board (num, name, pass, subject, content, file1, regdate, readcnt, ref, reflevel, refstep) " +
                            "values (#{num}, #{name}, #{pass}, #{subject}, #{content}, #{fileurl}, now(), 0, #{ref}, #{reflevel}, #{refstep})")
    int insert(Board board);

    @Update("update board set refstep = refstep + 1 where ref = #{ref} and refstep > #{refstep}")
    void updaterefstep(Map map);

    @Update("update board set name = #{name}, subject = #{subject}, content = #{content}, file1 = #{fileurl} where num = #{num}")
    int update(Board board);

    @Delete("delete from board where num = #{num}")
    int delete(int num);

    @Select("select name key1, count(*) as value1 from board group by name having count(*) > 0")
    List<Map<String, Object>> graph();
}
