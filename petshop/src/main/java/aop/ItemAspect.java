package aop;

import exception.ShopException;
import logic.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class ItemAspect {
    @Around("execution(* controller.Item*.*(..)) && args(.., session)")
    public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Item: * aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new ShopException("로그인 후 이용하세요!", "../member/login.shop");
        }

        if (!loginMember.getId().equals("admin")) {
            throw new ShopException("관리자만 이용하세요", "../member/mypage.shop?id" + loginMember.getId());
        }

        return joinPoint.proceed();
    }
}
