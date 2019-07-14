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
        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용하세요!", "../user/login.shop");
        }

        if (!loginMember.getId().equals("admin")) {
            throw new LogInException("관리자만 이용하세요", "../user/mypage.shop?id" + loginMember.getId());
        }

        return joinPoint.proceed();
    }


}
