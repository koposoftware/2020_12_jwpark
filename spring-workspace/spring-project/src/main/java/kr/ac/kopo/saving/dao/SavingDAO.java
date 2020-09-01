package kr.ac.kopo.saving.dao;

import java.util.List;

import kr.ac.kopo.saving.vo.SavingVO;

public interface SavingDAO {

	List<SavingVO> selectUserSaving(String regNo);
	void insertSaving(SavingVO saving);
	
	
}
