package dao.mapper;

import logic.Reply;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface ReplyMapper {
    @Select("select ifnull(max(num), 0) from reply")
    int maxnum();

    @Select("select * from reply where num = #{num}")
    Reply selectOne(int num);

    @Select(("select count(*) from reply where type = #{type} and itemno = #{itemno}"))
    int reply_count(Map map);

    @Select("select * from reply where type = #{type} and itemno = #{itemno} order by num desc limit #{pageNum}, #{limit}")
    List<Reply> list(Map map);

    @Insert("insert into reply (num, type, itemno, member_id, content, regdate) values" +
            "(#{num}, #{type}, #{itemno}, #{member_id}, #{content}, now())")
    int insert(Reply reply);

    @Update("update reply set content = #{content}, regdate = now() where num = #{num}")
    int update(Map map);

    @Delete("delete from reply where num = #{num}")
    int delete(int itemno);
}
