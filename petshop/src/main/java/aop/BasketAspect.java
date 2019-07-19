package aop;

import exception.CartEmptyException;
import exception.LogInException;
import logic.Cart;
import logic.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class BasketAspect {
    @Around("execution(* controller.Basket*.add(..)) && args(session, ..)")
    public Object add(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Basket: add aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "../member/login.shop");
        }

        return joinPoint.proceed();
    }

    @Around("execution(* controller.Basket*.view(..)) && args(session, ..)")
    public Object view(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
        System.out.println("Basket: view aop");

        Member loginMember = (Member)session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new LogInException("로그인 후 이용해주세요!", "../member/login.shop");
        }

        return joinPoint.proceed();
    }

    @Around("execution(* controller.Basket*.checkout(..))")
    public Object cartCheck(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("Basket: checkout aop");

        HttpSession session = (HttpSession)joinPoint.getArgs()[0];
        Cart cart = (Cart)session.getAttribute("CART");

        if (cart == null || cart.isEmpty()) {
            throw new CartEmptyException("장바구니에 주문 상품이 없습니다.", "../item/list.shop");
        }

        if (session.getAttribute("loginUser") == null) {
            throw new LogInException("로그인 한 고객만 상품 주문이 가능합니다!", "../item/list.shop");
        }

        return joinPoint.proceed();
    }
}
