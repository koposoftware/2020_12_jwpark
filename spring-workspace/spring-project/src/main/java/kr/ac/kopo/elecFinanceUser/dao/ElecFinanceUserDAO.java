package kr.ac.kopo.elecFinanceUser.dao;

import kr.ac.kopo.elecFinanceUser.vo.ElecFinanceUserVO;

public interface ElecFinanceUserDAO {

	void insertElecFinanceUser(ElecFinanceUserVO elecFinanceUser);
	
	void updatePasswordByRegNo(ElecFinanceUserVO elecFinanceUser);
	
	ElecFinanceUserVO selectElecFinanceUser(String regNo);
	
	ElecFinanceUserVO selectElecFinanceUserID(String id);
	
}
