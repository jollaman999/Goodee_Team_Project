package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class Orders {
	private int num;
	private String member_id;
	@NotEmpty(message="이름을 입력하셔야합니다.")
	private String name;
	@NotEmpty(message="연락처를 한개이상 입력하셔야합니다.")
	private String phone;
	private String phone2;
	@NotEmpty(message="주소지를 입력하셔야합니다.")
	private String address;
	private int deposit_bank_select;
	private int status;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date update_time;
	
	
	//getter setter
	
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
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	} 
}
