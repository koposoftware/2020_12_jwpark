package kr.ac.kopo.sms.vo;

public class SmsVO {

	private String id;
	private String smsCode;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSmsCode() {
		return smsCode;
	}
	public void setSmsCode(String smsCode) {
		this.smsCode = smsCode;
	}
	@Override
	public String toString() {
		return "SmsVO [id=" + id + ", smsCode=" + smsCode + "]";
	}
	
}
