package kr.ac.kopo.sms.dao;

import kr.ac.kopo.sms.vo.SmsVO;

public interface SmsDAO {

	String selectCodeById(String id);
	
	void insertSmsCode(SmsVO sms);
	
	void deleteSmsCode(String id);
}
