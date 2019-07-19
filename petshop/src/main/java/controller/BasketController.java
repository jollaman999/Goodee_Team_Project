package controller;

import exception.CartEmptyException;
import logic.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("basket")
public class BasketController {
    @Autowired
    private ShopService service;

    @RequestMapping("add")
    public ModelAndView add(HttpSession session, HttpServletRequest request, Integer item_no) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        Basket basket = new Basket();
        basket.setMember_id(loginMember.getId());
        basket.setItem_no(item_no);
        int result = service.basketAdd(basket);

        ModelAndView mav = new ModelAndView("/alert");
        if (result > 0) {
            mav.addObject("msg", "장바구니에 상품이 추가되었습니다.");
            mav.addObject("url", request.getHeader("referer"));
        } else {
            mav.addObject("msg", "장바구니 상품 추가 실패!");
            mav.addObject("url", request.getHeader("referer"));
        }

        return mav;
    }

    @PostMapping("update")
    public ModelAndView add(HttpSession session, HttpServletRequest request, Integer item_no, Integer quantity) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        Basket basket = new Basket();
        basket.setMember_id(loginMember.getId());
        basket.setItem_no(item_no);
        basket.setQuantity(quantity);
        int result = service.basketUpdate(basket);

        ModelAndView mav = new ModelAndView("/alert");
        if (result > 0) {
            mav.addObject("msg", "해당 상품의 수량이 변경되었습니다.");
            mav.addObject("url", request.getHeader("referer"));
        } else {
            mav.addObject("msg", "상품 수량 변경 실패!");
            mav.addObject("url", request.getHeader("referer"));
        }

        return mav;
    }

    @RequestMapping("delete")
    public ModelAndView delete(Integer index, HttpSession session) {
        Cart cart = (Cart)session.getAttribute("CART");
        ModelAndView mav = new ModelAndView("cart/cart");

        ItemSet selectedItemSet = null;

        try {
            // selectedItem : ItemSetList 리스트 객체에서 삭제된 객체
            selectedItemSet = cart.getItemSetList().remove((int)index);
            mav.addObject("message", selectedItemSet.getItem().getName() + "상품 장바구니에서 삭제");
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message", selectedItemSet.getItem().getName() + "상품 장바구니에서 삭제 실패");
        }

        if (cart.isEmpty()) {
            mav.addObject("message2", "장바구니가 비어있습니다.");
        }

        mav.addObject("cart", cart);
        return mav;
    }

    @RequestMapping("view")
    public ModelAndView view(HttpSession session) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        List<Basket> basketList = service.basketList(loginMember.getId());
        ModelAndView mav = new ModelAndView("basket/cart");

        if (basketList == null || basketList.isEmpty()) {
            throw new CartEmptyException("장바구니에 상품이 없습니다.", "../item/list.shop");
        }

        mav.addObject("basketList", basketList);

        return mav;
    }

    @RequestMapping("checkout")
    public String checkout (HttpSession session) {
        return "cart/checkout";
    }

    /*
    주문 확정
    1. 주문테이블에 내용 등록
    2. 장바구니의 상품 제거
     */
    @RequestMapping("end")
    public ModelAndView checkend (HttpSession session) {
        ModelAndView mav = new ModelAndView();
        Cart cart = (Cart)session.getAttribute("CART");
        Member loginMember = (Member)session.getAttribute("loginMember");
        Sale sale = service.checkEnd(loginMember, cart);
        long tot = cart.getTotal();
        cart.clearAll(session);
        mav.addObject("sale", sale);
        mav.addObject("tot", tot);

        return mav;
    }

    @RequestMapping("*")
    public String basket (HttpSession session) {
        return  null;
    }
}
