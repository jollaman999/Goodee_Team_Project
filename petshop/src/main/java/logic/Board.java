package logic;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

public class Board {
    private int num;
    private Integer item_no;
    private String item_name;
    private int type;
    @NotEmpty(message = "회원 정보를 가져올 수 없습니다.")
    private String member_id;
    private String name;
    @NotEmpty(message = "제목을 입력해 주세요.")
    private String title;
    @NotEmpty(message = "내용을 입력해 주세요.")
    private String content;
    private MultipartFile file1;
    private String fileurl;
    private Date regdate;
    private int ref;
    private int refstep;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public Integer getItem_no() {
        return item_no;
    }

    public void setItem_no(Integer item_no) {
        this.item_no = item_no;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MultipartFile getFile1() {
        return file1;
    }

    public void setFile1(MultipartFile file1) {
        this.file1 = file1;
    }

    public String getFileurl() {
        return fileurl;
    }

    public void setFileurl(String fileurl) {
        this.fileurl = fileurl;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public int getRef() {
        return ref;
    }

    public void setRef(int ref) {
        this.ref = ref;
    }

    public int getRefstep() {
        return refstep;
    }

    public void setRefstep(int refstep) {
        this.refstep = refstep;
    }
}
