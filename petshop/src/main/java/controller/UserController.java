package controller;

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

@Component
@RequestMapping("user")
public class UserController {
    @Autowired
    private ShopService service;

    private SecurityUtil securityUtil = new SecurityUtil();

    @GetMapping("*")
    public String form(Model model) {
        model.addAttribute(new User());
        return null;
    }

    @PostMapping("userEntry")
    public ModelAndView userEntry(@Valid User user, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView();
        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        try {
            service.userCreate(user);
            mav.setViewName("user/login");
            mav.addObject("user", user);
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.reject("error.duplicate.user");
        }

        return mav;
    }

    @PostMapping("login")
    public ModelAndView login(@Valid User user, BindingResult bindingResult, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (bindingResult.hasErrors()) {
            bindingResult.reject("error.login.user");
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        User dbuser = service.userSelect(user.getUserId());
        if (dbuser == null) {
            bindingResult.reject("error.login.id");
            return mav;
        }

        if (securityUtil.encryptSHA256(user.getPassword()).equals(dbuser.getPassword())) {
            session.setAttribute("loginUser", dbuser);
        } else {
            bindingResult.reject("error.login.password");
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
    public String checkmain(HttpSession session) {
        return "user/main";
    }

    @RequestMapping("mypage")
    public ModelAndView mypage(String id) {
        ModelAndView mav = new ModelAndView();
        User user = service.userSelect(id);
        List<Sale> salelist = service.salelist(id);
        for (Sale sa : salelist) {
            List<SaleItem> saleItemList = service.saleItemList(sa.getSaleId());
            for (SaleItem si : saleItemList) {
                Item item = service.getItemById(si.getItemId());
                si.setItem(item);
            }
            sa.setItemList(saleItemList);
        }
        mav.addObject("user", user);
        mav.addObject("salelist", salelist);

        return mav;
    }

    @GetMapping(value = {"update", "delete"})
    public ModelAndView checkupdateForm(String id) {
        ModelAndView mav = new ModelAndView();
        User user = service.userSelect(id);
        mav.addObject(user);

        return mav;
    }

    @PostMapping("update")
    public ModelAndView doupdate(@Valid User user, BindingResult bindingResult, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (bindingResult.hasErrors()) {
            mav.getModel().putAll(bindingResult.getModel());
            return mav;
        }

        User loginUser = (User)session.getAttribute("loginUser");
        User dbuser = service.userSelect(user.getUserId());

        if (!dbuser.getPassword().equals(securityUtil.encryptSHA256(user.getPassword()))) {
            bindingResult.reject("error.login.password");
            return mav;
        }

        try {
            service.userUpdate(user);
            mav.setViewName("redirect:mypage.shop?id=" + user.getUserId());
            if (loginUser.getUserId().equals(dbuser.getUserId()))
                session.setAttribute("loginUser", user);
        } catch (Exception e) {
            e.printStackTrace();
            bindingResult.reject("error.user.update");
        }

        return mav;
    }

    /*
    1. 관리자 강제 탈퇴
        - 비밀번호에 관리자 비밀번호 입력하기
        - 관리자 비밀번호가 맞는 경우 해당 회원정보 db에서 삭제
        - 삭제성공 : mypage.shop 으로 페이지 이동
        - 삭제 실패 : delete.shop 으로 페이지 이동
    2. 본인 탈퇴
        - 비밀번호에 본인 비밀번호 입력하기
        - 비밀번호가 맞는 경우 회원 정보 삭제
        - 삭제 성공 : 로그아웃 후 login.shop 으로 페이지 이동
        - 삭제 실패 : delete.shop 으로 페이지 이동
     */
    @PostMapping("delete")
    public ModelAndView delete(User user, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        User loginUser = (User)session.getAttribute(("loginUser"));
        if (loginUser == null) {
            throw new LogInException("로그인 후 이용해 주십시오!", "login.shop");
        }

        if (!loginUser.getPassword().equals(securityUtil.encryptSHA256(user.getPassword()))) {
            throw new LogInException("비밀번호가 일치하지 않습니다!", "delete.shop?id=" + user.getUserId());
        }

        try {
            service.userDelete(user);
            if (loginUser.getUserId().equals("admin")) {
                mav.setViewName("redirect:/admin/list.shop");
            } else {
                session.invalidate();
                mav.addObject("msg", "탈퇴 되었습니다. 그동안 이용해 주셔서 감사합니다.");
                mav.addObject("url", "login.shop");
                mav.setViewName("alert");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new LogInException("회원 정보 삭제가 실패했습니다. 전산부 전화요망. (전화 : 1234)", "delete.shop?id=" + user.getUserId());
        }

        return mav;
    }
}