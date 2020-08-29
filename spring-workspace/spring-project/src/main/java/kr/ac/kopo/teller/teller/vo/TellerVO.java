package kr.ac.kopo.teller.teller.vo;

public class TellerVO {

	private String empNo;
	private String password;
	private String name;
	private String regDate;
	
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "TellerVO [empNo=" + empNo + ", password=" + password + ", name=" + name + ", regDate=" + regDate + "]";
	}
	
	
	
}
