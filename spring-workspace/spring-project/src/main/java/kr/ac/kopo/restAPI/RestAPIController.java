package kr.ac.kopo.restAPI;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.reportDetail.service.ReportDeatilService;
import kr.ac.kopo.reportDetail.vo.ReportDetailVO;

@CrossOrigin
@RestController
public class RestAPIController {

	@Autowired
	ReportDeatilService reportDetailService;
	
	@GetMapping("/rest/{apikey}")
	public List<ReportDetailVO> reportRest(@PathVariable("apikey") String apiKey) {
		
		List<ReportDetailVO> list = null;
		
		String api = reportDetailService.selectApiKey(apiKey);
		
		if(api != null) {
			list = reportDetailService.selectReportDetail();
			for(int i = 0; i < list.size(); i++) {
				
				list.get(i).setConsultingChannel("원격");
			}
		}
		
		return list;
	}
	
	@GetMapping("/rest/{apikey}/{telegram}")
	public List<ReportDetailVO> reportRestByCategoryAndReportYMD(@PathVariable("apikey") String apiKey, @PathVariable("telegram") String telegram) {
		
		List<ReportDetailVO> list = null;
		String api = reportDetailService.selectApiKey(apiKey);
		
		if(telegram.length() > 18) {
			String startDate = telegram.substring(0,8);
			String endDate = telegram.substring(8,16);
			String middleCategory = telegram.substring(16,18);
			String userId = telegram.substring(18);
			
			if(middleCategory.substring(0, 1).equals("0"))
				middleCategory = middleCategory.substring(1, 2);
			
			if(api != null) {
				ReportDetailVO reportDetail = new ReportDetailVO();
				reportDetail.setMiddleCategory(middleCategory);
				reportDetail.setReportYmd(startDate);
				reportDetail.setReportYMD2(endDate);
				reportDetail.setId(userId);
				
				//list = reportDetailService.selectReportDetailByCategoryAndReportYMD(reportDetail);
				list = reportDetailService.selectReportDetailByCategoryAndReportYMDUserID(reportDetail);
				
				for(int i = 0; i < list.size(); i++) {
					list.get(i).setConsultingChannel("원격");
				}
			}
			else {
				list = null;
			}
		}
		else if(telegram.length() > 16) {
			String startDate = telegram.substring(0,8);
			String endDate = telegram.substring(8,16);
			String middleCategory = telegram.substring(16,18);
			
			if(middleCategory.substring(0, 1).equals("0"))
				middleCategory = middleCategory.substring(1, 2);
			
			if(api != null) {
				ReportDetailVO reportDetail = new ReportDetailVO();
				reportDetail.setMiddleCategory(middleCategory);
				reportDetail.setReportYmd(startDate);
				reportDetail.setReportYMD2(endDate);
				
				list = reportDetailService.selectReportDetailByCategoryAndReportYMD(reportDetail);
				//list = reportDetailService.selectReportDetailByCategoryAndReportYMDUserID(reportDetail);
				
				for(int i = 0; i < list.size(); i++) {
					list.get(i).setConsultingChannel("원격");
				}
			}
			else {
				list = null;
			}
		} else if(telegram.length() == 16) {
			String startDate = telegram.substring(0,8);
			String endDate = telegram.substring(8,16);
					
			
			if(api != null) {
				ReportDetailVO reportDetail = new ReportDetailVO();
				reportDetail.setReportYmd(startDate);
				reportDetail.setReportYMD2(endDate);
				
				list = reportDetailService.selectReportDetailByReportYMD(reportDetail);
				
				for(int i = 0; i < list.size(); i++) {
					list.get(i).setConsultingChannel("원격");
				}
			}
			else {
				list = null;
			}
		} else if(telegram.length() == 2) {
			String middleCategory = telegram;
			
			if(middleCategory.substring(0, 1).equals("0"))
				middleCategory = middleCategory.substring(1, 2);
			
			if(api != null) {
				ReportDetailVO reportDetail = new ReportDetailVO();
				reportDetail.setMiddleCategory(middleCategory);
				
				list = reportDetailService.selectReportDetailByCategory(reportDetail);
				
				for(int i = 0; i < list.size(); i++) {
					list.get(i).setConsultingChannel("원격");
				}
			}
			else {
				list = null;
			}
		}
		
		return list;
	}
	
}
