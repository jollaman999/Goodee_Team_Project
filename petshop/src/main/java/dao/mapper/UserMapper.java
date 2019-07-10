package dao.mapper;

import logic.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

public interface UserMapper {
    @Insert("insert into useraccount " +
            "(userid, username, password, birthday, phoneno, postcode, address, email) " +
            "values (#{userId}, #{userName}, #{password}, #{birthDay}, #{phoneNo}, #{postcode}, #{address}, #{email})")
    void insert(User user);

    @Update("update useraccount set password = #{password}, username = #{userName}, phoneno = #{phoneNo}," +
            "postcode = #{postcode}, address = #{address}, email = #{email} where userid = #{userId}")
    void update(User user);

    @Delete("delete from useraccount where userid = #{userId}")
    void delete(User user);
}