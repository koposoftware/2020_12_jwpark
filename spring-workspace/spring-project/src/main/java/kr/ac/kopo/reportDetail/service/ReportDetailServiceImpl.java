package kr.ac.kopo.reportDetail.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.reportDetail.dao.ReportDetailDAO;
import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

@Service
public class ReportDetailServiceImpl implements ReportDeatilService{

	@Autowired
	ReportDetailDAO reportDetailDAO;
	
	@Override
	public List<ReportDetailVO> selectReportDetailByEmpNo(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportDetailByEmpNo(reportDetail);
	}

	@Override
	public int selectReportCountByEmpNo(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportCountByEmpNo(reportDetail).size();
	}

	@Override
	public List<ReportDetailVO> selectReportDetail() {
		
		return reportDetailDAO.selectReportDetail();
	}

	@Override
	public List<ReportDetailVO> selectReportDetailByCategoryAndReportYMD(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportDetailByCategoryAndReportYMD(reportDetail);
	}
	
	@Override
	public List<ReportDetailVO> selectReportDetailByReportYMD(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportDetailByReportYMD(reportDetail);
	}
	
	@Override
	public List<ReportDetailVO> selectReportDetailByCategory(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportDetailByCategory(reportDetail);
	}

	@Override
	public String selectApiKey(String apiKey) {
		
		return reportDetailDAO.selectApiKey(apiKey);
	}
	
	
}
