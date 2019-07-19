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
            mav.addObject("msg", "해당 상품의 수량 변경을 실패 하였습니다!");
            mav.addObject("url", request.getHeader("referer"));
        }

        return mav;
    }

    @RequestMapping("delete")
    public ModelAndView delete(HttpSession session, HttpServletRequest request, Integer item_no) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        int result = service.basketDelete(loginMember.getId(), item_no);

        ModelAndView mav = new ModelAndView("/alert");
        if (result > 0) {
            mav.addObject("msg", "해당 상품이 장바구니에서 삭제 되었습니다.");
            mav.addObject("url", request.getHeader("referer"));
        } else {
            mav.addObject("msg", "해당 상품을 장바구니에서 삭제하는데 실패하였습니다!");
            mav.addObject("url", request.getHeader("referer"));
        }

        return mav;
    }

    @RequestMapping("view")
    public ModelAndView view(HttpSession session) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        List<Basket> basketList = service.basketList(loginMember.getId());
        ModelAndView mav = new ModelAndView("basket/cart");

        mav.addObject("basketList", basketList);

        return mav;
    }

    @RequestMapping("checkout")
    public String checkout (HttpSession session) {
        return "order/checkout";
    }

    @RequestMapping("*")
    public String basket (HttpSession session) {
        return  null;
    }
}
