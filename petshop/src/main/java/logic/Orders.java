package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class Orders {
    private int num;
    private String member_id;
    @NotEmpty(message = "이름을 입력하셔야합니다.")
    private String name;
    @NotEmpty(message = "연락처를 한개이상 입력하셔야합니다.")
    private String phone;
    private String phone2;
    @NotEmpty(message = "주소지를 입력하셔야합니다.")
    private String address;
    private String address_detail;
    private String postcode;
    private int deposit_bank_select;
    private int status;
    private String account_holder;
    private String account_bank;
    private String account_number;
    private int price_total;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date update_time;
    private List<Orders_list> orders_lists = new ArrayList<>();
    
    
    //테스트
    private Integer totaldiff;
    private Date _month;

    //테스트
    


	public Date get_month() {
		return _month;
	}

	public Integer getTotaldiff() {
		return totaldiff;
	}

	public void setTotaldiff(Integer totaldiff) {
		this.totaldiff = totaldiff;
	}

	public void set_month(Date _month) {
		this._month = _month;
	}


    
    //
	
	
	
	
	
	public int getNum() {
        return num;
    }


	public void setNum(int num) {
        this.num = num;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
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

    public int getDeposit_bank_select() {
        return deposit_bank_select;
    }

    public void setDeposit_bank_select(int deposit_bank_select) {
        this.deposit_bank_select = deposit_bank_select;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAccount_holder() {
        return account_holder;
    }

    public void setAccount_holder(String account_holder) {
        this.account_holder = account_holder;
    }

    public String getAccount_bank() {
        return account_bank;
    }

    public void setAccount_bank(String account_bank) {
        this.account_bank = account_bank;
    }

    public String getAccount_number() {
        return account_number;
    }

    public void setAccount_number(String account_number) {
        this.account_number = account_number;
    }

    public int getPrice_total() {
        return price_total;
    }

    public void setPrice_total(int price_total) {
        this.price_total = price_total;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }

    public List<Orders_list> getOrders_lists() {
        return orders_lists;
    }

    public void setOrders_lists(List<Orders_list> orders_lists) {
        this.orders_lists = orders_lists;
    }
}
