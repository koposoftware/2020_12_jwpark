package kr.ac.kopo.reportDetail.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

@Repository
public class ReportDetailDAOImpl implements ReportDetailDAO {

	@Autowired
	SqlSessionTemplate session;

	@Override
	public List<ReportDetailVO> selectReportDetailByEmpNo(String empNo) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByEmpNo", empNo);
		
		return list;
	}

	@Override
	public List<ReportDetailVO> selectReportCountByEmpNo(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByEmpNo", reportDetail);
		
		return list;
	}
	
	
	
}
