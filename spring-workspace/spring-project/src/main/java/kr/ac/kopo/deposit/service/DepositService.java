package kr.ac.kopo.deposit.service;

import java.util.List;

import kr.ac.kopo.deposit.vo.DepositVO;

public interface DepositService {

	void insertDeposit(DepositVO deposit);
	List<DepositVO> selectDepositByRegNo(String regNo);
}
