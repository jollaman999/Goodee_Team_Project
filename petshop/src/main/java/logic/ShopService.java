package logic;

import dao.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.PrintWriter;
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
    @Autowired
    private CategoryGroupDao categoryGroupDao;
    @Autowired
    private CategoryItemDao categoryItemDao;

    // list
    public List<CategoryItem> getCategoryItemList() {
        return categoryItemDao.list();
    }

    public List<CategoryGroup> getCategoryGroupList() {
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

    // member
    public void memberCreate(Member member) {
        memberDao.insert(member);
    }


    public Member memberSelect(String id) {
        return memberDao.selectOne(id);
    }

    public void memberUpdate(Member member) {
        memberDao.update(member);
    }

    public void memberDelete(Member member) {
        memberDao.delete(member);
    }

    public String find_id_by_email(HttpServletResponse response, String email) throws Exception {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        List<Member> memberList = memberDao.list();
        for (Member member : memberList) {
            if (member.getEmail().equals(email)) {
                return member.getId();
            }
        }

        out.println("<script type=\"text/javascript\">");
        out.println("alert('가입된 아이디가 없습니다.');");
        out.println("history.go(-1);");
        out.println("</script>");
        out.close();

        return null;
    }

    // board
    public int boardcount(String searchtype, String searchcontent) {
        return boardDao.count(searchtype, searchcontent);
    }

    public int boardmaxnum() {
        return boardDao.maxnum();
    }

    public Board getBoard(int num) {
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

    // Sale
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
