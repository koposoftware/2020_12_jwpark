package kr.ac.kopo.elecFinanceUser.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.elecFinanceUser.vo.ElecFinanceUserVO;

@Repository
public class ElecFinanceUserDAOImpl implements ElecFinanceUserDAO {

	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public void insertElecFinanceUser(ElecFinanceUserVO elecFinanceUser) {
		
		session.insert("elecFinanceUser.dao.ElecFinanceUserDAO.insertElecFinanceUser", elecFinanceUser);
	}

	@Override
	public void updatePasswordByRegNo(ElecFinanceUserVO elecFinanceUser) {
		
		session.update("updatePasswordByRegNo", elecFinanceUser);
	}

	@Override
	public ElecFinanceUserVO selectElecFinanceUser(String regNo) {
		
		return session.selectOne("selectElecFinanceUser", regNo);
	}

	@Override
	public ElecFinanceUserVO selectElecFinanceUserID(String id) {
		
		return session.selectOne("selectElecFinanceUserID", id);
	}
	
}
