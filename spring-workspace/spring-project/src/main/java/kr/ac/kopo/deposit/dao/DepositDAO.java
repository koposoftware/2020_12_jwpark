package kr.ac.kopo.deposit.dao;

import java.util.List;

import kr.ac.kopo.deposit.vo.DepositVO;

public interface DepositDAO {

	void insertDeposit(DepositVO deposit);
	List<DepositVO> selectDepositByRegNo(String regNo);
}
