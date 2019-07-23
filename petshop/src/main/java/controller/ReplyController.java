package controller;

import logic.Member;
import logic.Reply;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("reply")
public class ReplyController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");

        if (type == null || type.length() == 0 ||
                itemno == null || itemno.length() == 0) {
            mav = new ModelAndView("/alert");

            mav.addObject("msg","댓글을 불러 올 수 없습니다!");
            mav.addObject("url","blank.shop");

            return mav;
        }

        int pageNum = 1;
        try {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        } catch (NumberFormatException ignored) {
        }

        int limit = 10;
        try {
            limit = Integer.parseInt(request.getParameter("limit"));
        } catch (NumberFormatException ignored) {
        }

        List<Reply> reply_list = service.replyList(type, Integer.parseInt(itemno), pageNum, limit);
        mav.addObject("reply_list", reply_list);
        int reply_count = service.getReplyCount(type, Integer.parseInt(itemno));
        int endpage = reply_count / limit;
        if (reply_count % limit != 0)
            endpage++;
        int startpage = 1;

        request.setAttribute("pageNum", pageNum);
        request.setAttribute("limit", limit);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
        request.setAttribute("reply_count", reply_count);
        request.setAttribute("reply_list", reply_list);
        request.setAttribute("replynum", reply_count - (pageNum - 1) * limit);

        return mav;
    }

    @RequestMapping("write")
    public ModelAndView write(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");
        Member loginMember = (Member)session.getAttribute("loginMember");
        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");
        String content = request.getParameter("content");

        if (type == null || type.length() == 0 ||
                itemno == null || itemno.length() == 0) {
            mav.addObject("msg", "댓글을 등록할 수 없습니다!");
            mav.addObject("url", "blank.shop");

            return mav;
        }

        if (loginMember == null) {
            mav.addObject("msg","댓글은 로그인 중에만 등록 가능합니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (content == null || content.length() == 0) {
            mav.addObject("msg", "댓글 내용이 비어있습니다!");
            mav.addObject("url", "list.shop?type=" + type + "&itemno=" + itemno);

            return mav;
        }

        Reply reply = new Reply();
        int maxnum = service.getReplyMaxNum();

        reply.setNum(maxnum + 1);
        reply.setType(Integer.parseInt(type));
        reply.setItemno(Integer.parseInt(itemno));
        reply.setMember_id(loginMember.getId());
        reply.setContent(content);

        if (service.replyInsert(reply) > 0) {
            mav.addObject("msg", "댓글이 등록 되었습니다.");
            mav.addObject("url", "list.shop?type=" + type + "&itemno=" + itemno);

        } else {
            mav.addObject("msg", "댓글을 등록 하는 중 오류가 발생하였습니다!");
            mav.addObject("url", "list.shop?type=" + type + "&itemno=" + itemno);
        }

        return mav;
    }

    @RequestMapping("updateForm")
    public ModelAndView updateForm(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");
        Member loginMember = (Member)session.getAttribute("loginMember");
        String num = request.getParameter("num");

        if (num == null || num.length() == 0) {
            mav.addObject("msg", "댓글을 수정할 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (loginMember == null) {
            mav.addObject("msg","회원 정보를 불러 올 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        String id = loginMember.getId();
        if (!service.replySelect(Integer.parseInt(num)).getMember_id().equals(id)) {
            mav.addObject("msg", "본인 댓글만 수정 가능합니다!");
            mav.addObject("close", true);

            return mav;
        }

        Reply reply = service.replySelect(Integer.parseInt(num));
        if (reply == null) {
            mav.addObject("msg", "댓글을 가져올 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        mav = new ModelAndView();
        mav.addObject("num", Integer.parseInt(num));
        mav.addObject("reply", reply);

        return mav;
    }

    @RequestMapping("update")
    public ModelAndView update(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");
        Member loginMember = (Member)session.getAttribute("loginMember");
        String num = request.getParameter("num");
        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");
        String content = request.getParameter("content");

        if (num == null || num.length() == 0 ||
                type == null || type.length() == 0 ||
                itemno == null || itemno.length() == 0) {
            mav.addObject("msg", "댓글을 수정할 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (loginMember == null) {
            mav.addObject("msg","회원 정보를 불러 올 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        String id = loginMember.getId();
        if (!service.replySelect(Integer.parseInt(num)).getMember_id().equals(id)) {
            mav.addObject("msg", "본인 댓글만 수정 가능합니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (content == null || content.length() == 0) {
            mav.addObject("msg", "댓글 내용이 비어있습니다!");
            mav.addObject("url", "updateForm.shop?num=" + Integer.parseInt(num));

            return mav;
        }

        Reply reply = service.replySelect(Integer.parseInt(num));
        reply.setContent(content);

        if (service.replyUpdate(Integer.parseInt(num), content) > 0) {
            mav.addObject("msg","댓글이 수정 되었습니다.");
            mav.addObject("reply_reload", true);
        } else {
            mav.addObject("msg", "댓글을 수정 하는 중 오류가 발생하였습니다!");
            mav.addObject("url", "updateForm.shop?num=" + Integer.parseInt(num));
        }

        int pageNum = 1;
        try {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        } catch (NumberFormatException ignored) {
        }

        mav.addObject("type", type);
        mav.addObject("itemno", itemno);
        mav.addObject("pageNum", pageNum);

        return mav;
    }

    @RequestMapping("deleteForm")
    public ModelAndView deleteForm(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");
        Member loginMember = (Member)session.getAttribute("loginMember");
        String num = request.getParameter("num");

        if (num == null || num.length() == 0) {
            mav.addObject("msg", "댓글을 삭제할 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (loginMember == null) {
            mav.addObject("msg","회원 정보를 불러 올 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        String id = loginMember.getId();
        if (!service.replySelect(Integer.parseInt(num)).getMember_id().equals(id)) {
            mav.addObject("msg", "본인 댓글만 삭제 가능합니다!");
            mav.addObject("close", true);

            return mav;
        }

        return new ModelAndView();
    }

    @RequestMapping("delete")
    public ModelAndView delete(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("/alert");
        Member loginMember = (Member)session.getAttribute("loginMember");
        String num = request.getParameter("num");
        String type = request.getParameter("type");
        String itemno = request.getParameter("itemno");

        if (num == null || num.length() == 0 ||
                type == null || type.length() == 0 ||
                itemno == null || itemno.length() == 0) {
            mav.addObject("msg", "댓글을 삭제할 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (loginMember == null) {
            mav.addObject("msg","회원 정보를 불러 올 수 없습니다!");
            mav.addObject("close", true);

            return mav;
        }

        String id = loginMember.getId();
        if (!service.replySelect(Integer.parseInt(num)).getMember_id().equals(id)) {
            mav.addObject("msg", "본인 댓글만 삭제 가능합니다!");
            mav.addObject("close", true);

            return mav;
        }

        if (service.replyDelete(Integer.parseInt(num)) > 0) {
            mav.addObject("msg","댓글이 삭제 되었습니다.");
            mav.addObject("reply_reload", true);
        } else {
            mav.addObject("msg", "댓글을 삭제 하는 중 오류가 발생하였습니다!");
            mav.addObject("url", "deleteForm.shop?num=" + Integer.parseInt(num));
        }

        int pageNum = 1;
        try {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        } catch (NumberFormatException ignored) {
        }

        mav.addObject("type", type);
        mav.addObject("itemno", itemno);
        mav.addObject("pageNum", pageNum);

        return mav;
    }

    @RequestMapping("*")
    public ModelAndView blank() {
        return new ModelAndView();
    }
}
