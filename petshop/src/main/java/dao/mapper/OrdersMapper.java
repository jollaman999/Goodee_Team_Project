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

    // 전날대비 이득
    @Select("select " +
            "date_format(a._day, '%Y-%m-%d') _day, ifnull(sum(a.price_total), 0) total, " +
            "(ifnull(" +
            "ifnull(sum(a.price_total), 0) - (" +
            "select sum(b.price_total) " +
            "from ( select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-%d') _day " +
            "from orders where status in (1, 2 ,3) group by _day) b where " +
            "b._day = (a._day - interval 1 day)), null)) totaldiff " +
            "from (select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-%d') _day " +
            "from orders where status in (1, 2 ,3) group by _day) a group by date_format(a._day, '%Y-%m-%d') order by _day desc")
    List<Orders> day_profit();

    // 전월대비 이득
    @Select("select " +
            "date_format(a._month, '%Y-%m-%d') _month, ifnull(sum(a.price_total), 0) total, " +
            "(ifnull(" +
            "ifnull(sum(a.price_total), 0) - (" +
            "select sum(b.price_total) " +
            "from (select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-01') _month " +
            "from orders where status in (1, 2 ,3) group by _month) b where " +
            "b._month = (a._month - interval 1 month)), null)) totaldiff " +
            "from (select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-%m-01') _month " +
            "from orders where status in (1, 2 ,3) group by _month) a group by date_format(a._month, '%Y-%m-%d') order by _month desc")
    List<Orders> month_profit();

    // 전년대비 이득
    @Select("select " +
            "date_format(a._year, '%Y-%m-%d') _year, ifnull(sum(a.price_total), 0) total, " +
            "(ifnull(" +
            "ifnull(sum(a.price_total), 0) - (" +
            "select sum(b.price_total) " +
            "from ( select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-01-01') _year " +
            "from orders where status in (1, 2 ,3) group by _year) b where " +
            "b._year = (a._year - interval 1 year)), null)) totaldiff " +
            "from (select ifnull(sum(price_total), 0) price_total, date_format(update_time, '%Y-01-01') _year " +
            "from orders where status in (1, 2 ,3) group by _year) a group by date_format(a._year, '%Y-%m-%d') order by _year desc")
    List<Orders> year_profit();
}



