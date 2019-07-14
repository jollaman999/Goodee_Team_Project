package controller;

import exception.LogInException;
import logic.Mail;
import logic.Member;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list() {
        List<Member> list = service.memberList();
        ModelAndView mav = new ModelAndView();
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping("mailForm")
    public ModelAndView mailForm(String[] idchks) {
        ModelAndView mav = new ModelAndView("admin/mail");
        if (idchks == null || idchks.length == 0) {
            throw new LogInException("메일을 보낼 대상자를 선택하세요.", "list.shop");
        }
        List<Member> list = service.memberList(idchks);
        mav.addObject("userList", list);
        return mav;
    }

    @RequestMapping("mail")
    public ModelAndView mail(Mail mail) {
        ModelAndView mav = new ModelAndView("/alert");
        mailSend(mail);
        mav.addObject("msg","메일 전송이 완료되었습니다.");
        mav.addObject("url","list.shop");
        return mav;
    }

    private static final class MyAuthenticator extends Authenticator {
        private String id;
        private String pw;

        MyAuthenticator(String id, String pw) {
            this.id = id;
            this.pw = pw;
        }

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(id, pw);
        }
    }

    private void mailSend(Mail mail) {
        MyAuthenticator auth = new MyAuthenticator(mail.getId(), mail.getPw());
        Properties prop = new Properties();
        switch (mail.getBrand()) {
            case "daum":
                prop.put("mail.smtp.host", "smtp.daum.net");
                break;
            case "naver":
                prop.put("mail.smtp.host", "smtp.naver.com");
                break;
            case "gmail":
                prop.put("mail.smtp.host", "smtp.gmail.com");
                break;
            case "nate":
                prop.put("mail.smtp.host", "smtp.mail.nate.com");
                break;
        }

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.debug", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.user", mail.getId());
        prop.put("mail.smtp.socketFactory.port", 465);
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("javax.net.ssl.SSLSocketFactory.fallback", "false");

        Session session = Session.getInstance(prop, auth);
        MimeMessage mimeMsg = new MimeMessage(session);
        try {
            switch (mail.getBrand()) {
                case "daum":
                    mimeMsg.setFrom(new InternetAddress(mail.getId() + "@daum.net"));
                    break;
                case "naver":
                    mimeMsg.setFrom(new InternetAddress(mail.getId() + "@naver.com"));
                    break;
                case "gmail":
                    mimeMsg.setFrom(new InternetAddress(mail.getId() + "@gmail.com"));
                    break;
                case "nate":
                    mimeMsg.setFrom(new InternetAddress(mail.getId() + "@nate.com"));
                    break;
            }
            List<InternetAddress> addrs = new ArrayList<>();
            String[] emails = mail.getRecipient().trim().split(",");
            for (String email : emails) {
                try {
                    addrs.add(new InternetAddress(new String(email.getBytes("EUC-KR"), "8859_1")));
                } catch (UnsupportedEncodingException ue) {
                    ue.printStackTrace();
                }
            }

            InternetAddress[] arr = new InternetAddress[emails.length];
            for (int i = 0; i < addrs.size(); i++) {
                arr[i] = addrs.get(i);
            }
            mimeMsg.setSentDate(new Date());
            mimeMsg.setRecipients(Message.RecipientType.TO, arr);
            mimeMsg.setSubject(mail.getTitle());

            MimeMultipart multipart = new MimeMultipart();
            MimeBodyPart message = new MimeBodyPart();
            message.setContent(mail.getContents(), mail.getMtype());
            multipart.addBodyPart(message);

            for (MultipartFile mf : mail.getFile1()) {
                if (mf != null && (!mf.isEmpty())) {
                    multipart.addBodyPart(bodyPart(mf));
                }
            }

            mimeMsg.setContent(multipart);
            Transport.send(mimeMsg);
        } catch (MessagingException me) {
            me.printStackTrace();
        }

    }

    private BodyPart bodyPart(MultipartFile mf) {
        MimeBodyPart body = new MimeBodyPart();
        String orgFile = mf.getOriginalFilename();
        File f1 = new File("G:/spring/mailupload/" + orgFile);

        if (orgFile == null) {
            return body;
        }

        try {
            mf.transferTo(f1);
            body.attachFile(f1);
            body.setFileName(new String(orgFile.getBytes("EUC-KR"), "8859_1"));
        } catch (MessagingException | IOException e) {
            e.printStackTrace();
        }

        return body;
    }
}
