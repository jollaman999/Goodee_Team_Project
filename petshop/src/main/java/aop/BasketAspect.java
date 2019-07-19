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
public class BasketAspect {
    @Around("execution(* controller.Basket*.*(..)) && args(session, ..)")
    public Object add(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Basket: add aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "../member/login.shop");
        }

        return joinPoint.proceed();
    }
}
