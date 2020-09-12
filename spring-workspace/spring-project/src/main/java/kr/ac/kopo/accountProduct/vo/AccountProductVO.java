package kr.ac.kopo.accountProduct.vo;

public class AccountProductVO {

	private String nameCode;
	private String maxInterest;
	private String leafletUrl;
	
	public String getNameCode() {
		return nameCode;
	}
	public void setNameCode(String nameCode) {
		this.nameCode = nameCode;
	}
	public String getMaxInterest() {
		return maxInterest;
	}
	public void setMaxInterest(String maxInterest) {
		this.maxInterest = maxInterest;
	}
	public String getLeafletUrl() {
		return leafletUrl;
	}
	public void setLeafletUrl(String leafletUrl) {
		this.leafletUrl = leafletUrl;
	}
	
	@Override
	public String toString() {
		return "accountProductVO [nameCode=" + nameCode + ", maxInterest=" + maxInterest + ", leafletUrl=" + leafletUrl
				+ "]";
	}
	
}
