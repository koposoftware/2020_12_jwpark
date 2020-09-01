package kr.ac.kopo.saving.vo;

public class SavingVO {

	private String accountNo;
	private String regNo;
	private String nameCode;
	private int savingAmmount;
	private int plannedAmmount;
	private String interest;
	private String regDate;
	private String expiredDate;
	private String refAccountNo;
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
	public String getNameCode() {
		return nameCode;
	}
	public void setNameCode(String nameCode) {
		this.nameCode = nameCode;
	}
	public int getSavingAmmount() {
		return savingAmmount;
	}
	public void setSavingAmmount(int savingAmmount) {
		this.savingAmmount = savingAmmount;
	}
	public int getPlannedAmmount() {
		return plannedAmmount;
	}
	public void setPlannedAmmount(int plannedAmmount) {
		this.plannedAmmount = plannedAmmount;
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
		return "SavingVO [accountNo=" + accountNo + ", regNo=" + regNo + ", nameCode=" + nameCode + ", savingAmmount="
				+ savingAmmount + ", plannedAmmount=" + plannedAmmount + ", interest=" + interest + ", regDate="
				+ regDate + ", expiredDate=" + expiredDate + ", refAccountNo=" + refAccountNo + "]";
	}
	
}
