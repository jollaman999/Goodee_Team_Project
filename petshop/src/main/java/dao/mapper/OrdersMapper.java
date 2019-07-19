package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Orders;



public interface OrdersMapper {
	
    @Select("select ifnull(max(num),0) from orders")
    int max_num();
    
    @Insert("insert into (num,member_id,name,phone,phone2,address,deposit_bank_select,status,account_holder,account_bank,account_num,update_time) " +
            "values (#{num},#{member_id},#{name},#{phone},#{phone2},#{address},#{deposit_bank_select},#{status},#{account_holder},#{account_bank},#{account_num},#{update_time}, now())")
    int insert(Orders orders);

    @Update("update orders set num=#{num},member_id=#{member_id},name=#{name},phone=#{phone},phone2=#{phone2},address=#{address},deposit_bank_select=#{deposit_bank_select},status=#{status}, " +
            "account_holder=#{account_holder},account_bank=#{account_bank},account_num=#{account_num},update_time = now() " +
            "where num = #{num}")
    int update(Orders orders);

    @Delete("delete from orders where num = #{num}")
    int delete(Integer num);

}
