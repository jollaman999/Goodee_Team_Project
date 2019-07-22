package controller;

import logic.Member;
import logic.Recommend;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("recommend")
public class RecommendController {
    @Autowired
    private ShopService shopService;

    @RequestMapping("count")
    public void add(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        PrintWriter out = response.getWriter();

        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");

        System.out.println("==== Recommend Count ====");
        System.out.println("type : " + type);
        System.out.println("itemno : " + itemno);

        if (type == null || itemno == null) {
            out.println("<script type=\"text/javascript\">alert(\"좋아 정보를 가져올 수 없습니다!\");</script>");
            out.close();
            return;
        }

        switch (type) {
            case "0": // 상품
                if (shopService.getItemById(Integer.parseInt(itemno)) == null) {
                    out.println("<script type=\"text/javascript\">alert(\"존재 하지 않는 상품 입니다!\");</script>");
                    return;
                }
                break;
//            case "1": // 후기
//                if (shopService.getReply... == null) {
//                    out.println("<script type=\"text/javascript\">alert(\"존재 하지 않는 후기 입니다!\");</script>");
//                    out.close();
//                    return;
//                }
//                break;
            default:
                out.println("<script type=\"text/javascript\">alert(\"올바르지 않은 접근 입니다!\");</script>");
                out.close();
                return;
        }

        int count = shopService.recomGetCount(type, Integer.parseInt(itemno));

        if (count == -1) {
            out.println("<script type=\"text/javascript\">alert(\"좋아요 정보를 가져올 수 없습니다!\");</script>");
            out.close();
            return;
        }

        out.println(count);
        out.close();

        return;
    }

    @RequestMapping("update")
    public void update(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        PrintWriter out = response.getWriter();

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            out.println("<script type=\"text/javascript\">alert(\"추천을 하시려면 로그인이 필요합니다!\");</script>");
            out.close();
            return;
        }

        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");
        String member_id = loginMember.getId();

        System.out.println("==== Recommend Update ====");
        System.out.println("type : " + type);
        System.out.println("itemno : " + itemno);
        System.out.println("member_id : " + member_id);

        request.setAttribute("url", "");

        if (type == null || itemno == null || member_id == null ||
                type.length() == 0 || itemno.length() == 0 || member_id.length() == 0) {
            out.println("<script type=\"text/javascript\">alert(\"추천 작업을 수행할 수 없습니다!\");</script>");
            out.close();
            return;
        }

        if (shopService.memberSelect(member_id) == null) {
            out.println("<script type=\"text/javascript\">alert(\"회원 정보를 가져올 수 없습니다!\");</script>");
            out.close();
            return;
        }

        switch (type) {
            case "0": // 상품
                if (shopService.getItemById(Integer.parseInt(itemno)) == null) {
                    out.println("<script type=\"text/javascript\">alert(\"존재 하지 않는 상품 입니다!\");</script>");
                    out.close();
                    return;
                }
                break;
//            case "1": // 후기
//                if (shopService.getReply... == null) {
//                    out.println("<script type=\"text/javascript\">alert(\"존재 하지 않는 후기 입니다!\");</script>");
//                    out.close();
//                    return;
//                }
//                break;
            default:
                out.println("<script type=\"text/javascript\">alert(\"올바르지 않은 접근 입니다!\");</script>");
                out.close();
                return;
        }

        Recommend recommend = new Recommend();

        recommend.setType(Integer.parseInt(type));
        recommend.setItemno(Integer.parseInt(itemno));
        recommend.setMember_id(member_id);

        int result = shopService.recomCheck(recommend);

        if (result == -1) {
            out.println("<script type=\"text/javascript\">alert(\"좋아요 작업을 수행하는 도중 오류가 발생하였습니다!\");</script>");
            out.close();
            return;
        } else if (result == 0) {
            if (shopService.recomAdd(recommend) > 0)
                out.println("<script type=\"text/javascript\">alert(\"좋아요가 반영 되었습니다!\");</script>");
        } else {
            if (shopService.recomDelete(recommend) > 0)
                out.println("<script type=\"text/javascript\">alert(\"좋아요가 취소 되었습니다.\");</script>");
        }

        int count = shopService.recomGetCount(type, Integer.parseInt(itemno));

        if (count == -1) {
            out.println("<script type=\"text/javascript\">alert(\"추천 정보를 가져올 수 없습니다!\");</script>");
        } else {
            out.println(count);
        }


        out.close();

        return;
    }
}
