package kr.ac.kopo.account.vo;

public class AccountVO {

	private String type;
	private String accountNo;
	private String regNo;
	private String productName;
	private int balance;
	private int withdrawableBalance;
	private String password;
	private String dormant;
	private String lost;
	private String regDate;
	private String recentlyUseDate;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public int getWithdrawableBalance() {
		return withdrawableBalance;
	}
	public void setWithdrawableBalance(int withdrawableBalance) {
		this.withdrawableBalance = withdrawableBalance;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDormant() {
		return dormant;
	}
	public void setDormant(String dormant) {
		this.dormant = dormant;
	}
	public String getLost() {
		return lost;
	}
	public void setLost(String lost) {
		this.lost = lost;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRecentlyUseDate() {
		return recentlyUseDate;
	}
	public void setRecentlyUseDate(String recentlyUseDate) {
		this.recentlyUseDate = recentlyUseDate;
	}
	
	@Override
	public String toString() {
		return "AccountVO [type=" + type + ", accountNo=" + accountNo + ", regNo=" + regNo + ", productName="
				+ productName + ", balance=" + balance + ", withdrawableBalance=" + withdrawableBalance + ", password="
				+ password + ", dormant=" + dormant + ", lost=" + lost + ", regDate=" + regDate + ", recentlyUseDate="
				+ recentlyUseDate + "]";
	}
	
	
	
}
