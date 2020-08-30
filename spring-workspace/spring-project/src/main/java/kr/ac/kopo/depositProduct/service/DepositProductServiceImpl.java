package kr.ac.kopo.depositProduct.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.depositProduct.dao.DepositProductDAO;
import kr.ac.kopo.depositProduct.vo.DepositProductVO;

@Service
public class DepositProductServiceImpl implements DepositProductService{

	@Autowired
	DepositProductDAO depositProductDAO;
	
	@Override
	public List<DepositProductVO> selectAllProductList() {
		
		return depositProductDAO.selectAllProductList();
	}

	@Override
	public DepositProductVO selectDepositProduct(String codeVal) {
		
		return depositProductDAO.selectDepositProduct(codeVal);
	}
	
}
