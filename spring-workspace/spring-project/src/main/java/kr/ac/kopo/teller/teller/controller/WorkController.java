package kr.ac.kopo.teller.teller.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
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
import kr.ac.kopo.saving.service.SavingService;
import kr.ac.kopo.saving.vo.SavingVO;
import kr.ac.kopo.savingProduct.service.SavingProductService;
import kr.ac.kopo.savingProduct.vo.SavingProductVO;
import kr.ac.kopo.sms.service.SmsService;
import kr.ac.kopo.sms.vo.SmsVO;

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
	@Autowired
	private SavingService savingService;
	@Autowired
	private SmsService smsService;
	
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
		
		System.out.println(deposit);
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
		account.setBalance(deposit.getDepositAmmount());
		
		System.out.println(account);
		accountService.updateBalance(account);
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
	
	@GetMapping("/saving/{regNo}")
	public List<SavingVO> selectSavingByRegNo(@PathVariable("regNo") String regNo) {
		
		return savingService.selectUserSaving(regNo);
	}

	@GetMapping("/savingProductOne/{productName}")
	public SavingProductVO getSavingProductOne(@PathVariable("productName")String codeVal) {
		
		SavingProductVO savingProduct = savingProductService.selectSavingProduct(codeVal);
		return savingProduct;
	}
	
	@Transactional
	@PostMapping("/saving")
	public void insertSaving(SavingVO saving) {
		
		System.out.println(saving);
		String randAccountNo = null;
		
		boolean b = false;
		
		//////////////////
		while(!b) {
			randAccountNo = makeRandomAccountNo();
			
			if(accountService.selectAccountNo(randAccountNo) == null) {
				b = true;
			}
		}
		
		saving.setAccountNo(randAccountNo);
		
		String interest = savingProductService.selectSavingProduct(saving.getNameCode()).getMaxInterest();
		int codeKey = accountService.selectCodeVal(saving.getNameCode());
		
		SimpleDateFormat format = new SimpleDateFormat ("yy-MM-dd");
		Calendar time = Calendar.getInstance();
		
		time.add(Calendar.MONTH, Integer.parseInt(saving.getExpiredDate()));
		
		String expired = format.format(time.getTime());
		
		saving.setExpiredDate(expired);
		saving.setInterest(interest);
		saving.setNameCode(String.valueOf(codeKey));
		
		savingService.insertSaving(saving);
		
		AccountVO account = new AccountVO();
		account.setAccountNo(saving.getRefAccountNo());
		account.setBalance(saving.getSavingAmmount());
		account.setWithdrawableBalance(saving.getSavingAmmount());
		
		//System.out.println(account);
		accountService.updateBalance(account);
		
	}
	
	@Transactional
	@PostMapping("/sendSMS")
	public String sendSMS(String receiver, HttpSession session) {
		
		// 6자리 인증 코드 생성 
		int rand = (int) (Math.random() * 899999) + 100000;
		
		String code = String.valueOf(rand);

		String id = ((UserVO)session.getAttribute("userVO")).getId();
		
		SmsVO sms = new SmsVO();
		sms.setId(id);
		sms.setSmsCode(code);
		
		System.out.println(sms);
		if(smsService.selectCodeById(id) != null) {
			smsService.deleteSmsCode(id);
		}
		
		smsService.insertSmsCode(sms);
		
		String hostname = "api.bluehouselab.com";
        String url = "https://"+hostname+"/smscenter/v1.0/sendsms";

        CredentialsProvider credsProvider = new BasicCredentialsProvider();
        credsProvider.setCredentials(
            new AuthScope(hostname, 443, AuthScope.ANY_REALM),
            new UsernamePasswordCredentials("hanaProject", "283c6d80ec5711ea8a440cc47a1fcfae")
            //new UsernamePasswordCredentials("hana_onepick", "ecc54adcedd311eaa4f10cc47a1fcfae")
        );

        // Create AuthCache instance
        AuthCache authCache = new BasicAuthCache();
        authCache.put(new HttpHost(hostname, 443, "https"), new BasicScheme());

        // Add AuthCache to the execution context
        HttpClientContext context = HttpClientContext.create();
        context.setCredentialsProvider(credsProvider);
        context.setAuthCache(authCache);

        DefaultHttpClient client = new DefaultHttpClient();

        try {
            HttpPost httpPost = new HttpPost(url);
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
            String json = "{\"sender\":\""+ "01050967347" +"\",\"receivers\":[\""+ receiver +"\"],\"content\":\""+ "하나화상창구 인증코드 [ " + code + " ] 본 문자를 화면에 입력해주세요."  +"\"}";
            //String json = "{\"sender\":\""+ "01092768500" +"\",\"receivers\":[\""+ receiver +"\"],\"content\":\""+ "청기와청기와감자탕"  +"\"}";
            //String json = "{\"sender\":\""+ "01099194276" +"\",\"receivers\":[\""+ receiver +"\"],\"content\":\""+ "오늘은 모임통장 회비를 보내는 날입니다"  +"\"}";

            StringEntity se = new StringEntity(json, "UTF-8");
            httpPost.setEntity(se);

            HttpResponse httpResponse = client.execute(httpPost, context);
            System.out.println(httpResponse.getStatusLine().getStatusCode());

            InputStream inputStream = httpResponse.getEntity().getContent();
            if(inputStream != null) {
                BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
                String line = "";
                while((line = bufferedReader.readLine()) != null)
                    System.out.println(line);
                inputStream.close();
            }
        } catch (Exception e) {
            System.err.println("Error: "+e.getLocalizedMessage());
        } finally {
            client.getConnectionManager().shutdown();
        }
		
        return "ok";
	} 
	
	@Transactional
	@PostMapping("/smsCheck")
	public boolean smsCheck(String code, HttpSession session) {
		
		boolean ret = false;
		String id = ((UserVO)session.getAttribute("userVO")).getId();
		String dbCode = smsService.selectCodeById(id);
		if( dbCode != null) {
			if(code.equals(dbCode)) {
				smsService.deleteSmsCode(id);
				ret = true;
			}
		}
		return ret;
	}
}
