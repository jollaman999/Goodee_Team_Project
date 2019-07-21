package aop;

import exception.ShopException;
import logic.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class BoardAspect {
    @Around("execution(* controller.Board*.*(..)) && args(session, type, ..)")
    public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session, Integer type) throws Throwable {
        System.out.println("Board: * aop");

        Member loginMember = (Member)session.getAttribute(("loginMember"));

        if (loginMember == null) {
            throw new ShopException("로그인 후 이용해주세요!", "../member/login.shop");
        }

        if (type == null) {
            throw new ShopException("게시판 유형을 알 수 없습니다!", "../index.jsp");
        }

        switch (type) {
            case 0:
                session.setAttribute("board_title", "공지사항");
                break;
            case 1:
                session.setAttribute("board_title", "1대1 문의 게시판");
                break;
        }

        return joinPoint.proceed();
    }
}
