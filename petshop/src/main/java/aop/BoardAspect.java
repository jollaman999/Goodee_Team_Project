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
public class BoardAspect {
    @Around("execution(* controller.Board*.*(..)) && args(session, ..)")
    public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Board: * aop");

        Member loginMember = (Member)session.getAttribute(("loginMember"));

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        return joinPoint.proceed();
    }
}
