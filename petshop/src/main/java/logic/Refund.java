package logic;

public class Refund {
	private int order_num;
	private String account_holder;
	private String account_bank;
	private int account_num;
	
	//getter setter 
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
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
	public int getAccount_num() {
		return account_num;
	}
	public void setAccount_num(int account_num) {
		this.account_num = account_num;
	}
}
