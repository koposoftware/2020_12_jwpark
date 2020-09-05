package kr.ac.kopo.report.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.report.vo.ReportVO;

@Repository
public class ReportDAOImpl implements ReportDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public void insertReport(ReportVO report) {
		
		session.insert("report.dao.ReportDAO.insertReport", report);
	}

	@Override
	public void updateReport(ReportVO report) {
		
		session.update("report.dao.ReportDAO.updateReport", report);
	}

}
