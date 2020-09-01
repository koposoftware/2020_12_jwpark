package kr.ac.kopo.savingProduct.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.savingProduct.vo.SavingProductVO;

@Repository
public class SavingProductDAOImpl implements SavingProductDAO {

	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public List<SavingProductVO> selectAllSavingProduct() {
		
		List<SavingProductVO> list = session.selectList("savingProduct.dao.SavingProductDAO.selectAllSavingProduct");
		
		return list;
	}

	@Override
	public SavingProductVO selectSavingProduct(String codeVal) {
		
		SavingProductVO savingProduct = session.selectOne("savingProduct.dao.SavingProductDAO.selectSavingProduct", codeVal);
		
		return savingProduct;
	}
	
}
