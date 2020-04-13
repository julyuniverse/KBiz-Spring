<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>Order Details page</title>
<style>

</style>
<script type="text/javascript">
$(function(){
	
	// 1차 카테고리 선택시 자동으로 1차 분류 리스트 가져오기
	$("select[name='cdno']").change(function() {
		console.log($('select[name=cdno] > option:selected').val());
		$.ajax({
			url:"/www/code/itemListProc",
			type:"post",
			dataType:"json",
			data:{"cdno": $('select[name=cdno] > option:selected').val()},
			
			success: function(data) {
				$("select[name=firstClassification] option").remove(); // 옵션 제거
				$("select[name=firstClassification]").append('<option value="">--선택--</option>');
				for(key in data){
					$("select[name=firstClassification]").append('<option value="' + data[key].cdno + '">' + data[key].cdnm + '</option>');
				}
				console.log(data[key]);
			}
		});
	});
	
	// 조회 버튼 실행
	function contents(){
		var cdno = $('select[name=cdno]').val();
		var firstClassification = $('select[name=firstClassification]').val();
		alert(firstClassification);
		if(!cdno){
			alert("카테고리를 선택해 주세요.");
			return;
		}
		if(!firstClassification){
			alert("1차 분류를 선택해 주세요.");
			return;
		}
		$(".infoTable > tr").remove();
		/* $(".infoTable").append('<tr><td>선택</td></tr>'); */
		
		// 조회 목록
		$.ajax({
			url:"/www/code/itemInfoList",
			type:"post",
			dataType:"json",
			data:{"cdno": $('select[name=firstClassification] > option:selected').val()},
			
			success: function(data) {
				/* $("select[name=firstClassification] option").remove(); // 테이블 제거
				$("select[name=firstClassification]").append('<option value="">--선택--</option>');
				*/
				
				for(key in data){
					$(".infoTable").append('<tr style="cursor:pointer" class="iteminfo" id="' + data[key].itemcd + '"><td>' + data[key].itemcd + '</td><td>' + data[key].itemnm + '</td><td>' + data[key].madenmcd + '</td><td>' + data[key].brand + '</td><td>' + data[key].itemunitcd + '</td><td>' + data[key].itemunitcdnm + '</td><td>' + data[key].stockamt + '</td><td><input type="checkbox" id="' + data[key].stockyn + '" disabled="disabled"></td><td><input type="checkbox" id="' + data[key].use + '" disabled="disabled"></td></tr>');
				}
				console.log(data[key]);
				// 체크 박스 checked
				$('input:checkbox[id="Y"]').attr("checked", true);
			}
		});
		
	}
	$('#lookup').on("click",function(){
		contents();
	});
	
	// 아이템 리스트중 한개 클릭시 상세보기
	$(document).on('click', '.iteminfo', function(){
		var itemcd = $(this).attr('id');
		alert(itemcd);
		
		$.ajax({
			url		: "/www/code/itemInfo",
			type	: "post",
			dataType: "json",
			data	: {
				"itemcd" : itemcd
			},
			success : function(data){
				$('#itemcd').html(data.itemcd);
				$('#itemnm').html(data.itemnm);
				$('#brand').html(data.brand);
				$('#itemunitcdnm').html(data.itemunitcdnm);
				$('#fq').html(data.fq);
				$('#id').html(data.id);
				$('#name').html(data.name);
				$('#rel').html(data.rel);
				$('#postcd').html(data.postcd);
				$('#adr').html(data.adr);
				$('#mp').html(data.mp);
				$('#ht').html(data.ht);
				$('#OPitemcd').html(data.itemcd);
				$('#IPitemcd').val(data.itemcd);
				$('#OPitemnm').html(data.itemnm);
				$('#OPbrand').html(data.brand);
				$('#OPitemunitcdnm').html(data.itemunitcdnm);
				$('input[name=qow]').val(data.qow);
			},
			error : function(){
				alert('코드 정보 요청에 실패했습니다.');
			}
		});
	});
	
	// 리스트중 하나 클릭시
	$('.orderListInfo').click(function(){
		var outitemlistcd = $(this).attr('id');

		$.ajax({
			url		: "/www/code/orderListInfo",
			type	: "post",
			dataType: "json",
			data	: {
				"outitemlistcd" : outitemlistcd
			},
			success : function(data){
				$('#outitemlistcd').val(data.outitemlistcd);
				$('#itemcd').html(data.itemcd);
				$('#itemnm').html(data.itemnm);
				$('#brand').html(data.brand);
				$('#itemunitcdnm').html(data.itemunitcdnm);
				$('#fq').html(data.fq);
				$('#id').html(data.id);
				$('#name').html(data.name);
				$('#rel').html(data.rel);
				$('#postcd').html(data.postcd);
				$('#adr').html(data.adr);
				$('#mp').html(data.mp);
				$('#ht').html(data.ht);
				$('#inspection').html(data.inspection);
				$('#delvy').html(data.delvy);
			},
			error : function(){
				alert('코드 정보 요청에 실패했습니다.');
			}
		});
	});
});
</script>
</head>
<body>
	<div class="container">
		<h2>전체리스트</h2>
		<div class="row">
			<div class="col">카테고리:</div>
			<div class="col">
				<select name="cdno">
					<option value='' selected>--선택--</option>
					<c:forEach var="codeList" items="${codeList}">
						<option value="${codeList.cdno}">${codeList.cdnm}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col">1차 분류:</div>
			<div class="col">
				<select name='firstClassification'>
					<option value='' selected>--선택--</option>
				</select>
			</div>
			<div class="col">
				<button type="button" id="lookup">조회</button>
			</div>
		</div>
		
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th>상품코드</th>
					<th>상품명</th>
					<th>제조사코드</th>
					<th>제조사명</th>
					<th>단위코드</th>
					<th>단위명</th>
					<th>재고수량</th>
					<th>재고여부</th>
					<th>사용여부</th>
				</tr>
			</thead>
			<tbody class="infoTable">
			</tbody>
		</table>
		
		<div class="row">
			<h2>금일 주문 리스트</h2>
			<table class="table table-bordered text-center">
				<thead>
					<tr>
						<th>상품코드</th>
						<th>상품명</th>
						<th>제조사코드</th>
						<th>제조사명</th>
						<th>단위명</th>
						<th>출고수량</th>
						<th>회원아이디</th>
						<th>이름</th>
						<th>관계</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>휴대전화</th>
						<th>집전화</th>
						<th>검수여부</th>
						<th>배송여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="orderList" items="${orderList }">
						<tr id="${orderList.outitemlistcd }" class="orderListInfo" style="cursor:pointer">
							<td>${orderList.itemcd }</td>
							<td>${orderList.itemnm }</td>
							<td>${orderList.madenmcd }</td>
							<td>${orderList.brand }</td>
							<td>${orderList.itemunitcdnm }</td>
							<td>${orderList.fq }</td>
							<td>${orderList.id }</td>
							<td>${orderList.name }</td>
							<td>${orderList.rel }</td>
							<td>${orderList.postcd }</td>
							<td>${orderList.adr }</td>
							<td>${orderList.mp }</td>
							<td>${orderList.ht }</td>
							<td>${orderList.inspection }</td>
							<td>${orderList.delvy }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</div>
		<!-- 2가지 경로로 보내기 위해서 버튼 클릭시 값을 변경 -->
		<input type="text" id="twoAction" value="a1">
		
		<form method="post" id="form1">
			<input type="text" id="outitemlistcd">
			<div class="row">
				<div class="col-md"><p>상품코드:<span id="itemcd"></span></p><input type="text"></div>
				<div class="col-md"><p>상품명:<span id="itemnm"></span></p></div>
				<div class="col-md"><p>제조사:<span id="brand"></span></p></div>
			</div>
			<div class="row">
				<div class="col-md"><p>단위:<span id="itemunitcdnm"></span></p></div>
				<div class="col-md"><p>출고수량:<span id="fq"></span></p></div>
				<div class="col-md"><p>회원아이디:<span id="id"></span></p></div>
			</div>
			<div class="row">
				<div class="col-md"><p>회원이름:<span id="name"></span></p></div>
				<div class="col-md"><p>관계:<span id="rel"></span></p></div>
				<div class="col-md"><p>우편번호:<span id="postcd"></span></p></div>
			</div>
			<div class="row">
				<div class="col-md"><p>주소:<span id="adr"></span></p></div>
				<div class="col-md"><p>휴대전화:<span id="mp"></span></p></div>
				<div class="col-md"><p>집전화:<span id="ht"></span></p></div>
			</div>
			<div class="row">
				<div class="col-md"><p>검수여부:<input type="checkbox"></p></div>
				<div class="col-md"><p>배송여부:<input type="checkbox"></p></div>
				<div class="col-md">
					<p>배송회사:
						<select name="delvycocd">
							<option value="C0081">CJ대한통운</option>
							<option value="C0082">우체국택배</option>
						</select>
					</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md"><p>송장번호:<input type="text" name="invoiceno"></p></div>
				<div class="col-md"><p></p></div>
				<div class="col-md"><p></p></div>
			</div>
		</form>
		<button type="button">수정</button>
		<button type="button" id="save">저장</button>
	</div>
</body>
</html>