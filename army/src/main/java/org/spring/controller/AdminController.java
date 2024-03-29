package org.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.spring.domain.Criteria;
import org.spring.domain.PageDTO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.ReportVO;
import org.spring.domain.UserVO;
import org.spring.service.AdminService;
import org.spring.service.CenterService;
import org.spring.service.Board.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {
	private final AdminService adminService;
	private final CenterService centerService;

	@GetMapping("/adminFqna")
	public void adminFqna(Criteria cri, Model model) {
		int total = centerService.getfqnaTotal(cri);
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
	}

	@ResponseBody
	@RequestMapping(value = "/adminFqnaList", method = RequestMethod.POST)
	public List<QuestionsVO> getFqnaList(Criteria cri) {
		return centerService.FqnaListAll(cri);
	}

	@GetMapping("/fqnaAnswer")
	public void fqnaAnswer(Integer qno, Model model) {
		QuestionsVO vo = centerService.selectFqna(qno);
		model.addAttribute("board", vo);
	}

	@PostMapping("/fqnaAnswer")
	public String fqnaAnswerModify(QuestionsVO vo, RedirectAttributes rttr) {
		int num = adminService.updateAnswer(vo);
		return "redirect:/admin/adminFqna";
	}

	@GetMapping("/report")
	public String report() {
		return "admin/report";
	}

	@GetMapping("/userManage")
	public String userManage() {
		return "admin/userManage";
	}

	@ResponseBody
	@PostMapping("/userList")
	public Map<String, Object> userView(Criteria cri) {
		switch (cri.getType()) {
		case "e":
			cri.setType("email");
			break;
		case "i":
			cri.setType("id");
			break;
		case "n":
			cri.setType("nickname");
			break;
		case "b":
			cri.setType("baned");
			break;
		}
		log.info(cri);
		List<Map<String, Object>> userList = adminService.userList(cri);
		PageDTO paging = new PageDTO(cri, ((Long) userList.get(0).get("count")).intValue());
		log.info(userList);
		Map<String, Object> responseData = new HashMap<>();
		responseData.put("pageMaker", paging);
		responseData.put("userList", userList);

		return responseData;
	}

	@ResponseBody
	@GetMapping("/reportList")
	public Map<String, Object> reportView(Criteria cri) {
		PageDTO paging = new PageDTO(cri, adminService.reportCount());
		List<Map<String, Object>> reportList = adminService.reportList(cri);

		Map<String, Object> responseData = new HashMap<>();
		responseData.put("pageMaker", paging);
		responseData.put("reportList", reportList);

		return responseData;
	}

	@ResponseBody
	@PostMapping("/baned")
	public int baned(@RequestBody Map<String, Object> map) {
		if (adminService.baned(map) == 1) {
			if (((String) map.get("gubun")).equals("없음")) {
			} else{
				adminService.reportDelete(map);
			}
			return 1;
		}else {
			return 0;
		}
	}

}
