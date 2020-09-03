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
	public AccountVO selectWithdrawableBalanceByAccountNo(String accountNo) {
		
		AccountVO accountVO = sqlSession.selectOne("account.dao.AccountDAO.selectWithdrawableBalanceByAccountNo", accountNo);
		
		return accountVO;
	}

	@Override
	public String selectAccountNo(String accountNo) {
		
		return sqlSession.selectOne("account.dao.AccountDAO.selectAccountNo", accountNo);
	}

	@Override
	public int selectCodeVal(String codeVal) {
		
		return sqlSession.selectOne("account.dao.AccountDAO.selectCodeVal", codeVal);
	}

	@Override
	public void updateWithdrawable(AccountVO account) {
		
		sqlSession.update("account.dao.AccountDAO.updateWithdrawable", account);
	}

	@Override
	public void updateBalance(AccountVO account) {
		sqlSession.update("account.dao.AccountDAO.updateBalance", account);
		
	}

	@Override
	public String selectPasswordByAccountNo(AccountVO account) {
		
		return sqlSession.selectOne("account.dao.AccountDAO.selectPasswordByAccountNo", account);
	}
	
	
	
}
