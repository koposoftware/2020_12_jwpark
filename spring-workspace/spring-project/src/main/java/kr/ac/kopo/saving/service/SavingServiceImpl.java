package kr.ac.kopo.saving.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.saving.dao.SavingDAO;
import kr.ac.kopo.saving.vo.SavingVO;

@Service
public class SavingServiceImpl implements SavingService {

	@Autowired
	SavingDAO savingDAO;
	
	@Override
	public List<SavingVO> selectUserSaving(String regNo) {
		
		return savingDAO.selectUserSaving(regNo);
	}

	@Override
	public void insertSaving(SavingVO saving) {
		
		savingDAO.insertSaving(saving);
		
	}
	
}
