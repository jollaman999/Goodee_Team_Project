package controller;

import logic.CategoryGroup;
import logic.CategoryItem;
import logic.Item;
import logic.ShopService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import util.FileUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("item")
public class ItemController {
    @Autowired
    private ShopService service;

    private FileUtil fileUtil = new FileUtil();

    @RequestMapping("list")
    public ModelAndView list(HttpSession session) {
        List<Item> itemList  = service.getItemList(false);
        // /WEB-INF/view/item/list.jsp 뷰로 지정
        ModelAndView mav = new ModelAndView();
        mav.addObject("itemList", itemList);
        return mav;
    }

    @RequestMapping("*")
    public ModelAndView detail(Integer item_no, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        Item item = service.getItemById(item_no, false);
        mav.addObject("item", item);
        return mav;
    }

    @RequestMapping("create")
    public ModelAndView create(HttpSession session) {
        ModelAndView mav = new ModelAndView("item/add");
        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList",JSONArray.fromObject(categoryGroupList));
        mav.addObject("categoryItemList", JSONArray.fromObject(categoryItemList));
        mav.addObject(new Item());
        return mav;
    }

    @PostMapping("register")
    public ModelAndView register(@Valid Item item, BindingResult bindingResult, HttpSession session, MultipartHttpServletRequest request) {
        ModelAndView mav = new ModelAndView("item/add");

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList",JSONArray.fromObject(categoryGroupList));
        mav.addObject("categoryItemList", JSONArray.fromObject(categoryItemList));

        System.out.println(bindingResult);
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        if (item != null && service.getItemByName(item.getName(), false) != null) {
            bindingResult.reject("error.item.duplicated");
            return mav;
        }

        mav = new ModelAndView("/alert");

        int item_no = service.item_max_item_no() + 1;

        if (!fileUtil.FileUpload(item_no, service, item, mav, request, "create.shop")) {
            return mav;
        }

        int result = service.itemAdd(item);

        if (result > 0) {
            mav.addObject("msg","상품 등록이 완료되었습니다.");
            mav.addObject("url","detail.shop?item_no=" + item_no);
        } else {
            mav.addObject("msg","상품 등록을 실패하였습니다!.");
            mav.addObject("url","create.shop");
        }

        return mav;
    }

    @PostMapping("update")
    public ModelAndView update(HttpSession session, @Valid Item item, MultipartHttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("item_no") == null) {
            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop");

            return mav;
        }

        int item_no = Integer.parseInt(request.getParameter("item_no"));

        if (!fileUtil.FileUpload(item_no, service, item, mav, request, "update.shop?num=" + item_no)) {
            return mav;
        }

        int result = service.itemUpdate(item);

        if (result > 0) {
            mav.addObject("msg","상품 수정이 완료되었습니다.");
            mav.addObject("url","detail.shop?item_no=" + item_no);
        } else {
            mav.addObject("msg","상품 수정을 실패하였습니다!.");
            mav.addObject("url","list.shop");
        }

        return mav;
    }

    @PostMapping("delete")
    public ModelAndView delete(HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("item_no") == null) {
            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop");

            return mav;
        }

        int item_no = Integer.parseInt(request.getParameter("item_no"));

        if (!fileUtil.DeleteAllFiles(item_no, new Item(), mav, request)) {
            return mav;
        }

        int result = service.itemDelete(item_no);

        if (result > 0) {
            mav.addObject("msg","상품 삭제가 완료되었습니다.");
            mav.addObject("url","list.shop");
        } else {
            mav.addObject("msg","상품 삭제를 실패하였습니다!.");
            mav.addObject("url","detail.shop?num=" + item_no);
        }

        return mav;
    }
}
