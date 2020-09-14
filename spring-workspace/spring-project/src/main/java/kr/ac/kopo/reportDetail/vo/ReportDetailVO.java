package kr.ac.kopo.reportDetail.vo;

public class ReportDetailVO {

	private String id;
	private String name;
	private String birth;
	private String mainCategory;
	private String middleCategory;
	private String title;
	private String consultingReport;
	private String adminName;
	private String empNo;
	private String channel;
	private String reportYMD;
	private String reportYMD2;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	public String getReportYMD() {
		return reportYMD;
	}
	public void setReportYMD(String reportYMD) {
		this.reportYMD = reportYMD;
	}
	public String getReportYMD2() {
		return reportYMD2;
	}
	public void setReportYMD2(String reportYMD2) {
		this.reportYMD2 = reportYMD2;
	}
	@Override
	public String toString() {
		return "ReportDetailVO [id=" + id + ", name=" + name + ", birth=" + birth + ", mainCategory=" + mainCategory
				+ ", middleCategory=" + middleCategory + ", title=" + title + ", consultingReport=" + consultingReport
				+ ", adminName=" + adminName + ", empNo=" + empNo + ", channel=" + channel + ", reportYMD=" + reportYMD
				+ ", reportYMD2=" + reportYMD2 + "]";
	}
	
	
}
