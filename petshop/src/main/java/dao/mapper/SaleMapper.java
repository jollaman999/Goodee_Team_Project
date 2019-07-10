package dao.mapper;

import logic.Sale;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface SaleMapper {
    @Select("select ifnull(max(saleid), 0) from sale")
    int maxsaleid();

    @Insert("insert into sale (saleid, userid, updatetime) values (#{saleId}, #{user.userId}, #{updatetime})")
    void insert(Sale sale);
}
