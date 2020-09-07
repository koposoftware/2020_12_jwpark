package kr.ac.kopo.elecFinanceUser.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.elecFinanceUser.dao.ElecFinanceUserDAO;
import kr.ac.kopo.elecFinanceUser.vo.ElecFinanceUserVO;

@Service
public class ElecFinanceUserServiceImpl implements ElecFinanceUserService{

	@Autowired
	ElecFinanceUserDAO elecFinanceUserDAO;
	
	@Override
	public void insertElecFinanceUser(ElecFinanceUserVO elecFinanceUser) {
		
		elecFinanceUserDAO.insertElecFinanceUser(elecFinanceUser);
	}

	@Override
	public void updatePasswordByRegNo(ElecFinanceUserVO elecFinanceUser) {
		
		elecFinanceUserDAO.updatePasswordByRegNo(elecFinanceUser);
	}

	@Override
	public ElecFinanceUserVO selectElecFinanceUser(String regNo) {
		
		return elecFinanceUserDAO.selectElecFinanceUser(regNo);
	}
	
}
