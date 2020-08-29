package kr.ac.kopo.teller.teller.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.teller.teller.vo.TellerVO;

@Repository
public class TellerDAOImpl implements TellerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public TellerVO login(TellerVO teller) {
		
		TellerVO tellerVO = sqlSession.selectOne("teller.teller.dao.TellerDAO.login", teller);
		
		return tellerVO;	
	}
	
}
