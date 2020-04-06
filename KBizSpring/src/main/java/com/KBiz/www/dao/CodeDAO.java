package com.KBiz.www.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.KBiz.www.vo.CodeVO;

public class CodeDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	// 코드리스트 출력
	public List<CodeVO> codeList(CodeVO cVO) {
		
		return sqlSession.selectList("cSQL.codeList", cVO);
	}

	// 코드 내용 보기

	public CodeVO codeInfo(CodeVO cVO) {
	
		return sqlSession.selectOne("cSQL.codeInfo", cVO);
	
	}
	

	// 코드 추가 실행
	
	public int codeAdd(CodeVO cVO) {
	
		return sqlSession.insert("cSQL.codeAdd", cVO);
	}
	

	// 코드 수정 실행
	public int codeEdit(CodeVO cVO) {
	
		return sqlSession.update("cSQL.codeEdit", cVO);
	}
	
}
