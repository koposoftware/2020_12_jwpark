package kr.ac.kopo.account.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.vo.UserVO;

@Repository
public class AccountDAOImpl implements AccountDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<AccountVO> selctAccountByUserRegNo(UserVO user) {
		
		List<AccountVO> accountList = sqlSession.selectList("account.dao.AccountDAO.selectAccountByUserRegNo", user);
		return accountList;
	}

	@Override
	public void updateAccountPassword(AccountVO account) {
		sqlSession.update("account.dao.AccountDAO.updateAccountPassword", account);
	}

	@Override
	public void updateAccountLostReport(AccountVO account) {
		sqlSession.update("account.dao.AccountDAO.updateAccountLostReport", account);
	}

	@Override
	public void updateCancleAccountLostReport(AccountVO account) {
		sqlSession.update("account.dao.AccountDAO.updateCancleAccountLostReport", account); 
	}

	
	@Override
	public AccountVO selctAccountByPassword(String password) {
		
		AccountVO accountVO = sqlSession.selectOne("account.dao.AccountDAO.selectAccountByPassword", password);
		
		return accountVO;
	}

	@Override
	public AccountVO selectWithdrawableBalanceByAccountNo(String AccountNo) {
		
		AccountVO accountVO = sqlSession.selectOne("account.dao.AccountDAO.selectWithdrawableBalanceByAccountNo", AccountNo);
		
		return accountVO;
	}
	
}
