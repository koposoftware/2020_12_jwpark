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
	private String empno;
	private String consultingChannel;
	private String reportYmd;
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
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getConsultingChannel() {
		return consultingChannel;
	}
	public void setConsultingChannel(String consultingChannel) {
		this.consultingChannel = consultingChannel;
	}
	public String getReportYmd() {
		return reportYmd;
	}
	public void setReportYmd(String reportYmd) {
		this.reportYmd = reportYmd;
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
				+ ", adminName=" + adminName + ", empno=" + empno + ", consultingChannel=" + consultingChannel
				+ ", reportYmd=" + reportYmd + ", reportYMD2=" + reportYMD2 + "]";
	}
	
	
}
