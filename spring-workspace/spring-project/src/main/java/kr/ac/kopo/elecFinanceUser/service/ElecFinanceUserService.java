package kr.ac.kopo.elecFinanceUser.service;

import kr.ac.kopo.elecFinanceUser.vo.ElecFinanceUserVO;

public interface ElecFinanceUserService {

	void insertElecFinanceUser(ElecFinanceUserVO elecFinanceUser);
	void updatePasswordByRegNo(ElecFinanceUserVO elecFinanceUser);
	
	ElecFinanceUserVO selectElecFinanceUser(String regNo);
}
