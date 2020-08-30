package kr.ac.kopo.depositProduct.dao;

import java.util.List;

import kr.ac.kopo.depositProduct.vo.DepositProductVO;

public interface DepositProductDAO {

	List<DepositProductVO> selectAllProductList();
	DepositProductVO selectDepositProduct(String codeVal);
}
