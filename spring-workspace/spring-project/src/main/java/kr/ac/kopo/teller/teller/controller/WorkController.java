package kr.ac.kopo.teller.teller.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.account.service.AccountService;
import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.service.UserService;
import kr.ac.kopo.client.user.vo.UserVO;

@RestController
public class WorkController {

	@Autowired
	private AccountService accountService;
	
	/*
	@GetMapping("/user/{userID}")
	public UserVO getUserInfo(@PathVariable("userID") String id) {
		
		return userService.getUserInfo(id);
		
	}
	*/
	public String fromCharCode(int... codePoints) {
	    return new String(codePoints, 0, codePoints.length);
	}
	
	public int charCodeAt(char c) {
        int x;
        return x = (int) c;
	}
	
	@GetMapping("/account/{userRegNo}")
	public List<AccountVO> getAccount(@PathVariable("userRegNo") String regNo) {
		
		UserVO user = new UserVO();
		user.setRegNo(regNo);
		
		List<AccountVO> accountList = accountService.selctAccountByUserRegNo(user);
		
		return accountList;
	}
	
	@PostMapping("/account/password")
	public void modifyPassword(AccountVO account) {
		
		account.setAccountNo(account.getAccountNo().replace("-", ""));
		
		System.out.println(account);
		accountService.updateAccountPassword(account);
		
	}
	
}
