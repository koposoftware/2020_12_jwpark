package kr.ac.kopo.accountProduct.dao;

import java.util.List;

import kr.ac.kopo.accountProduct.vo.AccountProductVO;

public interface AccountProductDAO {

	List<AccountProductVO> selectAccountProduct();
}
