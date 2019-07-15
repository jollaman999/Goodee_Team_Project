package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.mapper.CategoryItemMapper;
import logic.ShopService;

@Controller
@RequestMapping("categoryitem")
public class CategoryItemController {
	
	    @Autowired
	    private ShopService service;

	    @RequestMapping("list")
	    public ModelAndView list() {
	    	List<CategoryItemMapper> categoryItemList  = service.CategoryItemList();
	        // /WEB-INF/view/item/list.jsp 뷰로 지정
	        ModelAndView mav = new ModelAndView();
	        mav.addObject("categoryItemList", categoryItemList);
	        return mav;
	    }
}