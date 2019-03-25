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
<title>Create Employee</title>
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

input[type=number], input[type=text], input[type=date], input[type=email]
	{
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: black;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	outline: none;
}

input[type=number]:focus, input[type=text]:focus, input[type=date]:focus,
	, input[type=email]:focus {
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
	text-align: center;
	margin-left: 32%;
	margin-right: 25%;
	width: 35%;
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

:root { -
	-radius: 3px; -
	-baseFg: black; -
	-baseBg: white; -
	-accentFg: white; -
	-accentBg: black;
}

select {
	font: 400 12px/1.3 sans-serif;
	-webkit-appearance: none;
	appearance: none;
	color: var(- -baseFg);
	border: 1px solid var(- -baseFg);
	line-height: 1;
	outline: 0;
	padding: 0.65em 2.5em 0.55em 0.75em;
	border-radius: var(- -radius);
	background-color: var(- -baseBg);
	background-image: linear-gradient(var(- -baseFg), var(- -baseFg)),
		linear-gradient(-135deg, transparent 50%, var(- -accentBg) 50%),
		linear-gradient(-225deg, transparent 50%, var(- -accentBg) 50%),
		linear-gradient(var(- -accentBg) 42%, var(- -accentFg) 42%);
	background-repeat: no-repeat, no-repeat, no-repeat, no-repeat;
	background-size: 1px 100%, 20px 22px, 20px 22px, 20px 100%;
	background-position: right 20px center, right bottom, right bottom,
		right bottom;
}
</style>
<script type="text/javascript">

function checkFlag() {
<%ArrayList<String> manList = (ArrayList<String>) session.getAttribute("manList");
			ArrayList<String> deptList = (ArrayList<String>) session.getAttribute("deptList");
			ArrayList<String> jobList = (ArrayList<String>) session.getAttribute("jobList");

			String msgErr = (String) session.getAttribute("createFlag");%>

	var cmsg = "<%=msgErr%>";
		if (cmsg !== "null") {
			<%session.setAttribute("createFlag", "null");%>
			alert(cmsg);
		}
	}
	function validateForm() {
		var age = document.forms["createEmpForm"]["age"].value;
		var contactNo = document.forms["createEmpForm"]["contactNo"].value;
		var hZipCode = document.forms["createEmpForm"]["hZipCode"].value;
		var wZipCode = document.forms["createEmpForm"]["wZipCode"].value;
		var ssn = document.forms["createEmpForm"]["ssn"].value;

		//-------------------AGE-------------------
		if (age.length != 2) {
			document.forms["createEmpForm"]["age"].value = "";
			document.forms["createEmpForm"]["age"].focus();
			alert("Age length should be 2 digits. Try again...");
			return false;
		}

		if (age < 18 | age > 70) {
			document.forms["createEmpForm"]["age"].value = "";
			document.forms["createEmpForm"]["age"].focus();
			alert("Age should be in between 18 to 70. Try again...");
			return false;
		}

		//-------------------CONTACT NO-------------------
		if (contactNo.length != 10) {
			document.forms["createEmpForm"]["contactNo"].value = "";
			document.forms["createEmpForm"]["contactNo"].focus();
			alert("Contact No length should be 10 digits. Try again...");
			return false;
		}
		
		if (contactNo < 1000000000) {
			document.forms["createEmpForm"]["contactNo"].value = "";
			document.forms["createEmpForm"]["contactNo"].focus();
			alert("Invalid Contact No format. Try again...");
			return false;
		}

		//-------------------HOME ZIPCODE-------------------
		if (hZipCode.length != 5) {
			document.forms["createEmpForm"]["hZipCode"].value = "";
			document.forms["createEmpForm"]["hZipCode"].focus();
			alert("ZipCode(Home Address) length should be 5 digits. Try again...");
			return false;
		}
		
		//-------------------WORK ZIPCODE-------------------
		if (wZipCode.length != 5) {
			document.forms["createEmpForm"]["wZipCode"].value = "";
			document.forms["createEmpForm"]["wZipCode"].focus();
			alert("ZipCode(Work Address) length should be 5 digits. Try again...");
			return false;
		}
		
		//-------------------SSN-------------------
		if (ssn.length != 9) {
			document.forms["createEmpForm"]["ssn"].value = "";
			document.forms["createEmpForm"]["ssn"].focus();
			alert("SSN length should be 9 digits. Try again...");
			return false;
		}
	}
	
	function TFCheck() {
    	if (document.getElementById('isManT').checked) {
        	document.getElementById('reporTo').style.visibility  = 'hidden';
    	} else {
    		document.getElementById('reporTo').style.visibility  = 'visible';
		}
	}
</script>
</head>
<body onload="checkFlag()">
	<hr>
	<h1>Create Employee</h1>
	<hr>
	<button class="customBtn" onclick="window.location='adminHome.jsp'">Admin
		Home</button>
	<hr>
	<br>
	<form name="createEmpForm" action="Create" method="post"
		autocomplete="off" onsubmit="return validateForm()">
		<fieldset>
			<legend class="legend">Employee Details</legend>
			<br>
			<table class="center">
				<tr>
					<th>Employee Name :</th>
					<th><input type="text" name="name" required autofocus /><br></th>
				</tr>
				<tr>
					<th>Age :</th>
					<th><input type="number" name="age" required /><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Gender :</th>
					<th><select name="gender">
							<option value="1">MALE</option>
							<option value="2">FEMALE</option>
							<option value="3">OTHERS</option>
					</select><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Contact Number :</th>
					<th><input type="number" name="contactNo"
						placeholder="(XXX) XXX-XXXX" required /><br></th>
				</tr>
				<tr>
					<th>Home Address :</th>
					<th><input type="text" name="hStreet" placeholder="Street"
						required /></th>
					<th><input type="text" name="hCity" placeholder="City"
						required /></th>
					<th><input type="text" name="hState" placeholder="State"
						required /></th>
				</tr>
				<tr>
					<th></th>
					<th><input type="text" name="hCountry" placeholder="Country"
						required /></th>
					<th><input type="number" name="hZipCode" placeholder="ZipCode"
						required /></th>
				</tr>
				<tr>
					<th>Work Address :</th>
					<th><input type="text" name="wStreet" placeholder="Street"
						required /></th>
					<th><input type="text" name="wCity" placeholder="City"
						required /></th>
					<th><input type="text" name="wState" placeholder="State"
						required /></th>
				</tr>
				<tr>
					<th></th>
					<th><input type="text" name="wCountry" placeholder="Country"
						required /></th>
					<th><input type="number" name="wZipCode" placeholder="ZipCode"
						required /><br></th>
				</tr>
				<tr>
					<th>SSN :</th>
					<th><input type="number" name="ssn" placeholder="XXX-XX-XXXX"
						required /><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Job Title :</th>
					<th><select name="jobTitle">
							<%
									for (int i = 1; i <= jobList.size(); i++) {
								%>
							<option value="<%=i%>">
								<%=jobList.get(i - 1)%></option>
							<%
									}
								%>
					</select><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Department :</th>
					<th><select name="dept">
							<%
									for (int i = 1; i <= deptList.size(); i++) {
								%>
							<option value="<%=i%>">
								<%=deptList.get(i - 1)%></option>
							<%
									}
								%>
					</select><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Salary :</th>
					<th><input type="number" name="salary" placeholder="XXXX.XX"
						required /><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>isManager :</th>
					<th><fieldset id="isManTF">
							<input type="radio" id="isManT" name="isManTF" value="1"
								onclick="javascript:TFCheck();"> True <input
								type="radio" id="isManF" name="isManTF" value="0"
								onclick="javascript:TFCheck();" checked> False
						</fieldset></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Manager ReportTo Id :</th>
					<th><select id="reporTo" name="reportTo">
							<%
									for (int i = 1; i <= manList.size(); i++) {
										String[] manId = manList.get(i - 1).split(":");
								%>
							<option value="<%=manId[1].trim()%>">
								<%=manList.get(i - 1)%></option>
							<%
									}
								%>
					</select><br></th>
				</tr>
			</table>
			<br> <br> <input type="submit" value="Create Employee" />
			<br>
		</fieldset>
	</form>
</body>
</html>