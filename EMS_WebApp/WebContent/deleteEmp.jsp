<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.collabera.db.ConnectionManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
<title>Delete Employee</title>
<style>
body {
	background: lightblue;
}

h1 {
	text-align: center;
}

.legend {
	background-color: #000;
	color: #fff;
	font-size: 30px;
	text-align: center;
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
}

.customBtn {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: black;
	background-color: #ff401a;
	border-radius: 8px;
	cursor: pointer;
	margin-left: 86.7%;
	width: 13%;
}

.customBtn:hover {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: black;
	background-color: lime;
	border-radius: 8px;
	cursor: pointer;
}

input[type=number] {
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: black;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	outline: none;
}

input[type=number]:focus {
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
	display: block;
	margin-left: 40%;
	margin-right: 50%;
	width: 20%;
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

table.center {
	margin-left: auto;
	margin-right: auto;
}
</style>

<script type="text/javascript">
	function checkFlag() {
<%String msgErr = (String) session.getAttribute("deleteFlag");%>
	var dmsg = "<%=msgErr%>";
		if (dmsg !== "null") {
<%session.setAttribute("deleteFlag", "null");%>
	alert(dmsg);
		}
	}
	function validateForm() {
		var eId = document.forms["deleteEmpForm"]["eId"].value;

		//-------------------AGE-------------------
		if (eId < 1) {
			document.forms["deleteEmpForm"]["eId"].value = "";
			document.forms["deleteEmpForm"]["eId"].focus();
			alert("Employee Id should be positive. Try again...");
			return false;
		}
	}
</script>
</head>
<body onload="checkFlag()">
	<hr>
	<h1>Delete Employee</h1>
	<hr>
	<button class="customBtn" onclick="window.location='adminHome.jsp'">Admin
		Home</button>
	<hr>
	<br>
	<form name="deleteEmpForm" action="Delete" method="post"
		autocomplete="off" onsubmit="return validateForm()">
		<fieldset>
			<legend class="legend">Enter Employee Id</legend>
			<br>
			<table class="center">
				<tr>
					<th><input type="number" id="eId" name="eId" required
						autofocus /><br></th>
				</tr>
			</table>
			<br> <br> <input type="submit" value="Delete Employee" />
			<br>
		</fieldset>
	</form>
	<jsp:include page="empDb.jsp" />
</body>
</html>