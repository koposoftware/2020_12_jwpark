package kr.ac.kopo.client.user.controller;

import javax.servlet.http.HttpSession;

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


@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@GetMapping("/login")
	public String loginForm() {
		return "/client/login/login";
	}
	
	@PostMapping("/login")
	public ModelAndView login(UserVO user, HttpSession session) {
		
		UserVO userVO = userService.login(user);
		
		ModelAndView mav = new ModelAndView();
		
		if(userVO == null) {
			mav.setViewName("redirect:/login");
		} else {
			mav.setViewName("redirect:/");
			//mav.addObject("userVO", userVO);
			session.setAttribute("userVO", userVO);
		}
		
		return mav;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
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
	public String waitRoom() {
		return "/client/waitRoom/waitRoom-client";
	}
	
	@GetMapping("/bankCounter")
	public String bankCounter() {
		return "/client/bankCounter/bankCounter-client";
	}
	
}
