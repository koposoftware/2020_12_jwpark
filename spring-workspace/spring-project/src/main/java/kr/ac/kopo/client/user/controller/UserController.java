package kr.ac.kopo.client.user.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.client.user.service.UserService;
import kr.ac.kopo.client.user.vo.UserVO;
import kr.ac.kopo.logger.Log4j2;


@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private Log4j2 log;
	
	@GetMapping("/login")
	public String loginForm() {
		return "/client/login/login";
	}
	
	@PostMapping("/login")
	public ModelAndView login(UserVO user, HttpSession session) {
		
		
		UserVO userVO = userService.login(user);
		
		ModelAndView mav = new ModelAndView();
		
		if(userVO == null) {
			mav.addObject("loginStatus", "fail");
			mav.setViewName("/client/login/login");
			
		} else {
			mav.setViewName("redirect:/");
			//mav.addObject("userVO", userVO);
			session.setAttribute("userVO", userVO);
			log.infoLog("user login", userVO.getId() + "(" + userVO.getName() + ") 로그인");
		}
		
		return mav;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		
		UserVO userVO = (UserVO)session.getAttribute("userVO");
		
		if(userVO != null) {
			log.infoLog("user logout", userVO.getId() + "(" + userVO.getName() + ") 로그아웃");
		}
		
		session.removeAttribute("userVO");
		
		return "redirect:/";
	}
	
	/*
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		
		status.setComplete();
		
		return "redirect:/";
	}
	*/
	
	@GetMapping("/waitRoom")
	public String waitRoom(HttpSession session) {
		
		UserVO userVO = (UserVO)session.getAttribute("userVO");
		
		String retUrl ="";
		if(userVO != null) {
			log.infoLog("user waitRoom go", "손님 " + userVO.getId() + "(" + userVO.getName() + ") 대기실 입장");
			retUrl = "/client/waitRoom/waitRoom-client";
		} else {
			retUrl ="redirect:/";
		}
		
		return retUrl;
	}
	
	@GetMapping("/bankCounter")
	public String bankCounter(HttpSession session) {
		
		UserVO userVO = (UserVO)session.getAttribute("userVO");
		
		if(userVO != null) {
			log.infoLog("user bankCounter go", "손님 " + userVO.getId() + "(" + userVO.getName() + ") 창구 입장");
		} else {
			log.infoLog("user bankCounter go", "손님 정보 없음. 창구 입장.");
		}
		
		return "/client/bankCounter/bankCounter-client";
	}
	
	@GetMapping("/outRoom")
	public String outRoom() {
		return "/client/outRoom/outRoom-client";
	}
}
