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
<title>Login Page</title>
<style>

</style>
<script type="text/javascript">
$(function(){
	// 컨텐츠 빈 항목 체크
	function contents(){
		var id = $('#id').val();
		var pw = $('#pw').val();
		
		if(!id){
			alert("아이디를 입력해주세요.");
			return;
		}
		if(!pw){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		$('#form1').attr("action", "/www/member/loginProc");
		$('#form1').submit();
	}
	
	$('#login').click(contents);
});
</script>
</head>
<body>
	<div class="container">
		<form method="post" id="form1">
			<div class="row">
				<div class="col-md-2">아 이 디:</div>
				<div class="col-md-2"><input type="text" name="id" id="id"></div>
			</div>
			<div class="row">
				<div class="col-md-2">비밀번호:</div>
				<div class="col-md-2"><input type="password" name="pw" id="pw"></div>
			</div>
		</form>
		<div class="row">
			<button type="button" id="login">로그인</button><button type="button">회원가입</button>
		</div>
	</div>
</body>
</html>