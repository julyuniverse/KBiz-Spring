package com.KBiz.www.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.KBiz.www.dao.MemberDAO;
import com.KBiz.www.vo.MemberVO;

@Controller
@RequestMapping("/member/")
public class Member {
	
	@Autowired
	MemberDAO mDAO;

	// 회원가입 페이지
	@RequestMapping("join")
	public ModelAndView mv(ModelAndView mv) {
		
		mv.setViewName("member/join");
		return mv;
	}
	
	// 회원가입 실행
	@RequestMapping("joinProc")
	public ModelAndView mv(ModelAndView mv, RedirectView rv, MemberVO mVO) {
		
		int cnt = mDAO.joinProc(mVO);
		if(cnt == 1) {
			rv.setUrl("/www/main/main");
		}else {
			rv.setUrl("/www/member/join");
		}
		mv.setView(rv);
		return mv;
	}
}