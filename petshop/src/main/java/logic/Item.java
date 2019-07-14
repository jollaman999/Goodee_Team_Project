package logic;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import java.util.Date;

public class Item {
    private int item_no;
    @NotEmpty(message = " 상품을 등록할 카테고리를 선택 해주세요.")
    private int category_item_code;
    @NotEmpty(message = "상품명을 입력해주세요.")
    private String name;
    @NotEmpty(message = "상품 이미지를 등록 해주세요.")
    private String mainpic;
    private MultipartFile mainpicMultipartFile;
    @NotNull(message = "상품 가격을 입력해 주세요.")
    private Integer price;
    @NotEmpty(message = "상품 요약 정보를 입력해 주세요.")
    private String description;
    @NotEmpty(message = "상품 내용을 입력해 주세요.")
    private String content;
    private String origin; // 원산지
    private String mfr; // 제조사
    private String mfr_tel; // 제조사 연락처
    private Date expr_date; // 유통기한
    @NotEmpty(message = "상품 수량을 입력해 주세요.")
    private int quantity;

    public int getItem_no() {
        return item_no;
    }

    public void setItem_no(int item_no) {
        this.item_no = item_no;
    }

    public int getCategory_item_code() {
        return category_item_code;
    }

    public void setCategory_item_code(int category_item_code) {
        this.category_item_code = category_item_code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMainpic() {
        return mainpic;
    }

    public void setMainpic(String mainpic) {
        this.mainpic = mainpic;
    }

    public MultipartFile getMainpicMultipartFile() {
        return mainpicMultipartFile;
    }

    public void setMainpicMultipartFile(MultipartFile mainpicMultipartFile) {
        this.mainpicMultipartFile = mainpicMultipartFile;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getMfr() {
        return mfr;
    }

    public void setMfr(String mfr) {
        this.mfr = mfr;
    }

    public String getMfr_tel() {
        return mfr_tel;
    }

    public void setMfr_tel(String mfr_tel) {
        this.mfr_tel = mfr_tel;
    }

    public Date getExpr_date() {
        return expr_date;
    }

    public void setExpr_date(Date expr_date) {
        this.expr_date = expr_date;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
