package kr.ac.kopo.sms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.sms.dao.SmsDAO;
import kr.ac.kopo.sms.vo.SmsVO;

@Service
public class SmsServiceImpl implements SmsService {

	@Autowired
	public SmsDAO smsDAO;
	
	@Override
	public String selectCodeById(String id) {
		
		return smsDAO.selectCodeById(id);
	}

	@Override
	public void insertSmsCode(SmsVO sms) {
		
		smsDAO.insertSmsCode(sms);
	}

	@Override
	public void deleteSmsCode(String id) {
		
		smsDAO.deleteSmsCode(id);
	}

	
}
