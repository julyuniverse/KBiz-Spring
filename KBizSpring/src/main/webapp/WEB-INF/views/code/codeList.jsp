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
<title>Code List</title>
<style>

</style>
<script type="text/javascript">
$(function(){
	
	// 상세보기
	$('.toInfo').click(function(){
		
		var listcno = $(this).attr('id');
		
		$.ajax({
			url		: "/www/code/codeInfo",
			type	: "post",
			dataType: "json",
			data	: {
				"cdno" : listcno
			},
			success : function(data){
				$('#cdno').html(data.cdno);
				$('#cdlv').html(data.cdlv);
				$('#highcd').html(data.highcd);
				$('#cdname').html(data.cdname);
				$('#use').html(data.use);
				$('.ei').css('display', 'none');
				$('.list').css('display', 'inline-block');
				$('#cnoP').css('display', 'inline-block');
				$('.cdno2').css('display', 'none');
				
			},
			error : function(){
				alert('코드 정보 요청에 실패했습니다.');
			}
		});
	});
	
	// 추가 버튼
	$('#insert').click(function(){
		$('.list').css('display', 'none');
		$('.ei').css('display', 'inline-block');
		$('#twoAction').val("a1");
		$('.ei').attr('disabled', false);
		$('#cnoP').css('display', 'none');
		
		$('.cdno').val('');
		$('.cdlv').val('');
		$('.highcd').val('');
		$('.cdname').val('');
		$('.use').val('');
	});
	
	// 수정 버튼
	$('#edit').click(function(){
		$('.list').css('display', 'none');
		$('.ei').css('display', 'inline-block');
		$('#twoAction').val("a2");
		$('.ei').attr('disabled', false);
		
		$('.cdno2').html($('#cdno').text());
		$('#cnoP').css('display', 'inline-block');
		$('.cdno').css('display', 'none');
		$('.cdno2').css('display', 'inline-block');
		
		$('.cdno').val($('#cdno').text());
		$('.cdlv').val($('#cdlv').text());
		$('.highcd').val($('#highcd').text());
		$('.cdname').val($('#cdname').text());
		$('.use').val($('#use').text());
		
		
	});
	
	// 저장 버튼
	$('#save').click(function(){
		var action = $('#twoAction').val();
		
		// 코드 추가 실행
		if(action == 'a1'){
			alert("추가 했습니다.");
			// SQL 체크 박스 값 넘길 때
			if ($('input[name=useCK]').is(":checked")) {
			    $('input[name=use]').val('Y');
			} else {
			    $('input[name=use]').val('N');
			}
			$('#form1').attr("action", "/www/code/codeAdd");
			$('#form1').submit();
			
		// 코드 수정 실행
		}else{
			alert("수정 했습니다.");
			// SQL 체크 박스 값 넘길 때
			if ($('input[name=useCK]').is(":checked")) {
			    $('input[name=use]').val('Y');
			} else {
			    $('input[name=use]').val('N');
			}
			$('#form1').attr("action", "/www/code/codeEdit");
			$('#form1').submit();
		}
	});
	
	// 체크 박스 checked
	$('input:checkbox[id="Y"]').attr("checked", true);
	
});
</script>
</head>
<body>	
	<div class="container">
		<h1>전체리스트</h1>
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th>코드번호</th>
					<th>코드레벨</th>
					<th>상위코드</th>
					<th>코드이름</th>
					<th>사용여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${LIST }">
					<tr class="toInfo" id="${data.cdno }" style="cursor:pointer">
						<td>${data.cdno }</td>
						<td>${data.cdlv }</td>
						<td>${data.highcd }</td>
						<td>${data.cdname }</td>
						<td><input type="checkbox" id="${data.use }" disabled="disabled"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div style="border:1px solid black">
			<div style="border-bottom:1px solid black"><h1>코드내용</h1></div>
			
			<!-- 2가지 경로로 보내기 위해서 버튼 클릭시 값을 변경 -->
			<input type="hidden" id="twoAction">
			
			<form method="post" action="" id="form1">
				<p id="cnoP">코드번호:<span class="list" id="cdno"></span>
					<input class="ei cdno" type="text" name="cdno" disabled>
					<span class="cdno2"></span></p>
				<p>코드레벨:<span class="list" id="cdlv"></span>
					<input class="ei cdlv" type="text" name="cdlv" disabled></p>
				<p>상위코드:<span class="list" id="highcd"></span>
					<input class="ei highcd" type="text" name="highcd" disabled></p>
				<p>코드이름:<span class="list" id="cdname"></span>
					<input class="ei cdname" type="text" name="cdname" disabled></p>
				<p>사용여부:<span class="list" id="use"></span>
					<input type="hidden" name="use">
					<input class="ei use" type="checkbox" name="useCK" disabled></p>
			</form>
			
			<button type="button" id="insert">추가</button>
			<button type="button" id="edit">수정</button>
			<button type="button" id="save">저장</button>
		</div>
			
	</div>
</body>
</html>