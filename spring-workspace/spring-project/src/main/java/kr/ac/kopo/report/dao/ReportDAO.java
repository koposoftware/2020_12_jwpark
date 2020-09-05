package kr.ac.kopo.report.dao;

import kr.ac.kopo.report.vo.ReportVO;

public interface ReportDAO {

	void insertReport(ReportVO report);
	void updateReport(ReportVO report);
}
