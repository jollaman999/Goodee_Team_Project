package dao;

import dao.mapper.BasketMapper;
import logic.Basket;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("BasketDao")
public class BasketDao {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.BasketMapper.";
    private Map<String, Object> param = new HashMap<>();

    public int count(String member_id) {
        return sqlSessionTemplate.getMapper(BasketMapper.class).count(member_id);
    }

    public List<Basket> list(String member_id) {
        param.clear();
        param.put("member_id", member_id);

        return sqlSessionTemplate.selectList(NS + "list", param);
    }

    public int insert(Basket basket) {
        List<Basket> basketList = list(basket.getMember_id());
        if (basketList != null) {
            for (Basket b : basketList) {
                if (b.getItem_no() == basket.getItem_no()) {
                    basket.setQuantity(b.getQuantity() + 1);
                    return update(basket);
                }
            }
        }

        int count = count(basket.getMember_id());
        basket.setList_num(++count);

        return sqlSessionTemplate.getMapper(BasketMapper.class).insert(basket);
    }

    public int update(Basket basket) {
        return sqlSessionTemplate.getMapper(BasketMapper.class).update(basket);
    }

    // 장바구니에서 특정 상품을 특정 회원의 장바구니 목록에서 삭제 (삭제 후 목록 번호 재설정)
    public int delete(String member_id, int item_no) {
        param.clear();
        param.put("member_id", member_id);
        param.put("item_no", item_no);

        Basket basket = sqlSessionTemplate.selectOne(NS + "list", param);
        if (basket == null) {
            return 0;
        }

        param.put("list_num", basket.getList_num());
        sqlSessionTemplate.getMapper(BasketMapper.class).update_list_num(param);

        return sqlSessionTemplate.getMapper(BasketMapper.class).delete(param);
    }

    // 특정 회원의 장바구니 목록을 삭제
    public int clear(String member_id) {
        param.clear();
        param.put("member_id", member_id);

        return sqlSessionTemplate.getMapper(BasketMapper.class).clear(param);
    }
}
