package kr.ac.kopo.client.user.service;

import kr.ac.kopo.client.user.vo.UserVO;

public interface UserService {

	UserVO login(UserVO user);
	UserVO getUserInfo(String id);
	void updateElecFinanceStatus(String regNo);
}
