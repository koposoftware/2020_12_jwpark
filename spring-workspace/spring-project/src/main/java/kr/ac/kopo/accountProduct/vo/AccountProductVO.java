package kr.ac.kopo.accountProduct.vo;

public class AccountProductVO {

	private String nameCode;
	private String maxInterest;
	private String leafletUrl;
	private String faceToFace;
	
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
	public String getFaceToFace() {
		return faceToFace;
	}
	public void setFaceToFace(String faceToFace) {
		this.faceToFace = faceToFace;
	}
	@Override
	public String toString() {
		return "AccountProductVO [nameCode=" + nameCode + ", maxInterest=" + maxInterest + ", leafletUrl=" + leafletUrl
				+ ", faceToFace=" + faceToFace + "]";
	}
	
}
