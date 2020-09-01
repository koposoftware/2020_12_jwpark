package kr.ac.kopo.sms.service;

import kr.ac.kopo.sms.vo.SmsVO;

public interface SmsService {

	String selectCodeById(String id);
	
	void insertSmsCode(SmsVO sms);
	
	void deleteSmsCode(String id);
}
