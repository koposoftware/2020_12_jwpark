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
	public List<ReportDetailVO> selectReportDetailByEmpNo(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByEmpNo", reportDetail);
		
		return list;
	}

	@Override
	public List<ReportDetailVO> selectReportCountByEmpNo(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportCountByEmpNo", reportDetail);
		
		return list;
	}

	@Override
	public List<ReportDetailVO> selectReportDetail() {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetail");
		
		return list;
	}

	@Override
	public List<ReportDetailVO> selectReportDetailByCategoryAndReportYMD(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByCategoryAndReportYMD", reportDetail);
		
		return list;
	}
	
	@Override
	public List<ReportDetailVO> selectReportDetailByCategory(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByCategory", reportDetail);
		
		return list;
	}
	
	@Override
	public List<ReportDetailVO> selectReportDetailByReportYMD(ReportDetailVO reportDetail) {
		
		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByReportYMD", reportDetail);
		
		return list;
	}
	
	@Override
	public List<ReportDetailVO> selectReportDetailByCategoryAndReportYMDUserID(ReportDetailVO reportDetail) {

		List<ReportDetailVO> list = session.selectList("reportDetail.dao.ReportDetailDAO.selectReportDetailByCategoryAndReportYMDUserID", reportDetail);
		
		return list;
	}

	@Override
	public String selectApiKey(String apiKey) {

		return session.selectOne("reportDetail.dao.ReportDetailDAO.selectApiKey", apiKey);
	}
	
}
