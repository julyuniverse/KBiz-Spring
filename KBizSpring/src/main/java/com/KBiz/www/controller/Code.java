package com.KBiz.www.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.KBiz.www.dao.CodeDAO;
import com.KBiz.www.vo.CodeVO;

@Controller
@RequestMapping("/code/")
public class Code {

	@Autowired
	CodeDAO cDAO;
	
	// 코드 리스트 출력
	@RequestMapping("codeList")
	public ModelAndView codeList(ModelAndView mv, CodeVO cVO) {
		
		List<CodeVO> list = cDAO.codeList(cVO);
		mv.addObject("LIST", list);
		
		mv.setViewName("code/codeList");
		return mv;
	}
	
	// 코드 내용 출력
	
	@RequestMapping("codeInfo") public @ResponseBody CodeVO codeInfo(CodeVO cVO) {
		
		cVO = cDAO.codeInfo(cVO);
	
		return cVO;
	}
	
	
	// 코드 추가 실행
	
	@RequestMapping("codeAdd") public ModelAndView codeAdd(ModelAndView mv, 
			RedirectView rv, CodeVO cVO) {
	
		cDAO.codeAdd(cVO);
	
		mv.setViewName("code/codeRV"); return mv;
	}
	
	
	// 코드 수정 실행
	
	@RequestMapping("codeEdit") public ModelAndView codeEdit(ModelAndView mv,
			RedirectView rv, CodeVO cVO) {
	
		cDAO.codeEdit(cVO);
	
		mv.setViewName("code/codeRV"); return mv;
	}
	
}