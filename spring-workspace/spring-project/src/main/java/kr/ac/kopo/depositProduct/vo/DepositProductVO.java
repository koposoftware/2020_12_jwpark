package kr.ac.kopo.depositProduct.vo;

public class DepositProductVO {

	private String nameCode;
	private String maxInterest;
	private int minPeriod;
	private int maxPeriod;
	private int minAmmount;
	private int maxAmmount;
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
	public int getMinPeriod() {
		return minPeriod;
	}
	public void setMinPeriod(int minPeriod) {
		this.minPeriod = minPeriod;
	}
	public int getMaxPeriod() {
		return maxPeriod;
	}
	public void setMaxPeriod(int maxPeriod) {
		this.maxPeriod = maxPeriod;
	}
	public int getMinAmmount() {
		return minAmmount;
	}
	public void setMinAmmount(int minAmmount) {
		this.minAmmount = minAmmount;
	}
	public int getMaxAmmount() {
		return maxAmmount;
	}
	public void setMaxAmmount(int maxAmmount) {
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
