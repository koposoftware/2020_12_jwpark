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
	
}
