package controller;

import logic.Item;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("shop")
public class ShopController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list(HttpSession session, Integer category_group, Integer category_item,
                             Integer pageNum, String searchtype, String searchcontent) {
        ModelAndView mav = new ModelAndView();

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        int limit = 12;
        int listcount = service.itemcount(category_group, category_item, searchtype, searchcontent);
        List<Item> itemList  = service.getItemList(category_group, category_item, pageNum, limit, searchcontent, searchtype);

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

        mav.addObject("pageNum", pageNum);
        mav.addObject("maxpage", maxpage);
        mav.addObject("startpage", startpage);
        mav.addObject("endpage", endpage);
        mav.addObject("listcount", listcount);
        mav.addObject("itemList", itemList);

        return mav;
    }

    @RequestMapping("*")
    public ModelAndView detail(int item_no, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        Item item = service.getItemById(item_no);
        mav.addObject("item", item);
        return mav;
    }
}
