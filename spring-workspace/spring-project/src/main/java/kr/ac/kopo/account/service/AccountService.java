package kr.ac.kopo.account.service;

import java.util.List;

import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.vo.UserVO;

public interface AccountService {

	List<AccountVO> selctAccountByUserRegNo(UserVO user);
	void updateAccountPassword(AccountVO account);
	void updateAccountLostReport(AccountVO account);
	void updateCancleAccountLostReport(AccountVO account);
	
	boolean checkAccountNoByPassword(String accountNo, String password);
	AccountVO selectWithdrawableBalanceByAccountNo(String accountNo);
	
	String selectAccountNo(String AccountNo);
	int selectCodeVal(String codeVal);
	
	void updateWithdrawable(AccountVO account);
	void updateBalance(AccountVO account);
	
	String selectPasswordByAccountNo(AccountVO account);
	
	void updateElecFinanceStatus(String accountNo);
	void insertAccount(AccountVO account);
	
}
