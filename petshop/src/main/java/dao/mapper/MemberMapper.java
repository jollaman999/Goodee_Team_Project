package dao.mapper;

import logic.Member;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

public interface MemberMapper {
    @Insert("insert into member " +
            "(id, pass, name, phone, email, address, address_detail, postcode) " +
            "values (#{id}, #{pass}, #{name}, #{phone}, #{email}, #{address}, #{address_detail}, #{postcode})")
    void insert(Member member);

    @Update("update member set name = #{name}, phone = #{phone}," +
            "email = #{email}, address = #{address}, address_detail = #{address_detail}, postcode = #{postcode} where id = #{id}")
    void update(Member member);

    @Update("update member set pass = #{pass}, email = #{email} where id = #{id}")
    void update_pass(Member member);

    @Delete("delete from member where id = #{id}")
    void delete(Member member);
}