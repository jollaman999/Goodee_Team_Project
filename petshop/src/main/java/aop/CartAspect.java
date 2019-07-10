package aop;

import exception.CartEmptyException;
import exception.LogInException;
import logic.Cart;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Aspect
public class CartAspect {
    @Around("execution(* controller.Cart*.check*(..))")
    public Object cartCheck(ProceedingJoinPoint joinPoint) throws Throwable {
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
