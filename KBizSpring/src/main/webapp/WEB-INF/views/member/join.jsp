<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>Join Page</title>
<style>
</style>
<script type="text/javascript">
$(function(){
	// join 버튼
	$('#join').click(function(){
		$('#form1').submit();
	});
});
</script>
</head>
<body>
	<div class="container">
		<form method="post" action="/www/member/joinProc" id="form1">
			<div class="row">
				<div class="col-md">
					<h1>ID</h1><input type="text" name="id" id="id">
				</div>
			</div>
		</form>
		<div class="row">
			<button type="button" class="btn btn-primary" id="join">가입</button>
		</div>
	</div>
</body>
</html>