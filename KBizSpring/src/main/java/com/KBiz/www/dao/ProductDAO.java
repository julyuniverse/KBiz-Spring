package com.KBiz.www.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class ProductDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
}
