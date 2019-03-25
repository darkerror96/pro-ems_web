<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.collabera.db.ConnectionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>EMS Login</title>
<style>
body {
	background: lightblue;
}

h1 {
	text-align: center;
}

div.form {
	display: block;
	text-align: center;
}

form {
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
}

.legend {
	background-color: #000;
	color: #fff;
	font-size: 35px;
	text-align: center;
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
}

input[type=number], input[type=password] {
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: black;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	outline: none;
}

input[type=number]:focus, input[type=password]:focus {
	border: 3px solid #555;
}

input[type=submit] {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: black;
	background-color: white;
	border-radius: 8px;
	cursor: pointer;
}

input[type=submit]:hover {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: white;
	background-color: black;
	border-radius: 8px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	function validateForm() {
		var pwd = document.forms["loginForm"]["pwd"].value;

		if (pwd.length != 4) {
			document.forms["loginForm"]["pwd"].value = "";
			document.forms["loginForm"]["pwd"].focus();
			alert("Password length should be 4 digits. Try again...");
			return false;
		}
	}
	function checkFlag() {
		<%String lmsgErr = (String) session.getAttribute("loginFlag");%>
			var lmsg = "<%=lmsgErr%>";
		if (lmsg !== "null") {
			<%session.setAttribute("loginFlag", "null");%>
			alert(lmsg);
		}
	}
</script>
</head>
<body onload="checkFlag()">
	<hr>
	<h1>Employee Management System</h1>
	<hr>
	<br>
	<br>
	<div class="form">
		<form name="loginForm" action="Home" method="POST"
			style="width: 786px;" autocomplete="off"
			onsubmit="return validateForm()">
			<fieldset>
				<legend class="legend">Login Credentials</legend>
				<br> <input id="eId" type="number" name="eId"
					placeholder="Enter Employee Id" value="0" autofocus required /><br>
				<br> <input id="pwd" type="password" name="pwd"
					placeholder="Enter Password" value="admi" required><br>
				<br> <input type="submit" value="Login"><br> <br>
			</fieldset>
		</form>
	</div>
</body>
</html>