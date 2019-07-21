package aop;

import exception.ShopException;
import logic.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Component
@Aspect
public class BasketAspect {
    @Around("execution(* controller.Basket*.*(..)) && args(session, request, ..)")
    public Object add(ProceedingJoinPoint joinPoint, HttpSession session, HttpServletRequest request) throws Throwable {
        System.out.println("Basket: add aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            String referer = URLEncoder.encode(request.getHeader("referer"), StandardCharsets.UTF_8);
            throw new ShopException("로그인 후 이용해주세요!", "../member/login.shop?back_url=" + referer);
        }

        return joinPoint.proceed();
    }
}
