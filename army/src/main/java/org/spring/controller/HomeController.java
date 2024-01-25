package org.spring.controller;

import java.util.List;

import org.spring.domain.BoardVO;
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
}
