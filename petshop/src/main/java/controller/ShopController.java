package controller;

import logic.CategoryGroup;
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
    public ModelAndView list(Integer category_group, Integer category_item,
                             Integer pageNum, String searchtype, String searchcontent) {
        ModelAndView mav = new ModelAndView();

        mav.addObject("category_group", category_group);
        mav.addObject("category_item", category_item);

        if (category_group != null) {
            String categoryGroupName = service.getCategoryGroupName(category_group);
            mav.addObject("categoryGroupName", categoryGroupName);
            if (category_item != null) {
                String categoryItemName = service.getCategoryItemName(category_group, category_item);
                mav.addObject("categoryItemName", categoryItemName);
            }
        }

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
    public ModelAndView detail(int item_no) {
        ModelAndView mav = new ModelAndView();

        Item item = service.getItemById(item_no);
        item.setDescription(item.getDescription().replaceAll(System.getProperty("line.separator"), "<br>"));
        item.setContent(item.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

        String categoryGroupName = service.getCategoryGroupName(item.getCategory_group_code());
        String categoryItemName = service.getCategoryItemName(item.getCategory_group_code(), item.getCategory_item_code());

        mav.addObject("categoryGroupName", categoryGroupName);
        mav.addObject("categoryItemName", categoryItemName);

        mav.addObject("item", item);

        return mav;
    }
}
