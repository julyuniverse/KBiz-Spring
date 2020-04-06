package com.KBiz.www.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.KBiz.www.vo.MemberVO;

public class MemberDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	// 회원가입 실행
	public int joinProc(MemberVO mVO) {
		
		return sqlSession.insert("mSQL.joinProc", mVO);
	}

	// 로그인 실행
	public int loginProc(MemberVO mVO) {
		
		return sqlSession.selectOne("mSQL.loginProc", mVO);
	}
}