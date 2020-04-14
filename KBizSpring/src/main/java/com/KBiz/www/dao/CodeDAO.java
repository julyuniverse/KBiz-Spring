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
		System.out.println("itemListProc size" + list.size());
		return list; 
	}

	// 조회 클릭시 실행
	public List<CodeVO> itemInfoList(CodeVO cVO) {
		List<CodeVO> list = sqlSession.selectList("cSQL.itemInfoList", cVO);
		System.out.println("itemInfoList size" + list.size());
		return list;
	}

	// 아이템 상세 조회 실행
	public CodeVO itemInfo(CodeVO cVO) {
		
		return sqlSession.selectOne("cSQL.itemInfo", cVO);
	}

	// 아이템 추가 실행
	public int itemAdd(CodeVO cVO) {

		return sqlSession.insert("cSQL.itemAdd", cVO);
		
	}

	// 아이템 수정 실행
	public int itemEdit(CodeVO cVO) {
	
		return sqlSession.update("cSQL.itemEdit", cVO);
	}

	// 입고리스트 출력
	public List<CodeVO> WHlist(CodeVO cVO) {
		
		return sqlSession.selectList("cSQL.WHlist", cVO);
	}

	// 수량 추가 실행
	public int qowAdd(CodeVO cVO) {

		return sqlSession.insert("cSQL.qowAdd", cVO);
	}
	
	// ITEMLIST 재고에도 입고 수량 추가
	public int addINVT(CodeVO cVO) {
		
		return sqlSession.update("cSQL.addINVT", cVO);
	}
	
	// 금일리스트 한개 클릭시 상세 조회 실행
	public CodeVO WHinfo(CodeVO cVO) {
		
		return sqlSession.selectOne("cSQL.WHinfo", cVO);
	}

	// 금일 입고 리스트 중 하나 수정 진행
	public int qowUpdate(CodeVO cVO) {
		
		return sqlSession.update("cSQL.qowUpdate", cVO);
	}
	
	// 금일 입고 수량 변경시 ITEMLIST 재고에도 수정 반영
	public int WHupdate(CodeVO cVO) {
		
		return sqlSession.update("cSQL.WHupdate", cVO);
	}
	
	// 금일 주문 리스트 출력
	public List<CodeVO> orderList(CodeVO cVO){
		
		return sqlSession.selectList("cSQL.orderList", cVO);
	}
	
	// 오더 리스트 중 하나 클릭시
	public CodeVO orderListInfo(CodeVO cVO) {
		
		return sqlSession.selectOne("cSQL.orderListInfo", cVO);
	}
	
	// 출고 수량 추가 실행
	public int fqAdd(CodeVO cVO) {
		
		return sqlSession.insert("cSQL.fqAdd", cVO);
	}
	
	// 금일 주문 출고 리스트 중 하나 수정 진행
	public int fqUpdate(CodeVO cVO) {
			
		return sqlSession.update("cSQL.fqUpdate", cVO);
	}
	
	// 배송 출고시 재고 수정
	public int stock(CodeVO cVO) {
		System.out.println(cVO.getItemcd());
		System.out.println(cVO.getFq());
		return sqlSession.update("cSQL.stock", cVO);
	}
	
	// 배송 취소시 재고 수정
	public int cancelF(CodeVO cVO) {
		
		return sqlSession.update("cSQL.cancelF", cVO);
	}
}
