package logic;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Past;
import javax.validation.constraints.Size;
import java.util.Date;

public class User {
    @Size(min = 3, max = 10, message = "아이디는 3자 이상 10자 이하로 입력하세요.")
    private String userId;
    @Size(min = 3, max = 12, message = "비밀번호는 3자 이상 10자 이하로 입력하세요.")
    private String password;
    @NotEmpty(message = "사용자 이름은 필수 입니다.")
    private String userName;
    private String phoneNo;
    private String postcode;
    private String address;
    private String email;
    @Past(message = "생일은 과거 날짜만 가능합니다.")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDay;

    @Override
    public String toString() {
        return "User{" +
                "userId='" + userId + '\'' +
                ", password='" + password + '\'' +
                ", userName='" + userName + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", postcode='" + postcode + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", birthday=" + birthDay +
                '}';
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }
}
