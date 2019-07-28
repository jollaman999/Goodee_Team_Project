package controller;

import logic.CategoryGroup;
import logic.CategoryItem;
import logic.Item;
import logic.Orders;
import logic.ShopService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("inventory")
public class InventoryController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView inventoryManagement(Integer type, Integer pageNum, Integer limit,
                                            String searchtype, String searchcontent, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<CategoryGroup> CategoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList = service.getCategoryItemList();

        mav.addObject("CategoryGroupList", CategoryGroupList);
        mav.addObject("CategoryItemList", CategoryItemList);

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        if (limit == null || limit.toString().equals("")) {
            limit = 20;
        }

        List<Item> itemList = service.getItemList(null, null,
                pageNum, limit, searchtype, searchcontent, null, null,
                true);
        mav.addObject("itemList", itemList);

        int listcount = service.itemcount(null, null, searchtype, searchcontent, null, null);
        int maxpage = listcount / limit;
        if (listcount % limit != 0) {
            maxpage++;
        }

        int startpage = pageNum / limit;
        if (pageNum % limit != 0) {
            startpage++;
        }

        int endpage = startpage + 9;
        if (endpage > maxpage) {
            endpage = maxpage;
        }

        mav.addObject("limit", limit);
        mav.addObject("pageNum", pageNum);
        mav.addObject("maxpage", maxpage);
        mav.addObject("startpage", startpage);
        mav.addObject("endpage", endpage);
        mav.addObject("listcount", listcount);

        return mav;
    }

    @RequestMapping("detail")
    public ModelAndView detail(Integer item_no, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (item_no == null || item_no.toString().length() == 0) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList", categoryGroupList);
        mav.addObject("categoryItemList", categoryItemList);

        Item item = service.getItemById(item_no, true);
        mav.addObject("item", item);
        return mav;
    }

    // list -> submit
    @PostMapping("listsubmit")
    public ModelAndView itemUpdate(Integer item_no, Integer itemUpdate, HttpSession session) {
        Item item = service.getItemById(item_no, true);

        // 현 수량에 추가한 수량을 더해줌
        item.setQuantity(item.getQuantity() + itemUpdate);
        int result = service.itemUpdate(item);
        
    	/*  //에러 출력
        if (result == item.getQuantity() || result == 0) {
            throw new ShopException("수량을 정상적으로 입력해주세요.", "list.shop");
        }  */

        // 알러트 출력.
        ModelAndView mav = new ModelAndView("/alert");
        if (result > 0) {
            mav.addObject("msg", "수량이 증가하였습니다.");
            mav.addObject("url", "list.shop");
        } else {
            mav.addObject("msg", "수량 증가가 실패 하였습니다.");
            mav.addObject("url", "list.shop");
        }

        return mav;
    }

    @RequestMapping("selling")
    public ModelAndView selling(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        //받아올 테이블
        List<Item> itemList = service.getItemList(null, null,
                null, null, null, null, null, null,
                true);
        List<CategoryGroup> CategoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList = service.getCategoryItemList();
        List<Orders> OrdersList = service.getOrdersList(null, null);

        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList", CategoryGroupList);
        mav.addObject("CategoryItemList", CategoryItemList);
        mav.addObject("Orderslist", OrdersList);

        return mav;
    }

    @RequestMapping("money_day")
    public ModelAndView money_day(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<Orders> day_profit = service.day_profit();
        mav.addObject("day_profit", day_profit);

        return mav;
    }

    @RequestMapping("money_month")
    public ModelAndView money_month(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<Orders> month_profit = service.month_profit();
        mav.addObject("month_profit", month_profit);

        return mav;
    }

    @RequestMapping("money_year")
    public ModelAndView money_year(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<Orders> year_profit = service.year_profit();
        mav.addObject("year_profit", year_profit);

        return mav;
    }

    @RequestMapping("money_item")
    public ModelAndView money_item(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<Item> itemList = service.getItemList(null, null,
                null, null, null, null, null, null,
                true);
        mav.addObject("itemList", itemList);

        return mav;
    }
}
