package logic;

import dao.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import util.CipherUtil;
import util.SecurityUtil;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@Service
public class ShopService {
    // 자동연결할 dao들
    @Autowired
    private ItemDao itemDao;
    @Autowired
    private BasketDao basketDao;
    @Autowired
    private DepositDao depositDao;
    @Autowired
    private MemberDao memberDao;
    @Autowired
    private BoardDao boardDao;
    @Autowired
    private CategoryGroupDao categoryGroupDao;
    @Autowired
    private CategoryItemDao categoryItemDao;
    @Autowired
    private AdminMailDao adminMailDao;
    @Autowired
    private OrdersDao ordersDao;
    @Autowired
    private Orders_listDao orders_listDao;
    @Autowired
    private RecommendDao recommendDao;
    @Autowired
    private ReplyDao replyDao;

    // list
    public List<CategoryItem> getCategoryItemList() {
        return categoryItemDao.list();
    }

    public List<CategoryGroup> getCategoryGroupList() {
        return categoryGroupDao.list();
    }

    public List<Item> getItemList(Integer category_group, Integer category_item,
                                  Integer pageNum, Integer limit, String searchtype, String searchcontent,
                                  Integer min_price, Integer max_price, boolean get_quantity_details) {
        return itemDao.list(category_group, category_item, pageNum, limit, searchtype, searchcontent,
                min_price, max_price, get_quantity_details);
    }

    public List<Orders_list> getOrders_listList(int order_num) {
        return orders_listDao.list(order_num);
    }

    public List<Orders> getOrdersList(String member_id, Integer day) {
        return ordersDao.list(member_id, day);
    }

	public List<Orders> month_profit() {
		return ordersDao.month_profit();
	}

	public List<Orders> year_profit() {
		return ordersDao.year_profit();
	}

	public List<Orders> day_profit() {
		return ordersDao.day_profit();
	}

    public List<Orders> ordersmonyList_by_day() {
        return ordersDao.moneyList_by_day();
    }

    public List<Orders> ordersmoneyList_by_month() {
        return ordersDao.moneyList_by_month();
    }

    public List<Orders> ordersmoneyList_by_year() {
        return ordersDao.moneyList_by_year();
    }

    public List<Member> memberList(Integer pageNum, Integer limit, String searchtype, String searchcontent) {
        return memberDao.list(pageNum, limit, searchtype, searchcontent);
    }

    public List<Member> memberList(String[] idchks) {
        return memberDao.list(idchks);
    }

	public List<Board> boardlist(int type, int pageNum, int limit, String searchtype, String searchcontent, String id) {
		return boardDao.list(type, pageNum, limit, searchtype, searchcontent, id);
	}

    public List<Basket> basketList(String member_id) {
        return basketDao.list(member_id);
    }

    public List<Deposit> depositList() {
        return depositDao.list();
    }

    public List<Reply> replyList(String type, int itemno, int pageNum, int limit) {
        return replyDao.list(type, itemno, pageNum, limit);
    }


    // category
    public String getCategoryGroupName(Integer group_code) {
        CategoryGroup categoryGroup = categoryGroupDao.selectOne(group_code);
        if (categoryGroup != null) {
            return categoryGroup.getGroup_name();
        }

        return null;
    }

    public String getCategoryItemName(Integer group_code, Integer code) {
        CategoryItem categoryItem = categoryItemDao.selectOne(group_code, code);
        if (categoryItem != null) {
            return categoryItem.getName();
        }

        return null;
    }

    // item
    public int itemcount(Integer category_group, Integer category_item, String searchtype, String searchcontent, Integer min_price, Integer max_price) {
        return itemDao.count(category_group, category_item, searchtype, searchcontent, min_price, max_price);
    }

    public int item_max_item_no() {
        return itemDao.max_item_no();
    }

    public int item_min_price(Integer category_group, Integer category_item) {
        return itemDao.min_price(category_group, category_item);
    }

    public int item_max_price(Integer category_group, Integer category_item) {
        return itemDao.max_price(category_group, category_item);
    }

    public int itemAdd(Item item) {
        return itemDao.insert(item);
    }

    public int itemUpdate(Item item) {
        return itemDao.update(item);
    }

    public int itemDelete(Integer item_no) {
        return itemDao.delete(item_no);
    }

    public Item getItemById(Integer item_no, boolean get_quantity_details) {
        return itemDao.selectOne(item_no, get_quantity_details);
    }

    public Item getItemByName(String name, boolean get_quantity_details) {
        return itemDao.selectOne(name, get_quantity_details);
    }

    // basket
    public int basketAdd(Basket basket) {
        return basketDao.insert(basket);
    }

    public int basketUpdate(Basket basket) {
        return basketDao.update(basket);
    }

    public int basketDelete(String member_id, Integer item_no) {
        return basketDao.delete(member_id, item_no);
    }

    // orders
    public Orders ordersSelect(Integer num) {
        return ordersDao.selectOne(num);
    }

    public int ordersAdd(String member_id, Orders order, List<Basket> orderList, boolean need_basket_delete) {
        int num = ordersDao.max_num();
        order.setMember_id(member_id);
        order.setNum(++num);

        int result;

        result = ordersDao.insert(order);
        if (result <= 0) {
            System.out.println("ordersAdd/ordersDao.insert error!");
            return result;
        }

        int list_num = 0;
        for (Basket item : orderList) {
            Orders_list orders_list = new Orders_list(order.getNum(), ++list_num, item.getItem_no(), item.getQuantity());
            result = orders_listDao.insert(orders_list);
            if (result <= 0) {
                System.out.println("ordersAdd/orders_listDao.insert error!");
                return result;
            }

            if (need_basket_delete) {
                result = basketDao.delete(member_id, item.getItem_no());
                if (result <= 0) {
                    System.out.println("ordersAdd/basketDao.delete error!");
                    return result;
                }
            }
        }

        return result;
    }

    public int ordersUpdate(Orders orders) {
        return ordersDao.update(orders);
    }

    public int ordersDelete(Integer num) {
        return ordersDao.delete(num);
    }

    // deposit
    public Deposit depositSelect(int num) {
        return depositDao.selectOne(num);
    }

    // member
    public int memberCount(String searchtype, String searchcontent) {
        return memberDao.count(searchtype, searchcontent);
    }

    public void memberCreate(Member member) {
        memberDao.insert(member);
    }

    public Member memberSelect(String id) {
        return memberDao.selectOne(id);
    }

    public void memberUpdate(Member member) {
        memberDao.update(member);
    }

    public int memberUpdatePass(Member member) {
        return memberDao.update_pass(member);
    }

    public void memberDelete(Member member) {
        memberDao.delete(member);
    }

    public String find_id_by_email(HttpServletResponse response, String email) throws Exception {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        List<Member> memberList = memberDao.list(null, null, null, null);
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

    private AdminMail getAdminMail() {
        AdminMail adminMail = adminMailDao.selectOne(1);
        System.out.println(adminMail.getKey().substring(0, 16));
        String encrypted_pass = adminMail.getPw();
        String decrypted_pass = CipherUtil.decrypt(encrypted_pass, adminMail.getKey().substring(0, 16));
        String encrypted_email = adminMail.getEmail();
        String decrypted_email = CipherUtil.decrypt(encrypted_email, adminMail.getKey().substring(0, 16));

        adminMail.setPw(decrypted_pass);
        adminMail.setEmail(decrypted_email);

        return adminMail;
    }

    public static final class AdminMailAuthenticator extends Authenticator {
        private String id;
        private String pw;

        AdminMailAuthenticator(String id, String pw) {
            this.id = id;
            this.pw = pw;
        }

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(id, pw);
        }
    }

    private BodyPart bodyPart(MultipartFile mf) {
        MimeBodyPart body = new MimeBodyPart();
        String orgFile = mf.getOriginalFilename();
        File f1 = new File("G:/spring/mailupload/" + orgFile);

        if (orgFile == null) {
            return body;
        }

        try {
            mf.transferTo(f1);
            body.attachFile(f1);
            body.setFileName(new String(orgFile.getBytes("EUC-KR"), "8859_1"));
        } catch (MessagingException | IOException e) {
            e.printStackTrace();
        }

        return body;
    }

    private void mailSend(Member member) throws Exception {
        AdminMail adminMail = getAdminMail();
        AdminMailAuthenticator auth = new AdminMailAuthenticator(adminMail.getEmail(), adminMail.getPw());
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.daum.net");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.debug", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.user", adminMail.getId());
        prop.put("mail.smtp.socketFactory.port", 465);
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("javax.net.ssl.SSLSocketFactory.fallback", "false");

        Session session = Session.getInstance(prop, auth);
        MimeMessage mimeMsg = new MimeMessage(session);
        try {
            mimeMsg.setFrom(new InternetAddress(adminMail.getId() + "@daum.net"));



            InternetAddress internetAddress = new InternetAddress(new String(member.getEmail().getBytes("EUC-KR"), "8859_1"));
            mimeMsg.setSentDate(new Date());
            mimeMsg.setRecipients(Message.RecipientType.TO, internetAddress.toString());
            mimeMsg.setSubject("[핫 도그몰] 임시 비밀번호 안내");

            MimeMultipart multipart = new MimeMultipart();
            MimeBodyPart message = new MimeBodyPart();

            String content = "<div align='center' style='border:1px solid black; font-family:verdana'>" +
                    "<h3 style='color: blue;'>" + member.getId() + "님의 임시 비밀번호 입니다.<br>보안을 위해 반드시 비밀번호를 변경하여 사용해 주시기 바랍니다.</h3>" +
                    "<p>임시 비밀번호 : " + member.getPass() + "</p></div>";
            message.setContent(content, "text/html;charset=euc-kr;");
            multipart.addBodyPart(message);
            mimeMsg.setContent(multipart);
            Transport.send(mimeMsg);
        } catch (MessagingException me) {
            me.printStackTrace();
        }
    }

    public void find_pw(PrintWriter out, Member member) throws Exception {
        StringBuilder pw = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            pw.append((char)((Math.random() * 94) + 33));
        }

        Member dbMember = memberDao.selectOne(member.getId());
        if (dbMember == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('존재하지 않는 아이디 입니다.');");
            out.println("history.go(-1);");
            out.println("</script>");
            out.flush();
            out.close();

            return;
        }

        if (!dbMember.getEmail().equals(member.getEmail())) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('해당 정보로 등록된 회원이 존재하지 않습니다.');");
            out.println("history.go(-1);");
            out.println("</script>");
            out.flush();
            out.close();

            return;
        }

        String decryted_email = dbMember.getEmail();
        String encryted_temp_pass = new SecurityUtil().encryptSHA256(pw.toString());
        member.setPass(encryted_temp_pass);
        member.setEmail(decryted_email);
        memberDao.update_pass(member);

        member.setPass(pw.toString());
        member.setEmail(decryted_email);
        mailSend(member);

        out.println("<script type=\"text/javascript\">");
        out.println("alert('이메일로 임시 비밀번호를 발송하였습니다.');");
        out.println("location.href='login.shop';");
        out.println("</script>");
        out.flush();
        out.close();
    }

    // board
	public int boardcount(int type, String searchtype, String searchcontent, String id) {
		return boardDao.count(type, searchtype, searchcontent, id);
	}

    public int boardmaxnum() {
        return boardDao.maxnum();
    }

    public Board getBoard(int num, int type) {
        return boardDao.selectOne(num, type);
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

    // recommend
    public int recomGetCount(String type, Integer itemno) {
        return recommendDao.getCount(type, itemno);
    }

    public int recomCheck(Recommend recommend) {
        return recommendDao.recomCheck(recommend);
    }

    public int recomAdd(Recommend recommend) {
        return recommendDao.recomAdd(recommend);
    }

    public int recomDelete(Recommend recommend) {
        return recommendDao.recomDelete(recommend);
    }

    // reply
    public int getReplyMaxNum() {
        return replyDao.getMaxNum();
    }

    public Reply replySelect(int num) {
        return replyDao.selectOne(num);
    }

    public int getReplyCount(String type, int itemno) {
        return replyDao.getReplyCount(type, itemno);
    }

    public int replyInsert(Reply reply) {
        return replyDao.insert(reply);
    }

    public int replyUpdate(int num, String content) {
        return replyDao.update(num, content);
    }

    public int replyDelete(int num) {
        return replyDao.delete(num);
    }
}
