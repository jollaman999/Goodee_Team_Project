package controller;

import logic.CategoryGroup;
import logic.CategoryItem;
import logic.Item;
import logic.ShopService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
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
        List<Item> itemList  = service.getItemList(null, null,
                null, null, null, null, null, null,
                false);
        // /WEB-INF/view/item/list.jsp 뷰로 지정
        ModelAndView mav = new ModelAndView();
        mav.addObject("itemList", itemList);
        return mav;
    }

    @RequestMapping("*")
    public ModelAndView detail(Integer item_no, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (item_no == null || item_no.toString().length() == 0) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        Item item = service.getItemById(item_no, false);
        mav.addObject("item", item);
        return mav;
    }

    @RequestMapping("create")
    public ModelAndView create(HttpSession session) {
        ModelAndView mav = new ModelAndView("item/add");

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList", JSONArray.fromObject(categoryGroupList));
        mav.addObject("categoryItemList", JSONArray.fromObject(categoryItemList));

        mav.addObject(new Item());

        return mav;
    }

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("item/edit");

        if (request.getParameter("item_no") == null) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        int item_no = Integer.parseInt(request.getParameter("item_no"));
        Item item = service.getItemById(item_no, false);
        if (item == null) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        mav.addObject("item", item);

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList", JSONArray.fromObject(categoryGroupList));
        mav.addObject("categoryItemList", JSONArray.fromObject(categoryItemList));

        return mav;
    }

    @PostMapping("register")
    public ModelAndView register(@Valid Item item, BindingResult bindingResult, MultipartHttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("item/add");

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList", JSONArray.fromObject(categoryGroupList));
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
            mav.addObject("url","../inventory/detail.shop?item_no=" + item_no);
        } else {
            mav.addObject("msg","상품 등록을 실패하였습니다!");
            mav.addObject("url","create.shop");
        }

        return mav;
    }

    @PostMapping("update")
    public ModelAndView update(@Valid Item item, BindingResult bindingResult, MultipartHttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("item/edit");

        List<CategoryGroup> categoryGroupList = service.getCategoryGroupList();
        List<CategoryItem> categoryItemList = service.getCategoryItemList();

        mav.addObject("categoryGroupList", JSONArray.fromObject(categoryGroupList));
        mav.addObject("categoryItemList", JSONArray.fromObject(categoryItemList));

        System.out.println(bindingResult);
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        mav = new ModelAndView("/alert");

        if (request.getParameter("item_no") == null) {
            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        Item dbItem = service.getItemById(Integer.parseInt(request.getParameter("item_no")), false);
        if (dbItem == null) {
            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        int item_no = Integer.parseInt(request.getParameter("item_no"));

        if (item.getMainpic() != null) {
            if (!fileUtil.DeleteAllFiles(item_no, new Item(), mav, request)) {
                return mav;
            }

            if (!fileUtil.FileUpload(item_no, service, item, mav, request, "update.shop?num=" + item_no)) {
                return mav;
            }
        } else {
            item.setMainpicurl(dbItem.getMainpicurl());
        }

        int result = service.itemUpdate(item);

        if (result > 0) {
            mav.addObject("msg","상품 수정이 완료되었습니다.");
            mav.addObject("url","../inventory/detail.shop?item_no=" + item_no);
        } else {
            mav.addObject("msg","상품 수정을 실패하였습니다!");
            mav.addObject("url","../inventory/list.shop");
        }

        return mav;
    }

    @PostMapping("delete")
    public ModelAndView delete(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("item_no") == null) {
            mav.addObject("msg","상품 정보를 가져올 수 없습니다!");
            mav.addObject("url","../inventory/list.shop");

            return mav;
        }

        int item_no = Integer.parseInt(request.getParameter("item_no"));

        if (!fileUtil.DeleteAllFiles(item_no, new Item(), mav, request)) {
            return mav;
        }

        try {
            int result = service.itemDelete(item_no);
            if (result > 0) {
                mav.addObject("msg","상품 삭제가 완료되었습니다.");
                mav.addObject("url","../inventory/list.shop");
            } else {
                mav.addObject("msg","상품 삭제를 실패하였습니다!");
                mav.addObject("url","../inventory/detail.shop?num=" + item_no);
            }
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            String message = e.getMessage();
            if (message != null && message.contains("foreign key constraint fails")) {
                if (message.contains("orders_list")) {
                    mav.addObject("msg", "주문 목록에 해당 상품이 존재합니다.\\n주문 목록을 확인 하신 후 삭제를 진행해 주세요!");
                } else if (message.contains("board")) {
                    mav.addObject("msg", "게시판에 해당 상품으로 등록된 게시글이 존재합니다.\\n게시판 목록을 확인 하신 후 삭제를 진행해 주세요!");
                }

                mav.addObject("url", "../inventory/detail.shop?item_no=" + item_no);

                return mav;
            }
        }

        return mav;
    }
}
