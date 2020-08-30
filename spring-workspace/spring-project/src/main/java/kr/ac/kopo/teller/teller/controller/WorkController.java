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
import kr.ac.kopo.depositProduct.service.DepositProductService;
import kr.ac.kopo.depositProduct.vo.DepositProductVO;

@RestController
public class WorkController {

	@Autowired
	private AccountService accountService;
	@Autowired
	private DepositProductService depositProductService;
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
	
	@GetMapping("/account/lostReport/{lostAccount}")
	public void lostReport(@PathVariable("lostAccount") String accountNo) {
		
		AccountVO account = new AccountVO();
		account.setAccountNo(accountNo.replace("-", ""));
		System.out.println(account);
		accountService.updateAccountLostReport(account);
	}
	
	@GetMapping("/account/cancleLostReport/{lostAccount}")
	public void cancleLostReport(@PathVariable("lostAccount") String accountNo) {
		
		AccountVO account = new AccountVO();
		account.setAccountNo(accountNo.replace("-", ""));
		System.out.println(account);
		accountService.updateCancleAccountLostReport(account);
	}
	
	@PostMapping("/account/password/{accountNo}")
	public boolean checkPassword(@PathVariable("accountNo") String accountNo, @RequestParam("password") String password) {
		
		return accountService.checkAccountNoByPassword(accountNo, password);
	}
	
	@GetMapping("/depositProducts")
	public List<DepositProductVO> getDepositProduct() {
		List<DepositProductVO> list = depositProductService.selectAllProductList();
		return list;
	}
	
	@GetMapping("/depositProductOne/{productName}")
	public DepositProductVO getDepositProductOne(@PathVariable("productName")String codeVal) {
		
		DepositProductVO depositProduct = depositProductService.selectDepositProduct(codeVal);
		return depositProduct;
	}
	
}
