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
	
	@GetMapping("/rest")
	public List<ReportDetailVO> reportRest() {
		
		List<ReportDetailVO> list = reportDetailService.selectReportDetail();
		return list;
	}
	
	@GetMapping("/rest/{apikey}/{telegram}")
	public List<ReportDetailVO> reportRestByReportYMD(@PathVariable("apikey") String apiKey, @PathVariable("telegram") String telegram) {
		
		String startDate = telegram.substring(0,8);
		String endDate = telegram.substring(8,16);
		String middleCategory = telegram.substring(16,18);
		
		if(middleCategory.substring(0, 1).equals("0"))
			middleCategory = middleCategory.substring(1, 2);
		
		String api = reportDetailService.selectApiKey(apiKey);
		
		List<ReportDetailVO> list = null;
		
		if(api != null) {
			ReportDetailVO reportDetail = new ReportDetailVO();
			reportDetail.setMiddleCategory(middleCategory);
			reportDetail.setReportYMD(startDate);
			reportDetail.setReportYMD2(endDate);
			
			list = reportDetailService.selectReportDetailByReportYMD(reportDetail);
		}
		else {
			list = null;
		}
		
		return list;
	}
}
