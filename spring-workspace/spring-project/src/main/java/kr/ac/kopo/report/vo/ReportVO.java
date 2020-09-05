package kr.ac.kopo.report.vo;

public class ReportVO {

	private int no;
	private String clientId;
	private String mainCategory;
	private String middleCategory;
	private String title;
	private String consultingReport;
	private String tellerEmpNo;
	private String consultingDate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
	}
	public String getMiddleCategory() {
		return middleCategory;
	}
	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getConsultingReport() {
		return consultingReport;
	}
	public void setConsultingReport(String consultingReport) {
		this.consultingReport = consultingReport;
	}
	public String getTellerEmpNo() {
		return tellerEmpNo;
	}
	public void setTellerEmpNo(String tellerEmpNo) {
		this.tellerEmpNo = tellerEmpNo;
	}
	public String getConsultingDate() {
		return consultingDate;
	}
	public void setConsultingDate(String consultingDate) {
		this.consultingDate = consultingDate;
	}
	@Override
	public String toString() {
		return "ReportVO [no=" + no + ", clientId=" + clientId + ", mainCategory=" + mainCategory + ", middleCategory="
				+ middleCategory + ", title=" + title + ", consultingReport=" + consultingReport + ", tellerEmpNo="
				+ tellerEmpNo + ", consultingDate=" + consultingDate + "]";
	}
	
}
