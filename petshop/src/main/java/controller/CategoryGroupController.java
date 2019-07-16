package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import logic.CategoryGroup;
import logic.ShopService;

@Controller
@RequestMapping("categorygroup")
public class CategoryGroupController {
	
	    @Autowired
	    private ShopService service;

	    @RequestMapping("list")
	    public ModelAndView list() {
	    	List<CategoryGroup> categorygroupList  = service.CategoryGroupList();
	        // /WEB-INF/view/item/list.jsp 뷰로 지정
	        ModelAndView mav = new ModelAndView();
	        mav.addObject("categorygroupList",categorygroupList);
	        return mav;
	    }
}