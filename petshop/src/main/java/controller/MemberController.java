package controller;

import exception.ShopException;
import logic.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import util.SecurityUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("member")
public class MemberController {
    @Autowired
    private ShopService service;

    private SecurityUtil securityUtil = new SecurityUtil();

    @GetMapping("*")
    public String form(Model model, HttpServletRequest request) {
        if (request.getRequestURI().contains("login") || request.getRequestURI().contains("memberEntry")) {
            if (request.getSession().getAttribute("loginMember") != null) {
                throw new ShopException( "이미 로그인 중입니다!", "../index.jsp");
            }
        }
        model.addAttribute(new Member());
        return null;
    }

    @PostMapping("memberEntry")
    public ModelAndView memberEntry(@Valid Member member, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView();
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        try {
            Map<String, Object> map = bindingResult.getModel();
            Member mem = (Member)map.get("member");

            if (mem.getId() != null && service.memberSelect(mem.getId()) != null) {
                bindingResult.reject("error.duplicate.id");
                return mav;
            }

            service.memberCreate(member);
            mav.setViewName("redirect:login.shop");
            mav.addObject("member", member);
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.reject("error.database");
        }

        return mav;
    }

    @RequestMapping("idcheck")
    public ModelAndView idcheck(String id) {
        ModelAndView mav = new ModelAndView("/alert");
        Member member = service.memberSelect(id);
        String msg;

        mav.addObject("url", "idcheckForm.shop");

        if (member != null && id != null && id.length() != 0 && member.getId().equalsIgnoreCase(id)) {
            msg = id + " 는(은) 이미 존재하는 아이디 입니다!";
        } else if (id != null && id.equals("admin")) {
            msg = id + " 는(은) 사용할 수 없는 아이디 입니다!";
        } else if (id != null && !id.equals("중복확인을 눌러주세요")) {
            msg = id + " 는(은) 사용 가능한 아이디 입니다.";
            mav.addObject("check_id", true);
        } else {
            return mav;
        }

        mav.addObject("msg", msg);

        return mav;
    }

    @RequestMapping("emailcheck")
    public ModelAndView emailcheck(String email) {
        ModelAndView mav = new ModelAndView("/alert");
        List<Member> memberList = service.memberList();
        String msg;

        mav.addObject("url", "emailcheckForm.shop");

        if (memberList != null) {
            for (Member member : memberList) {
                if (member.getEmail().equals(email)) {
                    msg = email + " 는(은) 사용중인 이메일 주소 입니다!";
                    mav.addObject("msg", msg);
                    return mav;
                }
            }
        }

        msg = email + " 는(은) 사용 가능한 이메일 주소 입니다.";
        mav.addObject("msg", msg);

        mav.addObject("check_email", true);

        return mav;
    }

    @PostMapping("login")
    public ModelAndView login(@Valid Member member, BindingResult bindingResult, HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult);
            bindingResult.reject("error.login.member");
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        Member dbmember = service.memberSelect(member.getId());
        if (dbmember == null) {
            bindingResult.reject("error.login.id");
            return mav;
        }

        if (securityUtil.encryptSHA256(member.getPass()).equals(dbmember.getPass())) {
            session.setAttribute("loginMember", dbmember);
        } else {
            bindingResult.reject("error.login.pass");
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        mav.setViewName("redirect:" + request.getParameter("back_url"));

        return mav;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login.shop";
    }

    @RequestMapping("mypage")
    public ModelAndView mypage(String id, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (id == null || id.length() == 0) {
            id = ((Member)session.getAttribute("loginMember")).getId();
        }
        Member member = service.memberSelect(id);
        mav.addObject("member", member);

        return mav;
    }

    @RequestMapping("orderHistory")
    public ModelAndView orderHistory(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        Member loginMember = (Member)session.getAttribute(("loginMember"));
        String member_id = loginMember.getId();

        List<Orders> ordersList_all = service.getOrdersList(member_id, null);
        List<Orders> ordersList_7 = service.getOrdersList(member_id, 7);
        List<Orders> ordersList_30 = service.getOrdersList(member_id, 30);
        List<Orders> ordersList_180 = service.getOrdersList(member_id, 180);

        mav.addObject("ordersList_all", ordersList_all);
        mav.addObject("ordersList_7", ordersList_7);
        mav.addObject("ordersList_30", ordersList_30);
        mav.addObject("ordersList_180", ordersList_180);

        return mav;
    }

    @GetMapping(value = {"update", "delete"})
    public ModelAndView updateForm(String id, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (id == null || id.length() == 0) {
            id = ((Member)session.getAttribute("loginMember")).getId();
        }

        Member member = service.memberSelect(id);
        mav.addObject(member);

        return mav;
    }

    @PostMapping("update")
    public ModelAndView update(String id, HttpSession session, @Valid Member member, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView();

        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        Member loginMember = (Member) session.getAttribute("loginMember");
        Member dbmember = service.memberSelect(member.getId());

        if (!dbmember.getPass().equals(securityUtil.encryptSHA256(member.getPass()))) {
            bindingResult.reject("error.login.pass");
            return mav;
        }

        try {
            service.memberUpdate(member);
            mav.setViewName("redirect:mypage.shop?id=" + member.getId());
            if (loginMember.getId().equals(dbmember.getId()))
                session.setAttribute("loginMember", member);
        } catch (Exception e) {
            e.printStackTrace();
            bindingResult.reject("error.member.update");
        }

        return mav;
    }

    @RequestMapping("update_pw")
    public String update_pw_form(String id, HttpSession session) {
        return null;
    }

    @PostMapping("update_pw")
    public ModelAndView update_pw(String id, HttpSession session, String pass, String previous_password) {
        ModelAndView mav = new ModelAndView("/alert");

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (previous_password == null || previous_password.length() == 0) {
            mav.addObject("msg", "이전 비밀번호를 입력해 주세요!");
            mav.addObject("url", "update_pw.shop?id=" + loginMember.getId());

            return mav;
        }

        if (!loginMember.getPass().equals(securityUtil.encryptSHA256(previous_password))) {
            mav.addObject("msg", "이전 비밀번호가 일치하지 않습니다!");
            mav.addObject("url", "update_pw.shop?id=" + loginMember.getId());

            return mav;
        }

        if (loginMember.getPass().equals(securityUtil.encryptSHA256(pass))) {
            mav.addObject("msg", "새 비밀번호가 이전 비밀번호와 동일합니다!");
            mav.addObject("url", "update_pw.shop?id=" + loginMember.getId());

            return mav;
        }

        Member dbMember = service.memberSelect(loginMember.getId());
        if (dbMember == null) {
            mav.addObject("msg", "회원 정보를 조회할 수 없습니다!");
            mav.addObject("url", "update_pw.shop?id=" + loginMember.getId());

            return mav;
        }

        Member member = new Member();
        member.setId(loginMember.getId());
        member.setPass(securityUtil.encryptSHA256(pass));
        member.setEmail(dbMember.getEmail());

        if (service.memberUpdatePass(member) > 0) {
            mav.addObject("msg", "비밀번호가 변경 되었습니다.");
            mav.addObject("url", "mypage.shop");
        } else {
            mav.addObject("msg", "비밀번호 변경을 실패하였습니다!");
            mav.addObject("url", "update_pw.shop?id=" + member.getId());
        }

        return mav;
    }

    @PostMapping("delete")
    public ModelAndView delete(Member member, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        Member loginMember = (Member)session.getAttribute(("loginMember"));
        if (loginMember == null) {
            throw new ShopException("로그인 후 이용해 주십시오!", "login.shop");
        }

        if (!loginMember.getId().equals("admin") && !loginMember.getPass().equals(securityUtil.encryptSHA256(member.getPass()))) {
            throw new ShopException("비밀번호가 일치하지 않습니다!", "delete.shop?id=" + member.getId());
        }

        try {
            service.memberDelete(member);
            if (loginMember.getId().equals("admin")) {
                mav.addObject("msg", "해당 회원의 탈퇴가 완료되었습니다.");
                mav.addObject("url", "../admin/list.shop");
                mav.setViewName("alert");
            } else {
                session.invalidate();
                mav.addObject("msg", "탈퇴 되었습니다. 그동안 이용해 주셔서 감사합니다.");
                mav.addObject("url", "login.shop");
                mav.setViewName("alert");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ShopException("회원 정보 삭제가 실패했습니다!", "delete.shop?id=" + member.getId());
        }

        return mav;
    }
    
    @RequestMapping(value = "/find_id_form.shop")
	public String find_id_form() {
		return "/member/find_id_form";
	}
    
    @RequestMapping(value = "/find_id.shop", method = RequestMethod.POST)
	public String find_id_form(HttpServletResponse response, @RequestParam("email") String email, Model md) throws Exception
    {
    	md.addAttribute("id", service.find_id_by_email(response, email));
		return "/member/find_id";
	}

	@RequestMapping(value = "/find_pw_form.shop")
	public String find_pw_form()  {
		return "/member/find_pw_form";
	}

    @RequestMapping(value = "/find_pw.shop", method = RequestMethod.POST)
    public void find_pw(HttpServletResponse response, Member member) throws Exception{
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        service.find_pw(out, member);
    }
}
