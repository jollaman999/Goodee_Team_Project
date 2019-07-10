package logic;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class Mail {
    private String recipient;
    private String title;
    private String mtype;
    private String contents;
    private List<MultipartFile> file1;
    private String brand;
    private String id;
    private String pw;

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMtype() {
        return mtype;
    }

    public void setMtype(String mtype) {
        this.mtype = mtype;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public List<MultipartFile> getFile1() {
        return file1;
    }

    public void setFile1(List<MultipartFile> file1) {
        this.file1 = file1;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }
}
