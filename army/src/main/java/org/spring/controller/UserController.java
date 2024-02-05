package org.spring.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.spring.domain.CalendarVO;
import org.spring.domain.SnsAuthResponse;
import org.spring.domain.UserVO;
import org.spring.service.AdminService;
import org.spring.service.LoginService;
import org.spring.service.UserService;
import org.spring.service.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/login")
@Log4j
public class UserController {
	@Autowired
	private LoginService ls;
	@Autowired
	private UserService us;
	@Autowired
	private AdminService as;

	
	@RequestMapping("/login")
	public String start() {
		return "login/login";
	}

	@RequestMapping("/logout")
	public String end(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:../login/login";
	}
	// SNS!!!!!!!!!!!!!!!!!!!
	@RequestMapping(value = "/authReq", method = RequestMethod.GET)
	public String snsLogin(@RequestParam("v") String portal) {
		String link = ls.getAuthLink(portal);
		log.info(link);
		return "redirect:" + link;
	}

	@RequestMapping(value = "/auth")
	public String snsAuth(@RequestParam("v") String portal, SnsAuthResponse response, Model model,
			HttpServletRequest request) {
		String snsID = ls.getUserData(portal, ls.getToken(portal, response)); 
		String url = "";
		log.info(snsID);
		if (ls.snsLogin(snsID) == 0) {
			url = "login/snsHide";
			model.addAttribute("snsID", snsID);
			model.addAttribute("url", "../login/login/join");
		} else {
			url = "redirect:../login/main";
			request.getSession().setAttribute("user", ls.getUser("sns", snsID)); 
		}
		return url;
	}

	@GetMapping("/main")
	public String mainGo(HttpServletRequest request) {
		log.info(request.getSession().getAttribute("user")); // user의 세션이 없으면 초기화면으로 이동됨
		if (request.getSession().getAttribute("user") != null) {
			return "/main";
		} else {
			return "/login/login";
		}
	}
	// SNS 종료!!!!!!!!!!

	// 회원가입!!!!!!!!!
	@RequestMapping(value = "/login/join")
	public String userJoin(@RequestParam(value = "snsID", required = false) String snsID, Model model) {
		model.addAttribute("snsID", snsID);
		return "login/join";
	}

	@RequestMapping(value = "/login/sign", method = RequestMethod.POST)
	public String userSignup(UserVO vo, Model model, HttpServletRequest request) {
		log.info(vo);
		vo.setEmail(vo.getEmail()+"@narasarang.or.kr");
		int result = ls.userRegister(vo);
		log.info(result);
		if (result == 1) {
			model.addAttribute("result", "입대 축하합니다.");
			request.getSession().setAttribute("user", ls.getUser("id", vo.getId()));
			request.getSession().setMaxInactiveInterval(600);
			return "/main";
		} else {
			model.addAttribute("result", "회원 등록 실패 관리자에게 문의 바랍니다.");
			return "redirect:user/";
		}
	}
	// 회원가입 종료!!!!!!!!!

	// 아이디/비번 찾기
	@RequestMapping("/login/find")
	public String findID() {
		return "login/find";
	}

	// ajax로 리턴받는 메소드들 모음(맨 아래)
	@ResponseBody
	@RequestMapping(value = "/checker", method = RequestMethod.POST)
	public UserVO duplicateCheck(@RequestParam(value = "checkValue") String value,
			@RequestParam(value = "checkColumn") String Column) {
		return ls.getUser(Column, value);
	}

	// 계정 정보 변경
	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public int modify(@RequestBody Map<String, String> map,HttpServletRequest request) {
		int result = 1;
		for (String key : map.keySet()) {
			if (!key.equals("id")) {
				result = result & us.modifyInfo(key,map.get(key),map.get("id"));
			}
		}
		if(result==1) {
			request.getSession().invalidate();
		}
		return result;
	}
	
	//계정 정보 삭제
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public int delete(@RequestParam("id") String id,HttpServletRequest request) { // 유저 정보 다중 변경
		log.info(id);
		int result=us.delUser(id);
		if(result==1) {
			request.getSession().invalidate();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/findid", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public <T> T finder(@RequestParam(value = "checkValue") String value,
			@RequestParam(value = "checkColumn") String Column) { // 아이디 찾기 나중에 나라사랑 메일 체크 제약도 추가필요
		UserVO vo = ls.getUser(Column, value);
		HashMap<String, Object> result = new HashMap<>();
		if (vo == null) {
			result.put("id", "해당 메일로 가입한 회원이 없습니다.");
			return (T) result;
		} else {
			vo.setId("id는 " + vo.getId() + "입니다.");
			return (T) vo;
		}
	}

	@ResponseBody
	@RequestMapping("/emailauth") // 회원 가입 시 이메일 인증
	public String signUpCheckEmail(@RequestParam("email") String email) {
		String code = "";
		/*
		 * if(email.contains("@narasarang.")){ code=ls.checkEmail(email); }
		 */
		if (email != null) {
			code = ls.checkEmail(email);
		} else {
			code = "이메일 정보를 입력받지 못했습니다.";
		}
		return code;
	}

	@RequestMapping(value = "/login/login", produces = "text/plain;charset=UTF-8") // 로그인 버튼 누르면 로그인 결과 전달
	@ResponseBody
	public String loginCheck(UserVO vo, HttpServletRequest request) {
		String result = "";
		UserVO login = ls.getUser("id", vo.getId());
		if (login != null) {
			if (login.getPw().equals(vo.getPw())) {
				
				if(login.getBaned()!=null) {
					if(login.getBaned().before(new Timestamp(System.currentTimeMillis()))) {
						result = "로그인 성공";
						Map<String,Object> map=new HashMap<String,Object>();
						map.put("nickname",login.getNickname());
						map.put("gubun", "없음");
						map.put("baned", null);
						as.baned(map);
						request.getSession().setAttribute("user", login);
					}else {
						result="불량 활동으로 정지된 유저입니다. 정지기간 : "+String.valueOf(login.getBaned()).substring(0,toString().valueOf(login.getBaned()).length()-2)+"까지.." ;
					}
				}else {
					result = "로그인 성공";
					request.getSession().setAttribute("user", login);
				}
			} else {
				result = "비밀번호가 틀립니다. 다시 확인해주세요";
			}
		} else {
			result = "아이디가 존재하지 않습니다.";
		}
		log.info(result);
		return result;
	}
	
}
