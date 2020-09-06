package kr.ac.kopo.reportDetail.service;

import java.util.List;

import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

public interface ReportDeatilService {

	List<ReportDetailVO> selectReportDetailByEmpNo(String empNo);
	int selectReportCountByEmpNo(ReportDetailVO reportDetail);
}
