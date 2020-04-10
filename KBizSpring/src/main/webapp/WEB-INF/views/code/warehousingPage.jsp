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
<title>Warehousing Page</title>
<style>

</style>
<script type="text/javascript">
$(function(){

	$('#OPqow2').css('display', 'none');
	
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
	
	// 금일 입고리스트중 한개 클릭시 상세보기
	$(document).on('click', '.WHinfo', function(){
		var whcd = $(this).attr('id');
		alert(whcd);
		
		$.ajax({
			url		: "/www/code/WHinfo",
			type	: "post",
			dataType: "json",
			data	: {
				"whcd" : whcd
			},
			success : function(data){
				$('#whcd').val(data.whcd);
				$('#OPitemcd').html(data.itemcd);
				$('#IPitemcd').val(data.itemcd);
				$('#OPitemnm').html(data.itemnm);
				$('#OPbrand').html(data.brand);
				$('#OPitemunitcdnm').html(data.itemunitcdnm);
				$('#OPqow').html(data.qow);
				$('input[name=qow]').val(data.qow);
				
				$('#OPqow2').css('display', 'block');
				$('#OPqow3').css('display', 'none');
			},
			error : function(){
				alert('코드 정보 요청에 실패했습니다..');
			}
		});
		
	});
	
	// 수정 버튼
	$('#update').click(function(){
		$('#twoAction').val("a2");
		$('#OPqow2').css('display', 'none');
		$('#OPqow3').css('display', 'block');
	});
	
	// 저장 버튼
	$('#save').click(function(){
		var action = $('#twoAction').val();
		
		// 코드 추가 실행
		if(action == 'a1'){
			alert("추가 했습니다.");
			
			$('#form1').attr("action", "/www/code/qowAdd");
			$('#form1').submit();
			
		// 코드 수정 실행
		}else{
			alert("수정 했습니다.");
			
			$('#form1').attr("action", "/www/code/qowUpdate");
			$('#form1').submit();
		}
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
		<h2>금일 입고리스트</h2>
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th>상품코드</th>
					<th>상품명</th>
					<th>제조사코드</th>
					<th>제조사명</th>
					<th>단위코드</th>
					<th>단위명</th>
					<th>입고수량</th>
				</tr>
			</thead>
			<tbody class="">
				<c:forEach var="WHlist" items="${WHlist }">
					<tr id="${WHlist.whcd }" class="WHinfo" style="cursor:pointer">
						<td>${WHlist.itemcd }</td>
						<td>${WHlist.itemnm }</td>
						<td>${WHlist.madenmcd }</td>
						<td>${WHlist.brand }</td>
						<td>${WHlist.itemunitcd }</td>
						<td>${WHlist.itemunitcdnm }</td>
						<td>${WHlist.qow }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div style="border:1px solid black">
			<div style="border-bottom:1px solid black">입고내용</div>
			
			<!-- 2가지 경로로 보내기 위해서 버튼 클릭시 값을 변경 -->
			<input type="hidden" id="twoAction" value="a1">
			
			<form method="post" id="form1">
			<input type="hidden" id="whcd" name="whcd">
			<p>상품코드:<span id="OPitemcd"></span></p>
			<p><input id="IPitemcd" type="hidden" name="itemcd"></p>
			
			<p>상 품 명:<span id="OPitemnm"></span></p>
			
			<p>제 조 사:<span id="OPbrand"></span></p>
			
			<p>단 위 명:<span id="OPitemunitcdnm"></span></p>
			<p id="OPqow2">입고수량:<span id="OPqow"></span></p>
			<p id="OPqow3">입고수량:<input type="text" name="qow"></p>
			</form>
			
			<button type="button" id="update">수정</button>
			<button type="button" id="save">저장</button>
		</div>
	</div>
</body>
</html>