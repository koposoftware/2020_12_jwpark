package kr.ac.kopo.account.vo;

public class AccountVO {

	private String nameCode;
	private String accountNo;
	private String regNo;
	private int balance;
	private int withdrawableBalance;
	private String password;
	private String dormant;
	private String lost;
	private int limitation;
	private String regDate;
	private String recentlyUseDate;
	private String elecFinanceStatus;
	private String reason;
	private String property;
	private String transactionPurpose;
	private String sourceOfFund;
	private String faceToFace;
	
	public String getNameCode() {
		return nameCode;
	}
	public void setNameCode(String nameCode) {
		this.nameCode = nameCode;
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
	public int getLimitation() {
		return limitation;
	}
	public void setLimitation(int limitation) {
		this.limitation = limitation;
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
	public String getElecFinanceStatus() {
		return elecFinanceStatus;
	}
	public void setElecFinanceStatus(String elecFinanceStatus) {
		this.elecFinanceStatus = elecFinanceStatus;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getProperty() {
		return property;
	}
	public void setProperty(String property) {
		this.property = property;
	}
	public String getTransactionPurpose() {
		return transactionPurpose;
	}
	public void setTransactionPurpose(String transactionPurpose) {
		this.transactionPurpose = transactionPurpose;
	}
	public String getSourceOfFund() {
		return sourceOfFund;
	}
	public void setSourceOfFund(String sourceOfFund) {
		this.sourceOfFund = sourceOfFund;
	}
	public String getFaceToFace() {
		return faceToFace;
	}
	public void setFaceToFace(String faceToFace) {
		this.faceToFace = faceToFace;
	}
	
	@Override
	public String toString() {
		return "AccountVO [nameCode=" + nameCode + ", accountNo=" + accountNo + ", regNo=" + regNo + ", balance="
				+ balance + ", withdrawableBalance=" + withdrawableBalance + ", password=" + password + ", dormant="
				+ dormant + ", lost=" + lost + ", limitation=" + limitation + ", regDate=" + regDate
				+ ", recentlyUseDate=" + recentlyUseDate + ", elecFinanceStatus=" + elecFinanceStatus + ", reason="
				+ reason + ", property=" + property + ", transactionPurpose=" + transactionPurpose + ", sourceOfFund="
				+ sourceOfFund + ", faceToFace=" + faceToFace + "]";
	}
	
}
