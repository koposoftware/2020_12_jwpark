package kr.ac.kopo.savingProduct.vo;

public class SavingProductVO {

	private String nameCode;
	private String maxInterest;
	private int minPeriod;
	private int maxPeriod;
	private int minEntryAmmount;
	private int maxEntryAmmount;
	private int minSavingAmmount;
	private int maxSavingAmmount;
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
	public int getMinEntryAmmount() {
		return minEntryAmmount;
	}
	public void setMinEntryAmmount(int minEntryAmmount) {
		this.minEntryAmmount = minEntryAmmount;
	}
	public int getMaxEntryAmmount() {
		return maxEntryAmmount;
	}
	public void setMaxEntryAmmount(int maxEntryAmmount) {
		this.maxEntryAmmount = maxEntryAmmount;
	}
	public int getMinSavingAmmount() {
		return minSavingAmmount;
	}
	public void setMinSavingAmmount(int minSavingAmmount) {
		this.minSavingAmmount = minSavingAmmount;
	}
	public int getMaxSavingAmmount() {
		return maxSavingAmmount;
	}
	public void setMaxSavingAmmount(int maxSavingAmmount) {
		this.maxSavingAmmount = maxSavingAmmount;
	}
	public String getLeafletUrl() {
		return leafletUrl;
	}
	public void setLeafletUrl(String reafletUrl) {
		this.leafletUrl = reafletUrl;
	}
	
	@Override
	public String toString() {
		return "SavingProductVO [nameCode=" + nameCode + ", maxInterest=" + maxInterest + ", minPeriod=" + minPeriod
				+ ", maxPeriod=" + maxPeriod + ", minEntryAmmount=" + minEntryAmmount + ", maxEntryAmmount="
				+ maxEntryAmmount + ", minSavingAmmount=" + minSavingAmmount + ", maxSavingAmmount=" + maxSavingAmmount
				+ ", leafletUrl=" + leafletUrl + "]";
	}
	
}
