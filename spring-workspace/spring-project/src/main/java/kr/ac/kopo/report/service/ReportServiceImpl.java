package kr.ac.kopo.report.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.report.dao.ReportDAO;
import kr.ac.kopo.report.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	ReportDAO reportDAO;
	
	@Override
	public void insertReport(ReportVO report) {
		
		reportDAO.insertReport(report);
	}

	@Override
	public void updateReport(ReportVO report) {
	
		reportDAO.updateReport(report);
	}

	
}
