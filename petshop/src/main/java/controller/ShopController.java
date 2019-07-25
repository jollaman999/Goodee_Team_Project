package controller;

import logic.Item;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("shop")
public class ShopController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list(Integer category_group, Integer category_item,
                             Integer pageNum, String searchtype, String searchcontent,
                             Integer min_price, Integer max_price) {
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

        int real_min_price = service.item_min_price(category_group, category_item);
        int real_max_price = service.item_max_price(category_group, category_item);

        if (min_price == null || min_price.toString().equals("")) {
            min_price = real_min_price;
        }

        if (max_price == null || max_price.toString().equals("")) {
            max_price = real_max_price;
        }

        mav.addObject("min_price", min_price);
        mav.addObject("max_price", max_price);
        mav.addObject("real_min_price", real_min_price);
        mav.addObject("real_max_price", real_max_price);

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        int limit = 12;
        int listcount = service.itemcount(category_group, category_item, searchtype, searchcontent, min_price, max_price);
        List<Item> itemList  = service.getItemList(category_group, category_item, pageNum, limit, searchcontent, searchtype,
                min_price, max_price, false);

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
    public ModelAndView detail(Integer item_no) {
        ModelAndView mav = new ModelAndView();

        if (item_no == null || item_no == 0) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop");

            return mav;
        }

        Item item = service.getItemById(item_no, true);
        item.setDescription(item.getDescription().replaceAll(System.getProperty("line.separator"), "<br>"));
        item.setContent(item.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

        mav.addObject("item", item);

        int review_count = service.getReplyCount("0", item_no);
        mav.addObject("review_count", review_count);

        String categoryGroupName = service.getCategoryGroupName(item.getCategory_group_code());
        String categoryItemName = service.getCategoryItemName(item.getCategory_group_code(), item.getCategory_item_code());

        mav.addObject("categoryGroupName", categoryGroupName);
        mav.addObject("categoryItemName", categoryItemName);

        List<Item> categoryItemList = service.getItemList(item.getCategory_group_code(), item.getCategory_item_code(),
                null, null, null, null, null, null, false);
        List<Item> randomitemList = new ArrayList<>();

        if (categoryItemList != null) {
            int list_max_size = categoryItemList.size();
            int limit = 12;

            System.out.print("basket/*: randomitemList-item_no: [ ");
            for (int i = 1; i <= list_max_size; i++) {
                int random_item_index = (int) (Math.random() * list_max_size);
                int random_item_no = categoryItemList.get(random_item_index).getItem_no();
                Item randomItem = service.getItemById(random_item_no, false);

                if (randomItem == null) {
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

                    randomitemList.add(randomItem);
                    System.out.print(random_item_no + " ");
                }

                if (i + 1 > limit) {
                    break;
                }
            }
            System.out.println("]");
            mav.addObject("randomitemList", randomitemList);
        }

        return mav;
    }
}
