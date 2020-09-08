package kr.ac.kopo.client.user.dao;

import kr.ac.kopo.client.user.vo.UserVO;

public interface UserDAO {

	UserVO login(UserVO user);
	UserVO getUserInfo(String id);
	void updateElecFinanceStatus(String regNo);
}
