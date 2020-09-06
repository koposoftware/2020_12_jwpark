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
	public List<ReportDetailVO> selectReportDetailByEmpNo(String empNo) {
		
		return reportDetailDAO.selectReportDetailByEmpNo(empNo);
	}

	@Override
	public int selectReportCountByEmpNo(ReportDetailVO reportDetail) {
		
		return reportDetailDAO.selectReportCountByEmpNo(reportDetail).size();
	}
	
}
