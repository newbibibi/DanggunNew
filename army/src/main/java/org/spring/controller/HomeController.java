package org.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.spring.domain.BoardVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.SaleVO;
import org.spring.domain.UserVO;
import org.spring.service.CenterService;
import org.spring.service.Board.BoardService;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/*")
@AllArgsConstructor
public class HomeController {
	
	private final BoardService boardService;
	private final CenterService centerService;
	
	@GetMapping("/")
	public String mainpage() {
		return "index";
	}
	
	@GetMapping("/main2")
	public void mainpage2() {

	}

	
	@ResponseBody
	@RequestMapping(value="/main/boardlist",method = RequestMethod.POST)
	public List<BoardVO> getboardlist(){
		
		return boardService.mainList();
	}
	
	@ResponseBody
	@RequestMapping(value="/main/noticelist",method = RequestMethod.POST)
	public List<NoticeVO> getnoticelist(){
		
		return centerService.mainNList();
	}
	
	@ResponseBody
	@RequestMapping(value="/main/benefitlist",method = RequestMethod.POST)
	public List<SaleVO> getbenefitlist(HttpServletRequest request){
		UserVO user = (UserVO) request.getSession().getAttribute("user");
		String userRegion = "all";
		if(user.getRegion()!=null) {
			userRegion = user.getRegion();
		}
		
		return centerService.mainBList(userRegion);
	}
}
