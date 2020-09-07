package kr.ac.kopo.elecFinanceUser.vo;

public class ElecFinanceUserVO {

	private String id;
	private String password;
	private String regNo;
	private String refAccountNo;
	private String tel;
	private String regDate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
	public String getRefAccountNo() {
		return refAccountNo;
	}
	public void setRefAccountNo(String refAccountNo) {
		this.refAccountNo = refAccountNo;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "elecFinance [id=" + id + ", password=" + password + ", regNo=" + regNo + ", refAccountNo="
				+ refAccountNo + ", tel=" + tel + ", regDate=" + regDate + "]";
	}
}
