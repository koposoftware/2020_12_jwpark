package kr.ac.kopo.reportDetail.service;

import java.util.List;

import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

public interface ReportDeatilService {

	List<ReportDetailVO> selectReportDetailByEmpNo(ReportDetailVO reportDetail);
	int selectReportCountByEmpNo(ReportDetailVO reportDetail);
	List<ReportDetailVO> selectReportDetail();
	List<ReportDetailVO> selectReportDetailByReportYMD(ReportDetailVO reportDetail);
	List<ReportDetailVO> selectReportDetailByCategoryAndReportYMD(ReportDetailVO reportDetail);
	List<ReportDetailVO> selectReportDetailByCategory(ReportDetailVO reportDetail);
	
	String selectApiKey(String apiKey);
}
