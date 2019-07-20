package dao;

import dao.mapper.MemberMapper;
import logic.Member;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import util.CipherUtil;
import util.SecurityUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("MemberDao")
public class MemberDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private final String NS = "dao.mapper.MemberMapper.";
    private Map<String, Object> param = new HashMap<>();

    private SecurityUtil securityUtil = new SecurityUtil();

    public void insert(Member member) {
        String encrypted_password = securityUtil.encryptSHA256(member.getPass());
        member.setPass(encrypted_password);
        setEncryptedEmail(member);
        sqlSessionTemplate.getMapper(MemberMapper.class).insert(member);
    }

    public Member selectOne(String id) {
        param.clear();
        param.put("id", id);

        Member member = sqlSessionTemplate.selectOne(NS + "list", param);
        if (member != null) {
            setDecryptedEmail(member);
        }

        return member;
    }

    public void update(Member member) {
        String encrypted_password = securityUtil.encryptSHA256(member.getPass());
        member.setPass(encrypted_password);
        setEncryptedEmail(member);
        sqlSessionTemplate.getMapper(MemberMapper.class).update(member);
    }
    public void update_pass(Member member) {
        sqlSessionTemplate.getMapper(MemberMapper.class).update_pass(member);
    }

    public void delete(Member member) {
        sqlSessionTemplate.getMapper(MemberMapper.class).delete(member);
    }

    public List<Member> list() {
        List<Member> member_list = sqlSessionTemplate.selectList(NS + "list");

        if (member_list != null) {
            for (Member member : member_list) {
                setDecryptedEmail(member);
            }
        }

        return member_list;
    }

    public List<Member> list(String[] idchks) {
        StringBuilder ids = new StringBuilder();

        for (int i = 0; i < idchks.length; i++) {
            ids.append("'").append(idchks[i]).append((i == idchks.length - 1) ? "'" : "',");
        }

        param.clear();
        param.put("ids", ids.toString());

        List<Member> member_list = sqlSessionTemplate.selectList(NS + "list", param);
        for (Member member : member_list) {
            setDecryptedEmail(member);
        }

        return member_list;
    }

    private void setEncryptedEmail(Member member) {
        String email = member.getEmail();
        String encrypted_email = CipherUtil.encrypt(email, member.getPass().substring(0, 16));
        member.setEmail(encrypted_email);
    }

    public void setDecryptedEmail(Member member) {
        String encrypted_email = member.getEmail();
        String decrypted_email = CipherUtil.decrypt(encrypted_email, member.getPass().substring(0, 16));
        member.setEmail(decrypted_email);
    }

    public Member find_id(String email) {
        param.clear();
        param.put("email", email);

        return sqlSessionTemplate.selectOne(NS + "list", param);
    }
}
