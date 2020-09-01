package kr.ac.kopo.savingProduct.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.savingProduct.dao.SavingProductDAO;
import kr.ac.kopo.savingProduct.vo.SavingProductVO;

@Service
public class SavingProductServiceImpl implements SavingProductService {

	@Autowired
	SavingProductDAO savingProductDAO;
	
	@Override
	public List<SavingProductVO> selectAllSavingProduct() {
		
		return savingProductDAO.selectAllSavingProduct();
	}

	@Override
	public SavingProductVO selectSavingProduct(String codeVal) {
		
		return savingProductDAO.selectSavingProduct(codeVal);
	}
	
}
