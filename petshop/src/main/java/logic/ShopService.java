package logic;

import dao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShopService {
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

    public List<Item> getItemList() {
        return itemDao.list();
    }

    public Item getItemById(Integer id) {
        return itemDao.selectOne(id);
    }

    public void itemCreate(Item item, HttpServletRequest request) {
        if (item.getPicture() != null && !item.getPicture().isEmpty()) {
            uploadFileCreate(item.getPicture(), request, "item/img/");
            item.setPictureUrl(item.getPicture().getOriginalFilename());
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

    public void itemUpdate(Item item, HttpServletRequest request) {
        if (item.getPicture() != null && !item.getPicture().isEmpty()) {
            uploadFileCreate(item.getPicture(), request, "item/img/");
            item.setPictureUrl(item.getPicture().getOriginalFilename());
        }

        itemDao.update(item);
    }

    public void itemDelete(Integer id) {
        itemDao.delete(id);
    }

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

    public int boardcount(String searchtype, String searchcontent) {
        return boardDao.count(searchtype, searchcontent);
    }

    public int boardmaxnum() {
        return boardDao.maxnum();
    }

    public List<Board> boardlist(int pageNum, int limit, String searchtype, String searchcontent) {
        return boardDao.list(pageNum, limit, searchtype, searchcontent);
    }

    public Board getBoard(int num, HttpServletRequest request) {
        if (request.getRequestURI().contains("detail")) {
            boardDao.readcntadd(num);
        }
        return boardDao.selectOne(num);
    }

    public int boardInsert(Board board) {
        return boardDao.insert(board);
    }

    public void updateRefStep(Board board) {
        boardDao.updateRefStep(board.getRef(), board.getRefstep());
    }

    public int boardUpdate(Board board) {
        return boardDao.update(board);
    }

    public int boardDelete(Integer num) {
        return boardDao.delete(num);
    }

    public Map<String, Object> graph() {
        Map<String,Object> map = new HashMap<>();
        for(Map<String,Object> m : boardDao.graph()) {
            map.put((String)m.get("key1"), m.get("value1"));
        }
        return map;
    }
}
