package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Orders;



public interface OrdersMapper {
	
    @Select("select ifnull(max(num), 0) from orders")
    int max_num();
    
    @Insert("insert into orders (num, member_id, name, phone, phone2, address, address_detail, postcode, " +
            "deposit_bank_select, account_holder, account_bank, account_number, price_total, update_time) " +
            "values (#{num}, #{member_id}, #{name}, #{phone}, #{phone2}, #{address}, #{address_detail}, #{postcode}, #{deposit_bank_select}, #{account_holder}, #{account_bank}, #{account_number}, #{price_total}, now())")
    int insert(Orders order);

    @Update("update orders set name = #{name}, phone = #{phone}, phone2 = #{phone2}, address = #{address}, address_detail = #{address_detail}, postcode = #{postcode}, " +
            "deposit_bank_select = #{deposit_bank_select}, status=#{status}, account_holder = #{account_holder}, account_bank = #{account_bank}, account_number = #{account_number}, price_total = #{price_total}, update_time = now() " +
            "where num = #{num}")
    int update(Orders order);

    @Delete("delete from orders where num = #{num}")
    int delete(Integer num);
    
    
    // 날짜별 금액 토탈 가져오기
    @Select("select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-%d') update_time from orders where status in (1, 2 ,3) group by date_format(update_time, '%Y-%m-%d')")
    List<Orders> moneyList_by_day();
    
    // 월별 금액 토탈 가져오기
    @Select("select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-%d') update_time from orders where status in (1, 2 ,3) group by date_format(update_time, '%Y-%m')")
    List<Orders> moneyList_by_month();
    
    // 년별 금액 토탈 가져오기
    @Select("select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-%d') update_time from orders where status in (1, 2, 3) group by date_format(update_time, '%Y')")
    List<Orders> moneyList_by_year();
}
