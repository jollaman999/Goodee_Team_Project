package dao.mapper;

import logic.SaleItem;
import org.apache.ibatis.annotations.Insert;

public interface SaleItemMapper {
    @Insert("insert into saleitem (saleid, saleitemid, itemid, quantity) values (#{saleId}, #{saleItemId}, #{item.id}, #{quantity})")
    void insert(SaleItem saleItem);
}
