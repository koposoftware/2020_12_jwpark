package kr.ac.kopo.depositProduct.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.depositProduct.vo.DepositProductVO;

@Repository
public class DepositProductDAOImpl implements DepositProductDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<DepositProductVO> selectAllProductList() {
		
		List<DepositProductVO> productList = sqlSession.selectList("depositProduct.dao.DepositProductDAO.selectAllDepositProduct");
		return productList;
	}

	@Override
	public DepositProductVO selectDepositProduct(String codeVal) {
		
		DepositProductVO depositProductVO = sqlSession.selectOne("depositProduct.dao.DepositProductDAO.selectDepositProduct", codeVal);
		return depositProductVO;
	}
	
}
