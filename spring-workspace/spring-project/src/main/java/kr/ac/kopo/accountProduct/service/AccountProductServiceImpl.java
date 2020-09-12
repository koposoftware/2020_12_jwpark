package kr.ac.kopo.accountProduct.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.accountProduct.dao.AccountProductDAO;
import kr.ac.kopo.accountProduct.vo.AccountProductVO;

@Service
public class AccountProductServiceImpl implements AccountProductService {

	@Autowired
	AccountProductDAO accountProductDAO;
	
	@Override
	public List<AccountProductVO> selectAccountProduct() {
		
		return accountProductDAO.selectAccountProduct();
	}
	
}
