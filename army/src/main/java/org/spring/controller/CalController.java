package org.spring.controller;

import java.util.List;

import org.spring.domain.CalendarVO;
import org.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user")
@Log4j
public class CalController {
	@Autowired
	private UserService us;
	@GetMapping("/myCalendar/mySchedule")
	public void listAll() {
		log.info("���ؽ�");
	}
	
	@ResponseBody
	@RequestMapping(value="/myCalendar/mySchedule", method = RequestMethod.POST)
	public List<CalendarVO> getallcalList(String nickname){
		log.info(nickname);
		return us.calenderListAll(nickname);
	}
	
	@GetMapping("/myCalendar/modifySchedule")
	public void getcal(@RequestParam("calNo") Integer calNo, Model model) {	
		model.addAttribute("vo", us.list(calNo));
	}
	
	@PostMapping("/myCalendar/modifySchedule")
	public String modify(CalendarVO vo) {
		us.modifyCal(vo);
			log.info(vo.getCalNo());
			log.info(vo.getContent());
			log.info(vo.getEndDate());
			log.info(vo.getNickname());
			log.info(vo.getStartDate());
		  return "redirect:/user/myCalendar/mySchedule";
	}
	
	@GetMapping("/myCalendar/remove")
	public void rg() {

	}
	
	@PostMapping("/myCalendar/remove")
	public String remove(Integer calNo) {
			us.delCal(calNo);
			  return "redirect:/user/myCalendar/mySchedule";
	}
	
	@GetMapping("/myCalendar/scheduleRegister")
	public void c() {
	}
	
	@PostMapping("/myCalendar/scheduleRegister")
	public String create(CalendarVO vo) {
		log.info(vo);
		us.addCal(vo);
		  return "redirect:/user/myCalendar/mySchedule";
	}
	
	@GetMapping("/myPage")
	public String myPage() {
		return "user/myPage";
	}
	
	@GetMapping("/myModify")
	public String myModify() {
		return "user/myModify";
	}
}
