package kr.ac.kopo.deposit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.deposit.vo.DepositVO;

@Repository
public class DepositDAOImpl implements DepositDAO {

	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public void insertDeposit(DepositVO deposit) {
		
		session.insert("deposit.dao.DepositDAO.insertDeposit", deposit);
	}

	@Override
	public List<DepositVO> selectDepositByRegNo(String regNo) {
		
		List<DepositVO> list = session.selectList("deposit.dao.DepositDAO.selectDepositByRegNo", regNo);
		return list;
	}
	
	
}
