package kr.ac.kopo.client.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.client.user.dao.UserDAO;
import kr.ac.kopo.client.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;
	
	@Override
	public UserVO login(UserVO user) {
		
		return userDAO.login(user);
	}

	@Override
	public UserVO getUserInfo(String id) {
		
		return userDAO.getUserInfo(id);
	}
	
	
	
}
