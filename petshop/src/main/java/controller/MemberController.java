package controller;

import dao.MemberDao;
import exception.LogInException;
import logic.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import util.SecurityUtil;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("member")
public class MemberController {
    @Autowired
    private ShopService service;

    private SecurityUtil securityUtil = new SecurityUtil();

    @GetMapping("*")
    public String form(Model model) {
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
                new MemberDao().setDecryptedEmail(mem);

                return mav;
            }

            service.memberCreate(member);
            mav.setViewName("member/login");
            mav.addObject("member", member);
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.reject("error.database");
        }

        return mav;
    }

    @PostMapping("login")
    public ModelAndView login(@Valid Member member, BindingResult bindingResult, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (bindingResult.hasErrors()) {
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

        mav.setViewName("redirect:main.shop");
        return mav;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login.shop";
    }

    @RequestMapping("main")
    public String checkmain() {
        return "member/main";
    }

    @RequestMapping("mypage")
    public ModelAndView mypage(String id) {
        ModelAndView mav = new ModelAndView();
        Member member = service.memberSelect(id);
        List<Sale> salelist = service.salelist(id);
        for (Sale sa : salelist) {
            List<SaleItem> saleItemList = service.saleItemList(sa.getSaleId());
            for (SaleItem si : saleItemList) {
                Item item = service.getItemById(si.getItemId());
                si.setItem(item);
            }
            sa.setItemList(saleItemList);
        }
        mav.addObject("member", member);
        mav.addObject("salelist", salelist);

        return mav;
    }

    @GetMapping(value = {"update", "delete"})
    public ModelAndView checkupdateForm(String id) {
        ModelAndView mav = new ModelAndView();
        Member member = service.memberSelect(id);
        mav.addObject(member);

        return mav;
    }

    @PostMapping("update")
    public ModelAndView doupdate(@Valid Member member, BindingResult bindingResult, HttpSession session) {
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

    @PostMapping("delete")
    public ModelAndView delete(Member member, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        Member loginMember = (Member)session.getAttribute(("loginMember"));
        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해 주십시오!", "login.shop");
        }

        if (!loginMember.getPass().equals(securityUtil.encryptSHA256(member.getPass()))) {
            throw new LogInException("비밀번호가 일치하지 않습니다!", "delete.shop?id=" + member.getId());
        }

        try {
            service.memberDelete(member);
            if (loginMember.getId().equals("admin")) {
                mav.setViewName("redirect:/admin/list.shop");
            } else {
                session.invalidate();
                mav.addObject("msg", "탈퇴 되었습니다. 그동안 이용해 주셔서 감사합니다.");
                mav.addObject("url", "login.shop");
                mav.setViewName("alert");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new LogInException("회원 정보 삭제가 실패했습니다. 전산부 전화요망. (전화 : 1234)", "delete.shop?id=" + member.getId());
        }

        return mav;
    }
}