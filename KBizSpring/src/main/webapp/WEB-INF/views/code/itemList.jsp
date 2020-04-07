<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>Item List</title>
<style>

</style>
<script type="text/javascript">
$(function(){
	
	// 1차 카테고리 선택시 자동으로 1차 분류 리스트 가져오기
	$("select[name='category']").change(function() {
		console.log($('select[name=category] > option:selected').val());
		$.ajax({
			url:"/www/code/itemListProc",
			type:"post",
			dataType:"json",
			data:{"cdno": $('select[name=category] > option:selected').val()},
			
			success: function(data) {
				$("select[name=firstClassification] option").remove(); // 옵션 제거
				$("select[name=firstClassification]").append('<option value="">--선택--</option>');
				for(key in data){
					$("select[name=firstClassification]").append('<option value="' + data[key].highcd + '">' + data[key].cdnm + '</option>');
				}
				console.log(data[key]);
			}
		});
	});
	
	// 조회 버튼 실행
	function contents(){
		var category = $('select[name=category]').val();
		var firstClassification = $('select[name=firstClassification]').val();
		
		if(!category){
			alert("카테고리를 선택해 주세요.");
			return;
		}
		if(!firstClassification){
			alert("1차 분류를 선택해 주세요.");
			return;
		}
		/* $('#form1').attr("action", "/www/code/itemInfoList");
		$('#form1').submit(); */
	}
	$('#lookup').click(contents);
});
</script>
</head>
<body>
	<div class="container">
		
		<h2>전체리스트</h2>
		<form method="post" id="form1">
			<div class="row">
				<div class="col">카테고리:</div>
				<div class="col">
					<select name="category">
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
		</form>

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
			<tbody>
			</tbody>
		</table>
		<div style="border:1px solid black">
			<div style="border-bottom:1px solid black">코드내용</div>
			<p>상품코드:</p>
			<p>상 품 명:</p>
			<p>제 조 사: <select name='manufacturer'>
						<option value='' selected>-- 선택 --</option>
					    <option value='SAMSUNG'>SAMSUNG</option>
					    <option value='APPLE'>APPLE</option>
					    <option value='LG'>LG</option>
					</select>
				단 위 명: <select name='unitName'>
						<option value='' selected>-- 선택 --</option>
					    <option value='piece'>개</option>
					</select>
					</p>
			<p>사용여부: <input type="checkbox"></p>
			<button type="button">추가</button>
			<button type="button">수정</button>
			<button type="button">저장</button>
		</div>
	</div>
</body>
</html>