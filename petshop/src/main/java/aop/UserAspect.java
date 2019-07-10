package aop;

import exception.LogInException;
import logic.User;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class UserAspect {
    @Around("execution(* controller.User*.check*(..)) && args(session, ..)")
    public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        User loginUser = (User)session.getAttribute(("loginUser"));

        if (loginUser == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        Object ret = joinPoint.proceed();
        return ret;
    }

    @Around("execution(* controller.User*.mypage(..)) && args(id, session, ..)")
    public Object userIdCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable {
        User loginUser = (User)session.getAttribute(("loginUser"));

        if (loginUser == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        if (!loginUser.getUserId().equals(id) && !loginUser.getUserId().equals("admin")) {
            throw new LogInException("본인 정보만 조회 가능합니다!", "main.shop");
        }

        Object ret = joinPoint.proceed();
        return ret;
    }

    @Around("execution(* controller.User*.checkupdateForm(..)) && args(id, session, ..)")
    public Object userUpdateCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable {
        User loginUser = (User)session.getAttribute(("loginUser"));

        if (loginUser == null) {
            throw new LogInException("로그인 후 이용해주세요!", "login.shop");
        }

        if (!loginUser.getUserId().equals(id) && !loginUser.getUserId().equals("admin")) {
            throw new LogInException("본인만 이용 가능합니다!", "main.shop");
        }

        Object ret = joinPoint.proceed();
        return ret;
    }
}
