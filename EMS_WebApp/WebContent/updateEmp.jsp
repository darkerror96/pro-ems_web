<%@page import="com.collabera.db.StringConverter"%>
<%@page import="com.collabera.db.GetEmployee"%>
<%@page import="com.collabera.ems.model.Employee"%>
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
<title>Update Employee</title>
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

			String msgErr = (String) session.getAttribute("updateFlag");%>
	var umsg = "<%=msgErr%>";
		if (umsg !== "null") {
			<%session.setAttribute("updateFlag", "null");%>
			alert(umsg);
		}
	
	<%String eId = request.getParameter("eId");
			if (eId != null) {
				String[][] emp = GetEmployee.getEmployee(Integer.valueOf(eId));%>
	
			document.forms["updateEmpForm"]["eId"].value = "<%=emp[0][0]%>";
			document.forms["updateEmpForm"]["name"].value = "<%=emp[0][1]%>";
			document.forms["updateEmpForm"]["age"].value = "<%=emp[0][2]%>";
			
			<%int gender = 1;
				if (emp[0][3].equals("FEMALE")) {
					gender = 2;
				} else if (emp[0][3].equals("OTHERS")) {
					gender = 3;
				}%>
			document.forms["updateEmpForm"]["gender"].value = <%=gender%>;
			document.forms["updateEmpForm"]["contactNo"].value = "<%=emp[0][4]%>";
				
			document.forms["updateEmpForm"]["hStreet"].value = "<%=emp[0][5]%>";
			document.forms["updateEmpForm"]["hCity"].value = "<%=emp[0][6]%>";
			document.forms["updateEmpForm"]["hState"].value = "<%=emp[0][7]%>";
			document.forms["updateEmpForm"]["hCountry"].value = "<%=emp[0][8]%>";
			
			document.forms["updateEmpForm"]["hZipCode"].value = "<%=StringConverter.zipCodeConv(emp[0][9])%>";
				
			document.forms["updateEmpForm"]["wStreet"].value = "<%=emp[0][10]%>";
			document.forms["updateEmpForm"]["wCity"].value = "<%=emp[0][11]%>";
			document.forms["updateEmpForm"]["wState"].value = "<%=emp[0][12]%>";
			document.forms["updateEmpForm"]["wCountry"].value = "<%=emp[0][13]%>";
			
			document.forms["updateEmpForm"]["wZipCode"].value = "<%=StringConverter.zipCodeConv(emp[0][14])%>";
				
			document.forms["updateEmpForm"]["ssn"].value = "<%=StringConverter.ssnConv(emp[0][15])%>";
			
			document.forms["updateEmpForm"]["email"].value = "<%=emp[0][16]%>";
			
			<%int jobTitle = 0;
				for (int i = 1; i <= jobList.size(); i++) {
					if (jobList.get(i - 1).equals(emp[0][17])) {
						jobTitle = i;
						break;
					}
				}%>
			document.forms["updateEmpForm"]["jobTitle"].value = "<%=jobTitle%>";
		
			<%int dept = 0;
				for (int i = 1; i <= deptList.size(); i++) {
					if (deptList.get(i - 1).equals(emp[0][18])) {
						dept = i;
						break;
					}
				}%>
			document.forms["updateEmpForm"]["dept"].value = "<%=dept%>";
			
			
			document.forms["updateEmpForm"]["salary"].value = "<%=emp[0][19]%>";
			
			<%if (emp[0][20].equals("1")) {%>
			document.forms["updateEmpForm"]["isManT"].checked = true;
			document.forms["updateEmpForm"]["isManF"].checked = false;
			
			document.forms["updateEmpForm"]["isManF"].disabled = true;
			<%} else {%>
			document.forms["updateEmpForm"]["isManT"].checked = false;
			document.forms["updateEmpForm"]["isManF"].checked = true;
			<%}%>
			
			<%if (emp[0][20].equals("1")) {%>
			document.forms["updateEmpForm"]["reportTo"].style.display = "none";
			<%}%>
			document.forms["updateEmpForm"]["reportTo"].value = "<%=emp[0][21]%>";

	<%}%>

	}
	
	function validateForm() {
		var age = document.forms["updateEmpForm"]["age"].value;
		var contactNo = document.forms["updateEmpForm"]["contactNo"].value;
		var hZipCode = document.forms["updateEmpForm"]["hZipCode"].value;
		var wZipCode = document.forms["updateEmpForm"]["wZipCode"].value;
		var ssn = document.forms["updateEmpForm"]["ssn"].value;

		//-------------------AGE-------------------
		if (age.length != 2) {
			document.forms["updateEmpForm"]["age"].value = "";
			document.forms["updateEmpForm"]["age"].focus();
			alert("Age length should be 2 digits. Try again...");
			return false;
		}

		if (age < 18 | age > 70) {
			document.forms["updateEmpForm"]["age"].value = "";
			document.forms["updateEmpForm"]["age"].focus();
			alert("Age should be in between 18 to 70. Try again...");
			return false;
		}

		//-------------------CONTACT NO-------------------
		if (contactNo.length != 10) {
			document.forms["updateEmpForm"]["contactNo"].value = "";
			document.forms["updateEmpForm"]["contactNo"].focus();
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
			document.forms["updateEmpForm"]["hZipCode"].value = "";
			document.forms["updateEmpForm"]["hZipCode"].focus();
			alert("ZipCode(Home Address) length should be 5 digits. Try again...");
			return false;
		}
		
		//-------------------WORK ZIPCODE-------------------
		if (wZipCode.length != 5) {
			document.forms["updateEmpForm"]["wZipCode"].value = "";
			document.forms["updateEmpForm"]["wZipCode"].focus();
			alert("ZipCode(Work Address) length should be 5 digits. Try again...");
			return false;
		}
		
		//-------------------SSN-------------------
		if (ssn.length != 9) {
			document.forms["updateEmpForm"]["ssn"].value = "";
			document.forms["updateEmpForm"]["ssn"].focus();
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
	<h1>Update Employee</h1>
	<hr>
	<button class="customBtn" onclick="window.location='adminHome.jsp'">Admin
		Home</button>
	<hr>
	<br>
	<form name="updateEmpForm" action="Update" method="post"
		autocomplete="off" onsubmit="return validateForm()">
		<fieldset>
			<legend class="legend">Employee Details</legend>
			<br>
			<table class="center">
				<tr>
					<th>Employee Id :</th>
					<th><input type="text" id="eId" name="eId" readonly /><br></th>
				</tr>
				<tr>
					<th>Employee Name :</th>
					<th><input type="text" id="name" name="name" required
						autofocus /><br></th>
				</tr>
				<tr>
					<th>Age :</th>
					<th><input type="number" id="age" name="age" required /><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Gender :</th>
					<th><select name="gender" id="gender">
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
					<th><input type="number" name="contactNo" id="contactNo"
						placeholder="(XXX) XXX-XXXX" required /><br></th>
				</tr>
				<tr>
					<th>Home Address :</th>
					<th><input type="text" id="hStreet" name="hStreet"
						placeholder="Street" required /></th>
					<th><input type="text" id="hCity" name="hCity"
						placeholder="City" required /></th>
					<th><input type="text" id="hState" name="hState"
						placeholder="State" required /></th>
				</tr>
				<tr>
					<th></th>
					<th><input type="text" id="hCountry" name="hCountry"
						placeholder="Country" required /></th>
					<th><input type="number" id="hZipCode" name="hZipCode"
						placeholder="ZipCode" required /></th>
				</tr>
				<tr>
					<th>Work Address :</th>
					<th><input type="text" id="wStreet" name="wStreet"
						placeholder="Street" required /></th>
					<th><input type="text" id="wCity" name="wCity"
						placeholder="City" required /></th>
					<th><input type="text" id="wState" name="wState"
						placeholder="State" required /></th>
				</tr>
				<tr>
					<th></th>
					<th><input type="text" id="wCountry" name="wCountry"
						placeholder="Country" required /></th>
					<th><input type="number" id="wZipCode" name="wZipCode"
						placeholder="ZipCode" required /><br></th>
				</tr>
				<tr>
					<th>SSN :</th>
					<th><input type="number" id="ssn" name="ssn"
						placeholder="XXX-XX-XXXX" required /><br></th>
				</tr>
				<tr>
					<th>Employee eMail :</th>
					<th><input type="text" id="email" name="email" readonly /><br></th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th>Job Title :</th>
					<th><select name="jobTitle" id="jobTitle">
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
					<th><select name="dept" id="dept">
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
					<th><input type="number" id="salary" name="salary"
						placeholder="XXXX.XX" required /><br></th>
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
								onclick="javascript:TFCheck();"> False
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
			<br> <br> <input type="submit" value="Update Employee" />
			<br>
		</fieldset>
	</form>
</body>
</html>