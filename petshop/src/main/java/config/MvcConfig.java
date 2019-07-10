package config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import websocket.EchoHandler;

import java.util.Properties;

@Configuration
@ComponentScan(basePackages = {"controller", "logic", "dao", "aop"})
@EnableAspectJAutoProxy
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {
    @Bean
    public HandlerMapping handlerMapping() {
        RequestMappingHandlerMapping rmhm = new RequestMappingHandlerMapping();
        rmhm.setOrder(0);

        return rmhm;
    }

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver irvr = new InternalResourceViewResolver();
        irvr.setPrefix("/WEB-INF/view/");
        irvr.setSuffix(".jsp");

        return irvr;
    }

    @Bean
    public MessageSource messageSource() {
        ResourceBundleMessageSource rbms = new ResourceBundleMessageSource();
        rbms.setBasename("messages");
        rbms.setDefaultEncoding("utf-8");

        return rbms;
    }

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver cmr = new CommonsMultipartResolver();
        cmr.setMaxInMemorySize(10485760);
        cmr.setMaxUploadSize(104857600);

        return cmr;
    }

    @Bean
    public SimpleMappingExceptionResolver exceptionHandler() {
        SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();
        Properties properties = new Properties();
        properties.put("exception.CartEmptyException", "exception");
        properties.put("exception.LoginException", "exception");
        properties.put("exception.ShopException", "exception");
        smer.setExceptionMappings(properties);

        return smer;
    }

    @Bean
    public EchoHandler echoHandler() {
        return new EchoHandler();
    }
}
