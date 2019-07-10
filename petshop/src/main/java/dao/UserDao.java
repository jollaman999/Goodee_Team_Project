package dao;

import dao.mapper.UserMapper;
import logic.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import util.CipherUtil;
import util.SecurityUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.UserMapper.";
    private Map<String, Object> param = new HashMap<>();

    private SecurityUtil securityUtil = new SecurityUtil();

    public void insert(User user) {
        String encrypted_password = securityUtil.encryptSHA256(user.getPassword());
        user.setPassword(encrypted_password);
        setEncryptedEmail(user);
        sqlSessionTemplate.getMapper(UserMapper.class).insert(user);
    }

    public User selectOne(String userId) {
        param.clear();
        param.put("userid", userId);

        User user = sqlSessionTemplate.selectOne(NS + "list", param);
        setDecryptedEmail(user);
        return user;
    }

    public void update(User user) {
        String encrypted_password = securityUtil.encryptSHA256(user.getPassword());
        user.setPassword(encrypted_password);
        setEncryptedEmail(user);
        sqlSessionTemplate.getMapper(UserMapper.class).update(user);
    }

    public void delete(User user) {
        sqlSessionTemplate.getMapper(UserMapper.class).delete(user);
    }

    public List<User> list() {
        List<User> user_list = sqlSessionTemplate.selectList(NS + "list");
        for (User user : user_list) {
            setDecryptedEmail(user);
        }

        return user_list;
    }

    public List<User> list(String[] idchks) {
        StringBuilder ids = new StringBuilder();

        for (int i = 0; i <idchks.length; i++) {
            ids.append("'").append(idchks[i]).append((i == idchks.length - 1) ? "'" : "',");
        }

        param.clear();
        param.put("ids", ids.toString());

        List<User> user_list = sqlSessionTemplate.selectList(NS + "list", param);
        for (User user : user_list) {
            setDecryptedEmail(user);
        }

        return user_list;
    }

    private void setEncryptedEmail(User user) {
        String email = user.getEmail();
        String encrypted_email = CipherUtil.encrypt(email, user.getPassword().substring(0, 16));
        user.setEmail(encrypted_email);
    }

    private void setDecryptedEmail(User user) {
        String encrypted_email = user.getEmail();
        String decrypted_email = CipherUtil.decrypt(encrypted_email, user.getPassword().substring(0, 16));
        user.setEmail(decrypted_email);
    }
}
