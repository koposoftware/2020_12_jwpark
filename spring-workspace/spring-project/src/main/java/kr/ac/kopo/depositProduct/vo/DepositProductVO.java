package kr.ac.kopo.depositProduct.vo;

public class DepositProductVO {

	private String nameCode;
	private String maxInterest;
	private String minPeriod;
	private String maxPeriod;
	private String minAmmount;
	private String maxAmmount;
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
	public String getMinPeriod() {
		return minPeriod;
	}
	public void setMinPeriod(String minPeriod) {
		this.minPeriod = minPeriod;
	}
	public String getMaxPeriod() {
		return maxPeriod;
	}
	public void setMaxPeriod(String maxPeriod) {
		this.maxPeriod = maxPeriod;
	}
	public String getMinAmmount() {
		return minAmmount;
	}
	public void setMinAmmount(String minAmmount) {
		this.minAmmount = minAmmount;
	}
	public String getMaxAmmount() {
		return maxAmmount;
	}
	public void setMaxAmmount(String maxAmmount) {
		this.maxAmmount = maxAmmount;
	}
	public String getLeafletUrl() {
		return leafletUrl;
	}
	public void setLeafletUrl(String leafletUrl) {
		this.leafletUrl = leafletUrl;
	}
	
	@Override
	public String toString() {
		return "DepositProductVO [nameCode=" + nameCode + ", maxInterest=" + maxInterest + ", minPeriod=" + minPeriod
				+ ", maxPeriod=" + maxPeriod + ", minAmmount=" + minAmmount + ", maxAmmount=" + maxAmmount
				+ ", leafletUrl=" + leafletUrl + "]";
	}
	
}
