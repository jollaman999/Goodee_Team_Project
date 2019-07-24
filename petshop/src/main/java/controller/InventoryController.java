package controller;


import logic.CategoryGroup;
import logic.CategoryItem;
import logic.Item;
import logic.Orders;
import logic.Orders_list;
import logic.ShopService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.ShopException;

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
        List<Item> itemList  = service.getItemList(true);
        List<CategoryGroup> CategoryGroupList  = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList  = service.getCategoryItemList();
    
        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList",CategoryGroupList);
        mav.addObject("CategoryItemList",CategoryItemList);
        
        return mav;
    }
    

    //detail 페이지 넘기기  
    @RequestMapping("*")
    public ModelAndView detail(Integer item_no, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        //받아올 테이블
        List<Item> itemList  = service.getItemList(true);
        List<CategoryGroup> CategoryGroupList  = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList  = service.getCategoryItemList();
        
        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList",CategoryGroupList);
        mav.addObject("CategoryItemList",CategoryItemList);

        // item_no 기준으로 이것저것 가져오기.
        Item item = service.getItemById(item_no, true);
        mav.addObject("item", item);
        return mav;
    }
    
    // list -> submit
    @PostMapping("listsubmit")
    public ModelAndView itemUpdate(Integer item_no,Integer itemUpdate,HttpSession session) {
        Item item = service.getItemById(item_no, true);
        
    	//현 수량에 추가한 수량을 더해줌
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
        List<Item> itemList  = service.getItemList(true);
        List<CategoryGroup> CategoryGroupList  = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList  = service.getCategoryItemList();
        List<Orders> OrdersList = service.getOrdersList(null, null);

        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList",CategoryGroupList);
        mav.addObject("CategoryItemList",CategoryItemList);
        mav.addObject("Orderslist",OrdersList);
        
        return mav;
    }
    
    
    @RequestMapping("money")
    public ModelAndView money(HttpSession session) {
        ModelAndView mav = new ModelAndView();
      
        //받아올 테이블
        List<Item> itemList  = service.getItemList(true);
        List<CategoryGroup> CategoryGroupList  = service.getCategoryGroupList();
        List<CategoryItem> CategoryItemList  = service.getCategoryItemList();
        List<Orders> OrdersList = service.getOrdersList(null, null);
        
        // orders money 멤버에서 호출
        List<Orders> moneyListDay = service.ordersmonyList_by_day();
        

        // 리스트 객체 생성 
        mav.addObject("itemList", itemList);
        mav.addObject("CategoryGroupList",CategoryGroupList);
        mav.addObject("CategoryItemList",CategoryItemList);
        mav.addObject("Orderslist",OrdersList);
        mav.addObject("moneyListDay",moneyListDay);
        
        return mav;
    }
    
	@RequestMapping("money2")
	public ModelAndView money2(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 받아올 테이블
		List<Item> itemList = service.getItemList(true);
		List<CategoryGroup> CategoryGroupList = service.getCategoryGroupList();
		List<CategoryItem> CategoryItemList = service.getCategoryItemList();
		List<Orders> OrdersList = service.getOrdersList(null, null);

		// orders money 멤버에서 호출
		List<Orders> moneyListMonth = service.ordersmoneyList_by_month();

		// 리스트 객체 생성
		mav.addObject("itemList", itemList);
		mav.addObject("CategoryGroupList", CategoryGroupList);
		mav.addObject("CategoryItemList", CategoryItemList);
		mav.addObject("Orderslist", OrdersList);
		mav.addObject("moneyListMonth", moneyListMonth);

		return mav;
	}

	@RequestMapping("money3")
	public ModelAndView money3(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 받아올 테이블
		List<Item> itemList = service.getItemList(true);
		List<CategoryGroup> CategoryGroupList = service.getCategoryGroupList();
		List<CategoryItem> CategoryItemList = service.getCategoryItemList();
		List<Orders> OrdersList = service.getOrdersList(null, null);

		// orders money 멤버에서 호출

		List<Orders> moneyListYear = service.ordersmoneyList_by_year();

		// 리스트 객체 생성
		mav.addObject("itemList", itemList);
		mav.addObject("CategoryGroupList", CategoryGroupList);
		mav.addObject("CategoryItemList", CategoryItemList);
		mav.addObject("Orderslist", OrdersList);
		mav.addObject("moneyListYear", moneyListYear);

		return mav;
	}

	@RequestMapping("money4")
	public ModelAndView money4(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 받아올 테이블
		List<Item> itemList = service.getItemList(true);
		List<CategoryGroup> CategoryGroupList = service.getCategoryGroupList();
		List<CategoryItem> CategoryItemList = service.getCategoryItemList();
		List<Orders> OrdersList = service.getOrdersList(null, null);

		// orders money 멤버에서 호출

		List<Orders> moneyList = service.ordersmonyList_by_day();
		List<Orders> moneyList2 = service.ordersmoneyList_by_month();
		List<Orders> moneyList3 = service.ordersmoneyList_by_year();

		// 리스트 객체 생성
		mav.addObject("itemList", itemList);
		mav.addObject("CategoryGroupList", CategoryGroupList);
		mav.addObject("CategoryItemList", CategoryItemList);
		mav.addObject("Orderslist", OrdersList);
		mav.addObject("moneyList", moneyList);
		mav.addObject("moneyList2", moneyList2);
		mav.addObject("moneyList3", moneyList3);

		return mav;
	}
}
