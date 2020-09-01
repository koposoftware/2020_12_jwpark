package kr.ac.kopo.saving.service;

import java.util.List;

import kr.ac.kopo.saving.vo.SavingVO;

public interface SavingService {

	List<SavingVO> selectUserSaving(String regNo);
	
	void insertSaving(SavingVO saving);
}
