package controller;

import exception.CartEmptyException;
import logic.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("cart")
public class CartController {
    @Autowired
    private ShopService service;

    @RequestMapping("cartAdd")
    public ModelAndView add(Integer id, Integer quantity, HttpSession session) {
        Item selectedItem = service.getItemById(id);
        Cart cart = (Cart)session.getAttribute("CART");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("CART", cart);
        }

        cart.push(new ItemSet(selectedItem, quantity));
        ModelAndView mav = new ModelAndView("cart/cart");
        mav.addObject("message", selectedItem.getName() + " : " + quantity + "개 장바구니 추가");
        mav.addObject("cart", cart);
        return mav;
    }

    @RequestMapping("cartDelete")
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

    @RequestMapping("cartView")
    public ModelAndView view(HttpSession session) {
        Cart cart = (Cart)session.getAttribute("CART");
        ModelAndView mav = new ModelAndView("cart/cart");

        if (cart == null || cart.isEmpty()) {
            throw new CartEmptyException("장바구니에 상품이 없습니다.", "../item/list.shop");
        }
        mav.addObject("cart", cart);

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
    public String cart (HttpSession session) {
        return  null;
    }
}
