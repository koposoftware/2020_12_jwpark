package kr.ac.kopo.deposit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.deposit.dao.DepositDAO;
import kr.ac.kopo.deposit.vo.DepositVO;

@Service
public class DepositServiceImpl implements DepositService {

	@Autowired
	DepositDAO depositDAO;
	
	@Override
	public void insertDeposit(DepositVO deposit) {
		depositDAO.insertDeposit(deposit);
	}

	@Override
	public List<DepositVO> selectDepositByRegNo(String regNo) {
		
		return depositDAO.selectDepositByRegNo(regNo);
	}
	
}
