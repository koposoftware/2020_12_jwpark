package kr.ac.kopo.accountProduct.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.accountProduct.vo.AccountProductVO;

@Repository
public class AccountProductDAOImpl implements AccountProductDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<AccountProductVO> selectAccountProduct() {
		
		List<AccountProductVO> list =  sqlSession.selectList("accoundProduct.dao.AccountProductDAO.selectAccountProduct");
		return list;
	}
	
}
