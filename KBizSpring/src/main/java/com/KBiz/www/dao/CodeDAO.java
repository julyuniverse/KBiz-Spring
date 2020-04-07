package com.KBiz.www.dao;

import java.util.List;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
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

	// 1차 카테고리 리스트 출력
	public List<CodeVO> categoryList(CodeVO cVO) {
		
		return sqlSession.selectList("cSQL.categoryList", cVO);
	}
		
	// 1차 카테고리 선택시 자동으로 1차 분류 목록 실행
	public List<CodeVO> itemListProc(CodeVO cVO) {
		List<CodeVO> list = sqlSession.selectList("cSQL.itemListProc", cVO);
		System.out.println(list.size());
		return list; 
	}

	// 조회 클릭시 실행
	public List<CodeVO> itemInfoList(CodeVO cVO) {
		return sqlSession.selectList("cSQL.itemInfoList", cVO);
	}

	


	
	
	
}
