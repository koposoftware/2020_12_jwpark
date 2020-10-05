package kr.ac.kopo.teller.teller.controller;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.account.service.AccountService;
import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.accountProduct.service.AccountProductService;
import kr.ac.kopo.accountProduct.vo.AccountProductVO;
import kr.ac.kopo.client.user.service.UserService;
import kr.ac.kopo.client.user.vo.UserVO;
import kr.ac.kopo.deposit.service.DepositService;
import kr.ac.kopo.deposit.vo.DepositVO;
import kr.ac.kopo.depositProduct.service.DepositProductService;
import kr.ac.kopo.depositProduct.vo.DepositProductVO;
import kr.ac.kopo.elecFinanceUser.service.ElecFinanceUserService;
import kr.ac.kopo.elecFinanceUser.vo.ElecFinanceUserVO;
import kr.ac.kopo.logger.Log4j2;
import kr.ac.kopo.report.service.ReportService;
import kr.ac.kopo.saving.service.SavingService;
import kr.ac.kopo.saving.vo.SavingVO;
import kr.ac.kopo.savingProduct.service.SavingProductService;
import kr.ac.kopo.savingProduct.vo.SavingProductVO;
import kr.ac.kopo.sms.service.SmsService;
import kr.ac.kopo.sms.vo.SmsVO;
import net.sourceforge.tess4j.Tesseract;

@RestController
public class WorkController {

	@Autowired
	private AccountService accountService;
	@Autowired
	private AccountProductService accountProductService;
	@Autowired
	private DepositProductService depositProductService;
	@Autowired
	private DepositService depositService;
	@Autowired
	private SavingProductService savingProductService;
	@Autowired
	private SavingService savingService;
	@Autowired
	private ElecFinanceUserService elecFinanceUserService;
	@Autowired
	private SmsService smsService;
	@Autowired
	private UserService userService;
	@Autowired
	private Log4j2 log;
	
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
		
		System.out.println("예금 상품 이름 : " + codeVal);
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
		
		log.infoLog("deposit", "deposit insert");
		
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
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
				
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
		
		log.infoLog("deposit", "saving insert");
		
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
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
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
	
	@GetMapping("/elecFinance/{regNo}")
	public ElecFinanceUserVO selectElecFinanceUser(@PathVariable("regNo") String regNo) {
		
		return elecFinanceUserService.selectElecFinanceUser(regNo);
	}
	
	@PostMapping("/elecFinance/password")
	public void updateElecFinanceUserPassword(@RequestParam("regNo") String regNo, @RequestParam("password") String password) {
		
		ElecFinanceUserVO elecFinanceUser = new ElecFinanceUserVO();
		
		elecFinanceUser.setRegNo(regNo);
		elecFinanceUser.setPassword(password);
		
		elecFinanceUserService.updatePasswordByRegNo(elecFinanceUser);
	}
	
	@GetMapping("/elecFinance/id/{id}")
	public ElecFinanceUserVO selectElecFinanceUserID(@PathVariable("id") String id) {
		
		ElecFinanceUserVO elecFinanceUser = elecFinanceUserService.selectElecFinanceUserID(id);
		System.out.println(elecFinanceUser);
		
		return elecFinanceUser;
	}
	
	@Transactional
	@PostMapping("/elecFinance")
	public void insertElecFinanceUser(@RequestParam("id") String id, @RequestParam("password") String password, @RequestParam("refAccountNo") String refAccountNo, @RequestParam("regNo") String regNo, @RequestParam("tel") String tel) {
		
		ElecFinanceUserVO elecFinanceUser = new ElecFinanceUserVO();
		
		elecFinanceUser.setId(id);
		elecFinanceUser.setPassword(password);
		elecFinanceUser.setRefAccountNo(refAccountNo);
		elecFinanceUser.setRegNo(regNo);
		elecFinanceUser.setTel(tel);
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String date = format.format(time.getTime());
		elecFinanceUser.setRegDate(date);
		
		elecFinanceUserService.insertElecFinanceUser(elecFinanceUser);
		userService.updateElecFinanceStatus(regNo);
		accountService.updateElecFinanceStatus(refAccountNo);
		
	}

	public String saveFileAndDoOCR(MultipartFile file, String directoryPath, String id, String name) throws IOException {
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String sTime = format.format(time.getTime());
		
		//String saveFolder = "D:/hanaProject-workspace/spring-workspace/spring-project/src/main/webapp/resources/images/capturedID";
		// parent directory를 찾는다.
		File saveFile = new File(directoryPath, sTime + "_" + id + "_" + name + "_" + "idCard.png");
		
		String text = "";
		try {
			file.transferTo(saveFile);
			
			BufferedImage image = ImageIO.read(new File(directoryPath, sTime + "_" + id + "_" + name + "_" + "idCard.png"));
			
			int avgRGB = 0;
			int count = 0;
			/*
			for(int y = 0; y < image.getHeight(); y++) {
				for(int x = 0; x < image.getWidth(); x++) {
					Color colour = new Color(image.getRGB(x, y));
					
					int pointY = (int) (0.2126 * colour.getRed() + 0.7152 * colour.getGreen() + 0.0722 * colour.getBlue());
					
					//System.out.println(pointY);

					count++;
					avgRGB += pointY;
					
					//image.setRGB(x, y, new Color(pointY, pointY, pointY).getRGB());
				}
			}
			avgRGB = (int)((double)(avgRGB/count) * 0.9 );
			System.out.println(avgRGB);
			*/
			
			for(int y = 0; y < image.getHeight(); y++) {
				for(int x = 0; x < image.getWidth(); x++) {
					Color colour = new Color(image.getRGB(x, y));
					int pointY = (int) (0.2126 * colour.getRed() + 0.7152 * colour.getGreen() + 0.0722 * colour.getBlue());
					
					/*
					if(pointY > avgRGB) {
						pointY = 255;
					} else 
						pointY = 0;
					*/
					image.setRGB(x, y, new Color(pointY, pointY, pointY).getRGB());
				}
			}
			
			ImageIO.write(image, "png", new File(directoryPath, id + "_" + name + "_" + "id_grayScale.png"));
			
			Tesseract tesseract = new Tesseract(); 
			
			tesseract.setDatapath("C:/Program Files/Tesseract-OCR/tessdata"); 
			tesseract.setLanguage("kor");

			text = tesseract.doOCR(saveFile);
			//String text = tesseract.doOCR(f);
			System.out.println(text);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return text;
	}
	
	
	@PostMapping("/saveIDCardImage/{id}/{name}")
	public String saveImage(@RequestParam(value="file", required=true) MultipartFile [] file, @PathVariable("id") String id, @PathVariable("name") String name/*, HttpServletResponse hr*/) {
		
		//hr.setContentType("text/html;charset=UTF-8");
		
		String saveFolder = "D:/hanaProject-workspace/idCard";
		String text="";
		
		try {
			text = saveFileAndDoOCR(file[0], saveFolder, id, name);
			
			//PrintWriter out = hr.getWriter();
			//out.println(text);
			//Resource resource = new ClassPathResource("upload.png");
			//BufferedImage resizedImage = resize(resource.getInputStream(), 800, 600);
			//ImageIO.write(resizedImage, "jpg", new File(saveFolder + "/upload2.png"));
			
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return text;
	}
	
	@GetMapping("/accountProcutList")
	public List<AccountProductVO> selectAccountPRodcut() {
		
		List<AccountProductVO> list = accountProductService.selectAccountProduct(); 
		
		return list;
	}
	
	@Transactional
	@PostMapping("/account")
	public void insertAccount(AccountVO account) {
		
		log.infoLog("account", "account insert");
		
		String randAccountNo = null;
		boolean b = false;
		
		//////////////////
		while(!b) {
			randAccountNo = makeRandomAccountNo();
			
			if(accountService.selectAccountNo(randAccountNo) == null) {
				b = true;
			}
		}
		
		account.setAccountNo(randAccountNo);
		System.out.println(account);
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String now = format.format(time.getTime());
		
		account.setRegDate(now);
		account.setRecentlyUseDate(now);
		
		accountService.insertAccount(account);		
	}
	
	@Transactional
	@PostMapping("/convertAccount")
	public void convertAccount(AccountVO account) {
		
		log.infoLog("account", "account update");
		System.out.println(account);
		
		accountService.updateAccountNameCode(account);		
	}
}
