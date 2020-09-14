package kr.ac.kopo.reportDetail.dao;

import java.util.List;

import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

public interface ReportDetailDAO {

	List<ReportDetailVO> selectReportDetailByEmpNo(ReportDetailVO reportDetail);
	List<ReportDetailVO> selectReportCountByEmpNo(ReportDetailVO reportDetail);
	
	List<ReportDetailVO> selectReportDetail();
	List<ReportDetailVO> selectReportDetailByReportYMD(ReportDetailVO reportDetail);
	
	String selectApiKey(String apiKey);
}
