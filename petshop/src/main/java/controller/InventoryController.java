package controller;


import logic.CategoryGroup;
import logic.CategoryItem;
import logic.Item;
import logic.Orders_list;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    public ModelAndView inventoryManagement(HttpSession session) {

        ModelAndView mav = new ModelAndView();
        
        //받아올 테이블
        List<Item> itemList  = service.getItemList();
        List<CategoryGroup> CategoryGroupList  = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList  = service.getCategoryItemList();
        List<Orders_list> Orders_listList = service.getOrders_listList();
    
        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList",CategoryGroupList);
        mav.addObject("CategoryItemList",CategoryItemList);
        mav.addObject("Orders_listList",Orders_listList);
        
        return mav;
    }
    
    @RequestMapping("detail")
    public ModelAndView inventoryManagementdetail(HttpSession session) {
        List<Item> itemList  = service.getItemList();
        ModelAndView mav = new ModelAndView();
        mav.addObject("itemList", itemList);
        return mav;
    }

    /*
    //페이징
    @RequestMapping("InventoryManagement")
    public ModelAndView list(HttpSession session, Integer pageNum, String searchtype, String searchcontent) {
        ModelAndView mav = new ModelAndView();

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        int limit = 10;
        int listcount = service.boardcount(searchtype, searchcontent);
        List<Board> boardlist = service.boardlist(pageNum, limit, searchtype, searchcontent);
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

        int boardno = listcount - (pageNum - 1) * limit;

        mav.addObject("pageNum", pageNum);
        mav.addObject("maxpage", maxpage);
        mav.addObject("startpage", startpage);
        mav.addObject("endpage", endpage);
        mav.addObject("listcount", listcount);
        mav.addObject("boardlist", boardlist);
        mav.addObject("boardno", boardno);

        return mav;
    }    */
}
