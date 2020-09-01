package kr.ac.kopo.savingProduct.dao;

import java.util.List;

import kr.ac.kopo.savingProduct.vo.SavingProductVO;

public interface SavingProductDAO {

	List<SavingProductVO> selectAllSavingProduct();
	SavingProductVO selectSavingProduct(String codeVal);
}
