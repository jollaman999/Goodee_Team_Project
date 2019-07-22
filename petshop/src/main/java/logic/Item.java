package logic;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.Date;

public class Item {
    private int item_no;
    @Min(value = 1, message = " 상품을 등록할 카테고리 그룹을 선택 해주세요.")
    private Integer category_group_code;
    @Min(value = 1, message = " 상품을 등록할 세부 카테고리를 선택 해주세요.")
    private Integer category_item_code;
    @NotEmpty(message = "상품명을 입력해주세요.")
    private String name;
    @NotNull(message = "상품 이미지를 등록 해주세요.")
    private MultipartFile mainpic;
    private String mainpicurl;
    @NotNull(message = "상품 가격을 입력해 주세요.")
    private Integer price;
    @NotEmpty(message = "상품 요약 정보를 입력해 주세요.")
    private String description;
    @NotEmpty(message = "상품 내용을 입력해 주세요.")
    private String content;
    private String origin; // 원산지
    private String mfr; // 제조사
    private String mfr_tel; // 제조사 연락처
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expr_date; // 유통기한
    @NotNull(message = "상품 수량을 입력해 주세요.")
    private Integer quantity;
    private int sold_quantity;
    private int remained_quantity;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date update_time;

    public int getItem_no() {
        return item_no;
    }

    public void setItem_no(int item_no) {
        this.item_no = item_no;
    }

    public Integer getCategory_group_code() {
        return category_group_code;
    }

    public void setCategory_group_code(Integer category_group_code) {
        this.category_group_code = category_group_code;
    }

    public Integer getCategory_item_code() {
        return category_item_code;
    }

    public void setCategory_item_code(Integer category_item_code) {
        this.category_item_code = category_item_code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public MultipartFile getMainpic() {
        return mainpic;
    }

    public void setMainpic(MultipartFile mainpic) {
        this.mainpic = mainpic;
    }

    public String getMainpicurl() {
        return mainpicurl;
    }

    public void setMainpicurl(String mainpicurl) {
        this.mainpicurl = mainpicurl;
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

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public int getSold_quantity() {
        return sold_quantity;
    }

    public void setSold_quantity(int sold_quantity) {
        this.sold_quantity = sold_quantity;
    }

    public int getRemained_quantity() {
        return remained_quantity;
    }

    public void setRemained_quantity(int remained_quantity) {
        this.remained_quantity = remained_quantity;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }
}
