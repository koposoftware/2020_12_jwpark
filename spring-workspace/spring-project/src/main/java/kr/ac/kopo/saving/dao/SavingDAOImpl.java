package kr.ac.kopo.saving.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.saving.vo.SavingVO;

@Repository
public class SavingDAOImpl implements SavingDAO {

	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public List<SavingVO> selectUserSaving(String regNo) {
		
		List<SavingVO> list = session.selectList("saving.dao.SavingDAO.selectSavingByRegNo", regNo);
		
		return list;
	}

	@Override
	public void insertSaving(SavingVO saving) {
		session.insert("saving.dao.SavingDAO.insertSaving", saving); 
			
	}
	
	
}
