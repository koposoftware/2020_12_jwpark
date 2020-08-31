package kr.ac.kopo.deposit.vo;

public class DepositVO {

	private String AccountNo;
	private String regNo;
	private String nameCode;
	private int depositAmmount;
	private String interest;
	private String regDate;
	private String expiredDate;
	private String refAccountNo;
	
	public String getAccountNo() {
		return AccountNo;
	}
	public void setAccountNo(String accountNo) {
		AccountNo = accountNo;
	}
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
	public String getNameCode() {
		return nameCode;
	}
	public void setNameCode(String nameCode) {
		this.nameCode = nameCode;
	}
	public int getDepositAmmount() {
		return depositAmmount;
	}
	public void setDepositAmmount(int depositAmmount) {
		this.depositAmmount = depositAmmount;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getExpiredDate() {
		return expiredDate;
	}
	public void setExpiredDate(String expiredDate) {
		this.expiredDate = expiredDate;
	}
	public String getRefAccountNo() {
		return refAccountNo;
	}
	public void setRefAccountNo(String refAccountNo) {
		this.refAccountNo = refAccountNo;
	}
	
	@Override
	public String toString() {
		return "DepositVO [AccountNo=" + AccountNo + ", regNo=" + regNo + ", nameCode=" + nameCode + ", depositAmmount="
				+ depositAmmount + ", interest=" + interest + ", regDate=" + regDate + ", expiredDate=" + expiredDate
				+ ", refAccountNo=" + refAccountNo + "]";
	}
	
}
