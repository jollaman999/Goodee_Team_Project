package logic;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class Item {
    private Integer id;
    @NotEmpty(message = "상품명을 등록하세요")
    private String name;
    @NotNull(message = "가격을 등록하세요")
    @Min(value = 10, message = "가격은 10원이상 가능합니다.")
    @Max(value = 100000, message = "가격은 10만원 이하만 가능합니다.")
    private Integer price;
    @NotEmpty(message = "상품내용을 등록하세요")
    private String description;
    private String pictureUrl;
    private MultipartFile picture;

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", pictureUrl='" + pictureUrl + '\'' +
                ", picture=" + picture +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public MultipartFile getPicture() {
        return picture;
    }

    public void setPicture(MultipartFile picture) {
        this.picture = picture;
    }
}
