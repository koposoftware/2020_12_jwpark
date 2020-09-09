package kr.ac.kopo.teller.teller.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.client.user.service.UserService;
import kr.ac.kopo.client.user.vo.UserVO;
import kr.ac.kopo.logger.Log4j2;
import kr.ac.kopo.report.service.ReportService;
import kr.ac.kopo.report.vo.ReportVO;
import kr.ac.kopo.reportDetail.service.ReportDetailServiceImpl;
import kr.ac.kopo.reportDetail.vo.ReportDetailVO;
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
	private ReportService reportService;
	@Autowired
	private ReportDetailServiceImpl reportDetailService;
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
	public ModelAndView waitRoom(HttpSession session) {
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		ModelAndView mav = new ModelAndView();
		
		String retUrl = "";
		if(tellerVO != null) {
			
			mav.setViewName("/teller/waitRoom/waitRoom-teller");
			
			ReportDetailVO reportDetail = new ReportDetailVO();
			
			SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
			Calendar time = Calendar.getInstance();
			
			String expired = format.format(time.getTime());
			
			reportDetail.setEmpNo(tellerVO.getEmpNo());
			reportDetail.setReportYMD(expired);
			
			int reportCount = reportDetailService.selectReportCountByEmpNo(reportDetail);
			
			mav.addObject("reportCount", reportCount);
			
			log.infoLog("teller waitRoom go", "텔러 " + tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 대기실 입장");
			//retUrl ="/teller/waitRoom/waitRoom-teller";
		} else {
			mav.setViewName("redirect:/teller");
			mav.addObject("reportCount", 0);
			//retUrl ="redirect:/teller";
		}
		
		return mav;
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
		
		if(tellerVO != null) {
			
			log.infoLog("teller bankCounter go", "텔러 " + tellerVO.getEmpNo() + "(" + tellerVO.getName() + ") 창구 입장 / 손님 : " + client.getId() + "(" + client.getName() + ")");
		} else {
			log.infoLog("teller bankCounter go", "텔러 정보 없음. 창구 입장." + "/ 손님 : " + client.getId() + "(" + client.getName() + ")");
		}
		
		return mav;
	}
	
	@PostMapping("/teller/report/insert")
	public ModelAndView outRoom(@RequestParam(name="userID") String id, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		UserVO client = userService.getUserInfo(id);
		ReportVO report = new ReportVO();
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		report.setClientId(id);
		report.setTellerEmpNo(tellerVO.getEmpNo());
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd kk:mm:ss");
		Calendar time = Calendar.getInstance();
		
		String expired = format.format(time.getTime());
		
		report.setConsultingDate(expired);
		reportService.insertReport(report);
		mav.addObject("clientVO", client);
		mav.setViewName("/teller/report/report-teller");
		
		return mav;
	}
	
	@PostMapping("/teller/report")
	public ModelAndView report(@RequestParam(name="chk_info") String code, @RequestParam(name="reportTitle") String title, @RequestParam(name="reportArea") String consultingReport, HttpSession session) {
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		ModelAndView mav = new ModelAndView();
		
		ReportVO report = new ReportVO();
		
		report.setTellerEmpNo(tellerVO.getEmpNo());
		report.setMiddleCategory(code);
		report.setTitle(title);
		report.setConsultingReport(consultingReport);
		
		reportService.updateReport(report);
		
		List<ReportDetailVO> list = reportDetailService.selectReportDetailByEmpNo(tellerVO.getEmpNo());
		
		for(int i = 0; i < list.size(); i++) {
			String str = list.get(i).getConsultingReport();
			if(str.length() >= 30) {
				
				str = str.substring(0, 30) + "...";
				list.get(i).setConsultingReport(str);
				
			}
		}
		
		mav.addObject("records", list);
		mav.setViewName("/teller/outRoom/outRoom-teller");
		
		return mav;
	}
	
	@GetMapping("/teller/outRoom")
	public ModelAndView outRoom(HttpSession session) {
		
		TellerVO tellerVO = (TellerVO)session.getAttribute("tellerVO");
		
		ModelAndView mav = new ModelAndView();
		
		List<ReportDetailVO> list = reportDetailService.selectReportDetailByEmpNo(tellerVO.getEmpNo());
		
		for(int i = 0; i < list.size(); i++) {
			String str = list.get(i).getConsultingReport();
			if(str.length() >= 30) {
				
				str = str.substring(0, 30) + "...";
				list.get(i).setConsultingReport(str);
				
			}
		}
		
		mav.addObject("records", list);
		mav.setViewName("/teller/outRoom/outRoom-teller");
		
		return mav;
	}
	
}
