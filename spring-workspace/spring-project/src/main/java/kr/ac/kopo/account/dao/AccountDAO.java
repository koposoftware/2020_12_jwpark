package kr.ac.kopo.account.dao;

import java.util.List;

import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.vo.UserVO;

public interface AccountDAO {

	List<AccountVO> selctAccountByUserRegNo(UserVO user);
	void updateAccountPassword(AccountVO account);
	void updateAccountLostReport(AccountVO account);
	void updateCancleAccountLostReport(AccountVO account);
	
	
	AccountVO selctAccountByPassword(String password);
}
