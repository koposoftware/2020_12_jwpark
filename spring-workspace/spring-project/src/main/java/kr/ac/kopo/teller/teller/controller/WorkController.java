package kr.ac.kopo.teller.teller.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
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
import kr.ac.kopo.deposit.service.DepositService;
import kr.ac.kopo.deposit.vo.DepositVO;
import kr.ac.kopo.depositProduct.service.DepositProductService;
import kr.ac.kopo.depositProduct.vo.DepositProductVO;
import kr.ac.kopo.savingProduct.service.SavingProductService;
import kr.ac.kopo.savingProduct.vo.SavingProductVO;

@RestController
public class WorkController {

	@Autowired
	private AccountService accountService;
	@Autowired
	private DepositProductService depositProductService;
	@Autowired
	private DepositService depositService;
	@Autowired
	private SavingProductService savingProductService;
	
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
	
	private String makeRandomAccountNo() {
		
		Random r = new Random();
		
		int front = r.nextInt(900) + 100;
		int middle = r.nextInt(900000) + 100000;
		int end = r.nextInt(90000) + 10000;
		
		String randAccountNo = String.valueOf(front) + String.valueOf(middle) + String.valueOf(end);
		
		return randAccountNo;
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
	
	@GetMapping("/account/withDrawable/{accountNo}")
	public AccountVO selectWithdrawableBalanceByAccountNo(@PathVariable("accountNo") String accountNo) {
		
		accountNo = accountNo.replace("-", "");
		
		return accountService.selectWithdrawableBalanceByAccountNo(accountNo);
	}
	
	@Transactional
	@PostMapping("/deposit")
	public void insertDeposit(DepositVO deposit) {
		
		String randAccountNo = null;
		
		boolean b = false;
		
		//////////////////
		while(!b) {
			randAccountNo = makeRandomAccountNo();
			
			if(accountService.selectAccountNo(randAccountNo) == null) {
				b = true;
			}
		}
		
		deposit.setAccountNo(randAccountNo);
		
		//System.out.println(deposit);
		String interest = depositProductService.selectDepositProduct(deposit.getNameCode()).getMaxInterest();
		int codeKey = accountService.selectCodeVal(deposit.getNameCode());
		
		SimpleDateFormat format = new SimpleDateFormat ("yy-MM-dd");
				
		Calendar time = Calendar.getInstance();
		
		time.add(Calendar.MONTH, Integer.parseInt(deposit.getExpiredDate()));
		String expired = format.format(time.getTime());
		
		deposit.setExpiredDate(expired);
		deposit.setInterest(interest);
		deposit.setNameCode(String.valueOf(codeKey));
		
		//System.out.println(deposit);
		
		depositService.insertDeposit(deposit);
		AccountVO account = new AccountVO();
		account.setAccountNo(deposit.getRefAccountNo());
		account.setWithdrawableBalance(deposit.getDepositAmmount());
		
		System.out.println(account);
		accountService.updateWithdrawable(account);
	}
	
	@GetMapping("/deposit/{regNo}")
	public List<DepositVO> selectDepositByRegNo(@PathVariable("regNo") String regNo) {
		
		return depositService.selectDepositByRegNo(regNo);
	}
	
	@GetMapping("/savingProducts")
	public List<SavingProductVO> getSavingProduct() {
		List<SavingProductVO> list = savingProductService.selectAllSavingProduct();
		return list;
	}
	
}
