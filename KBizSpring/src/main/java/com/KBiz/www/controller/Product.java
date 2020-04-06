package com.KBiz.www.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.KBiz.www.vo.ProductVO;

@Controller
@RequestMapping("/product/")
public class Product {

	// 상품 리스트 출력
	@RequestMapping("productList")
	public ModelAndView productList(ModelAndView mv, ProductVO prdtVO) {
		
		mv.setViewName("product/productList");
		return mv;
	}
}
