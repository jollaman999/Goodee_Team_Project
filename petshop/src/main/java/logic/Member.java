package logic;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Size;

public class Member {
    @Size(min = 3, max = 50, message = "아이디를 3자 이상 50자 이하로 입력하세요.")
    private String id;
    @Size(min = 3, max = 50, message = "비밀번호를 3자 이상 50자 이하로 입력하세요.")
    private String pass;
    @NotEmpty(message = "사용자 이름은 필수 입력 사항 입니다.")
    private String name;
    @NotEmpty(message = "전화번호는 필수 입력 사항 입니다.")
    private String phone;
    @NotEmpty(message = "이메일은 필수 입력 사항 입니다.")
    private String email;
    @NotEmpty(message = "주소는 필수 입력 사항 입니다.")
    private String address;
    private String address_detail;
    @NotEmpty(message = "우편번호는 필수 입력 사항 입니다.")
    private String postcode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress_detail() {
        return address_detail;
    }

    public void setAddress_detail(String address_detail) {
        this.address_detail = address_detail;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
}
