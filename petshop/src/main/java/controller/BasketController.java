package controller;

import logic.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("basket")
public class BasketController {
    @Autowired
    private ShopService service;

    @RequestMapping("add")
    public ModelAndView add(HttpSession session, HttpServletRequest request, Integer item_no, Integer quantity) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        Basket basket = new Basket();
        basket.setMember_id(loginMember.getId());
        basket.setItem_no(item_no);
        basket.setQuantity(Objects.requireNonNullElse(quantity, 1));

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
    public ModelAndView update(HttpSession session, HttpServletRequest request, Integer item_no, Integer quantity) {
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
    public ModelAndView delete(HttpSession session, HttpServletRequest request, Integer item_no, String items) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));
        ModelAndView mav = new ModelAndView("/alert");

        int result;
        boolean error_occured = false;

        if (item_no == null && items == null || items != null && items.length() == 0) {
            mav.addObject("msg", "삭제할 상품이 선택되지 않았습니다!");
            mav.addObject("url", "view.shop");

            return mav;
        }

        if (items == null) {
            result = service.basketDelete(loginMember.getId(), item_no);
            if (result <= 0) {
                error_occured = true;
            }
        } else {
            String[] items_selected = items.split(",");

            for (String item : items_selected) {
                result = service.basketDelete(loginMember.getId(), Integer.parseInt(item));
                if (result <= 0) {
                    error_occured = true;
                }
            }
        }

        if (!error_occured) {
            if (items == null) {
                mav.addObject("msg", "해당 상품이 장바구니에서 삭제 되었습니다.");
            } else {
                mav.addObject("msg", "선택하신 상품들이 장바구니에서 삭제 되었습니다.");
            }
            mav.addObject("url", request.getHeader("referer"));
        } else {
            if (items == null) {
                mav.addObject("msg", "해당 상품을 장바구니에서 삭제하는데 실패하였습니다!");
            } else {
                mav.addObject("msg", "일부 선택하신 상품들을 삭제하는데 실패하였습니다!");
            }
            mav.addObject("url", request.getHeader("referer"));
        }

        return mav;
    }

    @RequestMapping("view")
    public ModelAndView view(HttpSession session, HttpServletRequest request) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));

        List<Basket> basketList = service.basketList(loginMember.getId());
        ModelAndView mav = new ModelAndView("basket/basket");
        mav.addObject("basketList", basketList);

        int max_item_num = service.item_max_item_no();
        int limit = 6;
        List<Item> randomitemList = new ArrayList<>();

        System.out.print("basket/view: randomList-item_no: [ ");
        for (int i = 1; i < max_item_num; i++) {
            int random_item_no = (int) (Math.random() * max_item_num) + 1;
            Item item = service.getItemById(random_item_no);

            if (item == null) {
                i--;
                continue;
            } else {
                boolean random_dupicated = false;
                for (Item randomitem : randomitemList) {
                    if (randomitem.getItem_no() == random_item_no) {
                        i--;
                        random_dupicated = true;
                        break;
                    }
                }
                if (random_dupicated) {
                    continue;
                }

                randomitemList.add(item);
                System.out.print(random_item_no + " ");
            }

            if (i + 1 > limit) {
                break;
            }
        }
        System.out.println("]");
        mav.addObject("randomitemList", randomitemList);

        return mav;
    }

    @RequestMapping("checkout")
    public ModelAndView checkout(HttpSession session, HttpServletRequest request, String items) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));
        List<Basket> basketList = service.basketList(loginMember.getId());
        List<Basket> checkoutList = new ArrayList<>();

        ModelAndView mav = new ModelAndView("/alert");
        if (items == null || items.length() == 0) {
            mav.addObject("msg", "주문할 상품이 선택되지 않았습니다!");
            mav.addObject("url", "view.shop");

            return mav;
        } else {
            String[] items_selected = items.split(",");

            for (Basket basket : basketList) {
                for (String item : items_selected) {
                    try {
                        if (basket.getItem_no() == Integer.parseInt(item)) {
                            checkoutList.add(basket);
                        }
                    } catch (NumberFormatException e) {
                        mav.addObject("msg", "주문할 상품 목록이 올바르게 선택되지 않았습니다!");
                        mav.addObject("url", "view.shop");

                        return mav;
                    }
                }
            }
        }

        mav = new ModelAndView("basket/checkout");
        mav.addObject("checkoutList", checkoutList);
        mav.addObject("loginMember", loginMember);

        mav.addObject("items", items);

        List<Deposit> depositList = service.depositList();
        mav.addObject("depositList", depositList);

        return mav;
    }

    @PostMapping("order")
    public ModelAndView order(HttpSession session, HttpServletRequest request, Orders order, String items) {
        Member loginMember = (Member)session.getAttribute(("loginMember"));
        List<Basket> basketList = service.basketList(loginMember.getId());
        List<Basket> orderList = new ArrayList<>();

        ModelAndView mav = new ModelAndView("/alert");
        if (items == null || items.length() == 0) {
            mav.addObject("msg", "주문할 상품이 선택되지 않았습니다!");
            mav.addObject("url", "view.shop");

            return mav;
        } else {
            String[] items_selected = items.split(",");

            for (Basket basket : basketList) {
                for (String item : items_selected) {
                    try {
                        if (basket.getItem_no() == Integer.parseInt(item)) {
                            orderList.add(basket);
                        }
                    } catch (NumberFormatException e) {
                        mav.addObject("msg", "주문할 상품 목록이 올바르게 선택되지 않았습니다!");
                        mav.addObject("url", "view.shop");

                        return mav;
                    }
                }
            }
        }

        int result = service.ordersAdd(loginMember.getId(), order, orderList);
        if (result > 0) {
            mav.addObject("msg", "주문이 완료되었습니다.");
            mav.addObject("url", "end.shop");
        } else {
            mav.addObject("msg", "주문 처리를 하는 중 문제가 발생하였습니다!");
            mav.addObject("url", "checkout.shop?items=" + items);
        }

        return mav;
    }

    @RequestMapping("*")
    public String basket (HttpSession session, HttpServletRequest request) {
        return  null;
    }
}
