package com.kosta.dorang.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kosta.dorang.dto.SessionUser; // session에 넣어놓기 위해 따로 빼서 생성해둔 user
import com.kosta.dorang.service.UserService;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	UserService userService = new UserService();
	
	@RequestMapping(value="/kakaoCallback", method=RequestMethod.GET)
	public String redirectKakao(@RequestParam String code, HttpSession session) throws IOException {
		System.out.println("#########code:" +code); // 로그인 버튼 눌렀을 때 임시 토큰 값
		
		// 접속토큰 가져옴
		String access_token = userService.getReturnAccessToken(code);
		
		// 접속자 정보 가져옴
		Map<String, Object> result = userService.getUserInfo(access_token);
		System.out.println("USERCONTROLLER:: id "+result.get("id"));
		SessionUser session_user = new SessionUser();
		session_user.setUser_id((String)result.get("id"));
		session_user.setUser_nickname((String)result.get("nickname"));
		session_user.setUser_pic((String)result.get("profile_image"));
		
		session.setAttribute("user", session_user);
		session.setAttribute("access_token", access_token); // 로그아웃 시 사용할 토큰 값
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout")
	public String logout(ModelMap modelMap, HttpSession session) throws IOException {
				
//		if(SystemUtil.EmptyCheck((String)session.getAttribute("access_token"))) {
		if(session.getAttribute("access_token") != null) {
		}else {
			userService.logout((String)session.getAttribute("access_token"));
		}
		session.setAttribute("user", null);
		HashMap<String,String> message = new HashMap<>();
		message.put("title", "로그아웃");
		message.put("script", "loaction.href='/'");
		message.put("msg", "로그아웃 되었습니다.");
		message.put("type", "alert");
		modelMap.addAttribute("message", message);
		// access_token 값은 카카오로 로그인할 때만 생기는 값 -> 유저 식별 가능
		return "/";
	}
	
	
}
