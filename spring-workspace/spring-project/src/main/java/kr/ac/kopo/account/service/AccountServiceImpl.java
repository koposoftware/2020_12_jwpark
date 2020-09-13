package kr.ac.kopo.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.account.dao.AccountDAO;
import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.vo.UserVO;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	AccountDAO accountDAO;

	@Override
	public List<AccountVO> selctAccountByUserRegNo(UserVO user) {
		
		List<AccountVO> accountVO = accountDAO.selctAccountByUserRegNo(user);
		
		return accountVO;
	}

	@Override
	public void updateAccountPassword(AccountVO account) {
		
		accountDAO.updateAccountPassword(account);
	}

	@Override
	public void updateAccountLostReport(AccountVO account) {
		
		accountDAO.updateAccountLostReport(account);
		
	}

	@Override
	public void updateCancleAccountLostReport(AccountVO account) {
		
		accountDAO.updateCancleAccountLostReport(account);
	}

	@Override
	public boolean checkAccountNoByPassword(String accountNo, String password) {
		
		boolean bool;
		AccountVO account = new AccountVO();
		account.setAccountNo(accountNo);
		account.setPassword(password);
		String an = accountDAO.selectPasswordByAccountNo(account);
		
		//AccountVO account = accountDAO.selctAccountByPassword(password);
		
		if(an != null) {
			if(an.equals(accountNo)) {
				bool = true;
			} else {
				bool = false;
			}
		} else {
			bool = false;
		}

		return bool;
	}

	@Override
	public AccountVO selectWithdrawableBalanceByAccountNo(String accountNo) {
		
		AccountVO account = accountDAO.selectWithdrawableBalanceByAccountNo(accountNo);
		
		return account;
	}

	@Override
	public String selectAccountNo(String AccountNo) {
		
		return accountDAO.selectAccountNo(AccountNo);
	}

	@Override
	public int selectCodeVal(String codeVal) {
		
		return accountDAO.selectCodeVal(codeVal);
	}

	@Override
	public void updateWithdrawable(AccountVO account) {
		
		accountDAO.updateWithdrawable(account);
	}

	@Override
	public void updateBalance(AccountVO account) {
		
		accountDAO.updateBalance(account);
	}

	@Override
	public String selectPasswordByAccountNo(AccountVO account) {
		

		return accountDAO.selectPasswordByAccountNo(account);
	}

	@Override
	public void updateElecFinanceStatus(String accountNo) {
		
		accountDAO.updateElecFinanceStatus(accountNo);
	}

	@Override
	public void insertAccount(AccountVO account) {
		
		accountDAO.insertAccount(account);
	}

	@Override
	public void updateAccountNameCode(AccountVO account) {
		
		accountDAO.updateAccountNameCode(account);
	}
	
	
	
}
