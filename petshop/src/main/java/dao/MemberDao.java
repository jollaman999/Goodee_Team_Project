package dao;

import dao.mapper.MemberMapper;
import logic.Member;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import util.CipherUtil;
import util.SecurityUtil;

import java.util.ArrayList;
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

    public int count(String searchtype, String searchcontent) {
        param.clear();

        if (searchtype != null && searchtype.length() != 0 && searchcontent != null && searchcontent.length() != 0) {
            if (searchtype.equals("email")) {
                int count = 0;
                List<Member> member_list = sqlSessionTemplate.selectList(NS + "list");

                if (member_list != null) {
                    for (Member member : member_list) {
                        setDecryptedEmail(member);

                        if (member.getEmail().contains(searchcontent)) {
                            count++;
                        }
                    }
                }

                return count;
            }

            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        return sqlSessionTemplate.selectOne(NS + "count", param);
    }

    public int insert(Member member) {
        String encrypted_password = securityUtil.encryptSHA256(member.getPass());
        member.setPass(encrypted_password);
        setEncryptedEmail(member);

        return sqlSessionTemplate.getMapper(MemberMapper.class).insert(member);
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

    public int update(Member member) {
        String encrypted_password = securityUtil.encryptSHA256(member.getPass());
        member.setPass(encrypted_password);
        setEncryptedEmail(member);

        return sqlSessionTemplate.getMapper(MemberMapper.class).update(member);
    }

    public int update_pass(Member member) {
        setEncryptedEmail(member);

        return sqlSessionTemplate.getMapper(MemberMapper.class).update_pass(member);
    }

    public int delete(Member member) {
        return sqlSessionTemplate.getMapper(MemberMapper.class).delete(member);
    }

    public List<Member> list(Integer pageNum, Integer limit, String searchtype, String searchcontent) {
        List<Member> member_list;

        param.clear();

        if (pageNum != null && pageNum.toString().length() != 0 &&
                limit != null && limit.toString().length() != 0) {
            param.put("startrow", (pageNum - 1) * limit);
            param.put("limit", limit);
        }

        if (searchtype != null && searchtype.length() != 0 && searchcontent != null && searchcontent.length() != 0) {
            if (searchtype.equals("email")) {
                List<Member> email_member_list = new ArrayList<>();
                member_list = sqlSessionTemplate.selectList(NS + "list", param);

                if (member_list != null) {
                    for (Member member : member_list) {
                        setDecryptedEmail(member);

                        if (member.getEmail().contains(searchcontent)) {
                            email_member_list.add(member);
                        }
                    }
                } else {
                    email_member_list = null;
                }

                return email_member_list;
            }

            param.put("searchtype", searchtype);
            param.put("searchcontent", searchcontent);
        }

        member_list = sqlSessionTemplate.selectList(NS + "list", param);

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
