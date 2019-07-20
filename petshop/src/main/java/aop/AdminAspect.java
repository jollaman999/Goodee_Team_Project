package aop;

import exception.LogInException;
import logic.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class AdminAspect {
    @Around("execution(* controller.Admin*.*(..)) && args(.., session)")
    public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Admin: * aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용하세요!", "../member/login.shop");
        }

        if (!loginMember.getId().equals("admin")) {
            throw new LogInException("잘못된 접근입니다!", "../index.jsp");
        }

        return joinPoint.proceed();
    }

    @Around("execution(* controller.Inventory*.*(..)) && args(.., session)")
    public Object inventoryCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Inventory: * aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용하세요!", "../member/login.shop");
        }

        if (!loginMember.getId().equals("admin")) {
            throw new LogInException("잘못된 접근입니다!", "../index.jsp");
        }

        return joinPoint.proceed();
    }
}
