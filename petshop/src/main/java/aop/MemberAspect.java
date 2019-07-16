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
public class MemberAspect {
    @Around("execution(* controller.Member*.mypage(..)) && args(id, session, ..)")
    public Object userIdCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable {
        System.out.println("Member: mypage aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        if (!loginMember.getId().equals(id) && !loginMember.getId().equals("admin")) {
            throw new LogInException("본인 정보만 조회 가능합니다!", "main.shop");
        }

        return joinPoint.proceed();
    }

    @Around("execution(* controller.Member*.checkupdateForm(..)) && args(id, session, ..)")
    public Object userUpdateCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable {
        System.out.println("Member: checkupdateForm aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        if (!loginMember.getId().equals(id) && !loginMember.getId().equals("admin")) {
            throw new LogInException("본인만 이용 가능합니다!", "main.shop");
        }

        return joinPoint.proceed();
    }
}
