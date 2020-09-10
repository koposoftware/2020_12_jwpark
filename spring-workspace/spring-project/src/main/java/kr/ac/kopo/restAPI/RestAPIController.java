package kr.ac.kopo.restAPI;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
public class RestAPIController {

	@GetMapping("/ddd")
	public String reportRest() {
		
		return "hi";
	}
}
