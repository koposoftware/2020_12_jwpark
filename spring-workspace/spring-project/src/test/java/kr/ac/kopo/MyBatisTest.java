package kr.ac.kopo;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.ac.kopo.account.dao.AccountDAO;
import kr.ac.kopo.account.dao.AccountDAOImpl;
import kr.ac.kopo.account.vo.AccountVO;
import kr.ac.kopo.client.user.vo.UserVO;
import kr.ac.kopo.depositProduct.vo.DepositProductVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class MyBatisTest {

	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Ignore
	@Test
	public void dsTest() throws Exception {
		assertNotNull(ds);
	}

	@Ignore
	@Test
	public void sqlSessionTest() throws Exception {
		assertNotNull(session);
	}
	
	@Ignore
	@Test
	public void 유저데이터조회() throws Exception {
		
		UserVO user = new UserVO();
		user.setId("hanauser1");
		user.setPassword("hanauser1");
		
		user = session.selectOne("user.dao.UserDAO.login", user);
		
		System.out.println(user);
	}
	
	@Ignore
	@Test
	public void 계좌데이터조회() throws Exception {
		
		UserVO user = new UserVO();
		user.setRegNo("9403221234567");
		
		AccountDAO ad = new AccountDAOImpl();
		
		List<AccountVO> accountList = session.selectList("account.dao.AccountDAO.selctAccountByUserRegNo", user);
		
		//List<AccountVO> accountList = ad.selctAccountByUserRegNo(user);
		System.out.println(accountList);
		
	}
	
	@Ignore
	@Test
	public void 계좌비밀번호변경() throws Exception {
		
		AccountVO account = new AccountVO();
		account.setAccountNo("45891034853507");
		account.setPassword("5555");
		
		session.update("account.dao.AccountDAO.updateAccountPassword", account);
		
		//List<AccountVO> accountList = ad.selctAccountByUserRegNo(user);
	}
	
	@Ignore
	@Test
	public void 예금상품목록조회() throws Exception {
		
		List<DepositProductVO> list = session.selectList("depositProduct.dao.DepositProductDAO.selectAllDepositProduct"); 
		
		System.out.println(list);
		
	}
	
	@Ignore
	@Test
	public void 예금상품조회() throws Exception {
		
		DepositProductVO depositProductVO = session.selectOne("depositProduct.dao.DepositProductDAO.selectDepositProduct", "하나머니세상 정기예금"); 
		System.out.println(depositProductVO);
	}
	
	@Ignore
	@Test
	public void 계좌비밀번호확인() throws Exception {
		
		AccountVO account = session.selectOne("account.dao.AccountDAO.selectAccountByPassword", "1123"); 
		System.out.println(account);
	}
	
}
