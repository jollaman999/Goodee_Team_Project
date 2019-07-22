package dao.mapper;

import logic.Recommend;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

public interface RecommendMapper {
    @Select("select count(*) from recommend where type = #{type} and itemno = #{itemno}")
    int recom_cnt(Map map);

    @Select("select count(*) from recommend where type = #{type} and itemno = #{itemno} and member_id = #{member_id}")
    int recom_check(Recommend recommend);

    @Insert("insert into recommend (type, itemno, member_id) values (#{type}, #{itemno}, #{member_id})")
    int recom_add(Recommend recommend);

    @Delete("delete from recommend where type = #{type} and itemno = #{itemno} and member_id = #{member_id}")
    int recom_delete(Recommend recommend);
}
