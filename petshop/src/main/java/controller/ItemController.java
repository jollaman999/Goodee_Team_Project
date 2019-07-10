package controller;

import logic.Item;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("item")
public class ItemController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list() {
        List<Item> itemList  = service.getItemList();
        // /WEB-INF/view/item/list.jsp 뷰로 지정
        ModelAndView mav = new ModelAndView();
        mav.addObject("itemList", itemList);
        return mav;
    }

    @RequestMapping("*")
    public ModelAndView detail(Integer id) {
        ModelAndView mav = new ModelAndView();
        Item item = service.getItemById(id);
        mav.addObject("item", item);
        return mav;
    }

    @RequestMapping("create")
    public ModelAndView create() {
        ModelAndView mav = new ModelAndView("item/add");
        mav.addObject(new Item());
        return mav;
    }

    @RequestMapping("register")
    public ModelAndView register(@Valid Item item, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("item/add");
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        service.itemCreate(item, request);
        mav.setViewName("redirect:/item/list.shop");

        return mav;
    }

    @RequestMapping("update")
    public ModelAndView update(@Valid Item item, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("item/edit");
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
        }

        service.itemUpdate(item, request);
        mav.setViewName("redirect:/item/list.shop");

        return mav;
    }

    @RequestMapping("delete")
    public String delete(Integer id) {
        service.itemDelete(id);
        return "redirect:/item/list.shop";
    }
}
