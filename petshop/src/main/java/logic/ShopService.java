package logic;

import dao.*;
import dao.mapper.CategoryItemMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;


@Service
public class ShopService {
	
	// 자동연결할 dao들 
    @Autowired
    private ItemDao itemDao;
    @Autowired
    private MemberDao memberDao;
    @Autowired
    private SaleDao saleDao;
    @Autowired
    private SaleItemDao saleItemDao;
    @Autowired
    private BoardDao boardDao;
    // 이한솔 추가
    @Autowired
    private CategoryGroupDao categoryGroupDao;
    @Autowired
    private CategoryItemDao categoryItemDao;

    //list 
    
    //카테고리 리스트 추가한것.
    public List<CategoryItemMapper> CategoryItemList() {
    	return categoryItemDao.list();
	}

	public List<CategoryGroup> CategoryGroupList() {
		return categoryGroupDao.list();
	}
    
    public List<Item> getItemList() {
        return itemDao.list();
    }

    public List<Sale> salelist(String id) {
        return saleDao.list(id);
    }

    public List<SaleItem> saleItemList(int saleId) {
        return saleItemDao.list(saleId);
    }

    public List<Member> memberList() {
        return memberDao.list();
    }

    public List<Member> memberList(String[] idchks) {
        return memberDao.list(idchks);
    }

    public List<Board> boardlist(int pageNum, int limit, String searchtype, String searchcontent) {
        return boardDao.list(pageNum, limit, searchtype, searchcontent);
    }
    
 


    
    
    
    
    // item
    public void itemUpdate(Item item, HttpServletRequest request) {
        if (item.getMainpicMultipartFile() != null && !item.getMainpicMultipartFile().isEmpty()) {
            uploadFileCreate(item.getMainpicMultipartFile(), request, "item/img/");
            item.setMainpic(item.getMainpicMultipartFile().getOriginalFilename());
        }

        itemDao.update(item);
    }

    public void itemDelete(int item_no) {
        itemDao.delete(item_no);
    }
    
    public Item getItemById(int item_no) {
        return itemDao.selectOne(item_no);
    }
    
    
    public void itemCreate(Item item, HttpServletRequest request) {
        if (item.getMainpicMultipartFile() != null && !item.getMainpicMultipartFile().isEmpty()) {
            uploadFileCreate(item.getMainpicMultipartFile(), request, "item/img/");
            item.setMainpic(item.getMainpicMultipartFile().getOriginalFilename());
        }
        itemDao.insert(item);
    }
    private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
        String orgFile = picture.getOriginalFilename();
        String uploadPath = request.getServletContext().getRealPath("/") + path;

        try {
            picture.transferTo(new File(uploadPath + orgFile));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
    
    
    
    
    //member
    public void memberCreate(Member member) {
        memberDao.insert(member);
    }
    
    
    public Member memberSelect (String id) {
        return memberDao.selectOne(id);
    }

    public void memberUpdate(Member member) {
        memberDao.update(member);
    }

    public void memberDelete(Member member) {
        memberDao.delete(member);
    }
    
    
    

   
    // board
    public int boardcount(String searchtype, String searchcontent) {
        return boardDao.count(searchtype, searchcontent);
    }

    public int boardmaxnum() {
        return boardDao.maxnum();
    }

    public Board getBoard(int num, HttpServletRequest request) {
        return boardDao.selectOne(num);
    }

    public int boardInsert(Board board) {
        return boardDao.insert(board);
    }

    public int boardUpdate(Board board) {
        return boardDao.update(board);
    }

    public int boardDelete(Integer num) {
        return boardDao.delete(num);
    }
    
    
    
    
    
    //Sale
    public Sale checkEnd(Member loginMember, Cart cart) {
        Sale sale = new Sale();
        sale.setSaleId(saleDao.getMaxSaleId());
        sale.setMember(loginMember);
        sale.setUpdatetime(new Date());
        List<ItemSet> itemList = cart.getItemSetList();

        int i = 0;
        for (ItemSet is : itemList) {
            int saleItemId = ++i;
            SaleItem saleItem = new SaleItem(sale.getSaleId(), saleItemId, is);
            sale.getItemList().add(saleItem);
        }
        saleDao.insert(sale);
        List<SaleItem> saleItemList = sale.getItemList();

        for (SaleItem si : saleItemList) {
            saleItemDao.insert(si);
        }

        return sale;
    }

	
}
