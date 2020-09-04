package kr.ac.kopo.teller.teller.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.client.user.service.UserService;
import kr.ac.kopo.client.user.vo.UserVO;
import kr.ac.kopo.logger.Log4j2;
import kr.ac.kopo.teller.teller.service.TellerService;
import kr.ac.kopo.teller.teller.vo.TellerVO;

//@SessionAttributes("tellerVO")
@Controller
public class TellerController {
	
	@Autowired
	private TellerService tellerService;
	@Autowired
	private UserService userService;
	@Autowired
	private Log4j2 log;
	
	@GetMapping("/teller")
	public String tellerMain() {
		return "/teller/index_teller";
	}
			
	
	@GetMapping("/teller/login")
	public String loginForm(HttpSession session) {
		
		return "/teller/login/login";
	}
	
	@PostMapping("/teller/login")
	public ModelAndView login(TellerVO teller, HttpSession session ){
		
		TellerVO tellerVO = tellerService.login(teller);
		
		ModelAndView mav = new ModelAndView();
		
		if(tellerVO == null) {
			mav.addObject("loginStatus", "fail");
			mav.setViewName("/teller/login/login");
			
		} else {
			mav.setViewName("redirect:/teller");
			//mav.addObject("tellerVO", tellerVO);
			session.setAttribute("tellerVO", tellerVO);
			log.infoLog("teller login", tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 로그인");
		}
		
		return mav;
	}
	
	@RequestMapping("/teller/logout")
	public String logout(HttpSession session) {
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		if(tellerVO != null) {
			log.infoLog("teller logout", tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 로그아웃");
		}
		
		session.removeAttribute("tellerVO");
		
		return "redirect:/teller";
	}
	
	/*
	@RequestMapping("/teller/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		
		return "redirect:/teller";
	}
	*/
	
	@RequestMapping("/teller/waitRoom")
	public String waitRoom(HttpSession session) {
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		String retUrl = "";
		if(tellerVO != null) {
			log.infoLog("teller waitRoom go", "텔러 " + tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 대기실 입장");
			retUrl ="/teller/waitRoom/waitRoom-teller";
		} else {
			retUrl ="redirect:/";
		}
		
		return retUrl;
	}
	
	/*
	@RequestMapping("/teller/bankCounter")
	public String bankCounter() {
		return "/teller/bankCounter/bankCounter-teller";
	}
	*/
	
	@PostMapping("/teller/bankCounter")
	public ModelAndView bankCounter(@RequestParam(name="userID") String id, @RequestParam(name="jobType") String type, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		
		UserVO client = userService.getUserInfo(id);
		
		if(client != null) {
			mav.addObject("clientVO", client);
			mav.addObject("jobType", type);
			
			mav.setViewName("/teller/bankCounter/bankCounter-teller");
		}
		else {
			mav.addObject("connectStatus", "fail");
			mav.setViewName("/teller/bankCounter/waitRoom-teller");
		}
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		System.out.println(tellerVO.getEmpNo());
		System.out.println(tellerVO.getName());
		System.out.println(client.getId());
		System.out.println(client.getName());
		
		log.infoLog("teller bankCounter go", "텔러 " + tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 창구 입장 / 손님 : " + client.getId() + "(" + client.getName() + ")");
		
		return mav;
	}
	
	@PostMapping("/teller/outRoom")
	public String outRoom(@RequestParam(name="userID") String id) {
		
		System.out.println(id);
		
		return "/teller/outRoom/outRoom-teller";
	}
	
}
