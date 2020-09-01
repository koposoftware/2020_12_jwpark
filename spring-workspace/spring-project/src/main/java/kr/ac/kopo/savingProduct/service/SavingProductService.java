package kr.ac.kopo.savingProduct.service;

import java.util.List;

import kr.ac.kopo.savingProduct.vo.SavingProductVO;

public interface SavingProductService {

	List<SavingProductVO> selectAllSavingProduct();
}
