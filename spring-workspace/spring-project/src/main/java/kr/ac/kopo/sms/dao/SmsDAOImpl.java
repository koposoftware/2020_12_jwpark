package kr.ac.kopo.sms.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.sms.vo.SmsVO;

@Repository
public class SmsDAOImpl implements SmsDAO {

	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public String selectCodeById(String id) {
		
		return session.selectOne("sms.dao.SmsDAO.selectCodeById", id);
	}

	@Override
	public void insertSmsCode(SmsVO sms) {
		
		session.insert("sms.dao.SmsDAO.insertSmsCode", sms);
	}

	@Override
	public void deleteSmsCode(String id) {
		
		session.delete("sms.dao.SmsDAO.deleteSmsCode", id);
	}

}
