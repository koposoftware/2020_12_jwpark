package kr.ac.kopo.depositProduct.service;

import java.util.List;

import kr.ac.kopo.depositProduct.vo.DepositProductVO;

public interface DepositProductService {
	
	List<DepositProductVO> selectAllProductList();
	DepositProductVO selectDepositProduct(String codeVal);
}
