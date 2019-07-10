package config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;

@Configuration
public class DBConfig {

    @Bean
    public DataSource dataSource2() {
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName("org.mariadb.jdbc.Driver");
        ds.setUrl("jdbc:mariadb://127.0.0.1:3306/model1");
        ds.setUsername("model2");
        ds.setPassword("1234");
        return ds;
    }

    private DataSource dataSource() {
        ComboPooledDataSource ds = new ComboPooledDataSource();
        try {
            ds.setDriverClass("org.mariadb.jdbc.Driver");
            ds.setJdbcUrl("jdbc:mariadb://127.0.0.1:3306/model1");
            ds.setUser("model1");
            ds.setPassword("1234");
            ds.setMaxPoolSize(20);
            ds.setMinPoolSize(3);
            ds.setInitialPoolSize(5);
            ds.setAcquireIncrement(5);
        } catch (PropertyVetoException e) {
            e.printStackTrace();
        }

        return ds;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource());
        bean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
        return bean.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory());
    }
}

