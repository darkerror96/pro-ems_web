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
<style>
body {
	background: lightblue;
}

h1 {
	text-align: center;
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

table.dbTable, td.dbTable, th.dbTable {
	margin-left: auto;
	margin-right: auto;
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	padding: 5px;
}

table.dbTable tr:nth-child(even) {
	background-color: #aaa;
}

table.dbTable {
	background-color: black;
	color: white;
}
</style>
<script type="text/javascript">
	function loadDB() {
<%String[][] searchDept = (String[][]) session.getAttribute("searchDept");%>
	}
</script>
</head>
<body onload="loadDB()">
	<hr>
	<h1>
		Search by '<%=searchDept[0][0]%>' as Department
	</h1>
	<hr>
	<button class="customBtn" onclick="window.location='searchEmp.jsp'">Search</button>
	<hr>
	<br>
	<div class="table-responsive">
		<table
			class="table table-dark table-striped table-bordered table-hover">
			<tr>
				<th>Department</th>
				<th>Employee Id</th>
				<th>Name</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Contact No</th>
				<th>Home Address</th>
				<th>Work Address</th>
				<th>SSN</th>
				<th>eMail</th>
				<th>Job Title</th>
				<th>Salary</th>
				<th>isManager</th>
				<th>ReportTo Id</th>
			</tr>
			<%
				for (int i = 0; i < searchDept.length; i++) {
			%>
			<tr>
				<td><%=searchDept[i][0]%></td>
				<td><%=searchDept[i][1]%></td>
				<td><%=searchDept[i][2]%></td>
				<td><%=searchDept[i][3]%></td>
				<td><%=searchDept[i][4]%></td>

				<td><%=searchDept[i][5]%>, <%=searchDept[i][6]%>, <%=searchDept[i][7]%>,
					<%=searchDept[i][8]%> [<%=searchDept[i][9]%>]</td>

				<td><%=searchDept[i][10]%>, <%=searchDept[i][11]%>, <%=searchDept[i][12]%>,
					<%=searchDept[i][13]%> [<%=searchDept[i][14]%>]</td>
				<td><%=searchDept[i][15]%></td>
				<td><%=searchDept[i][16]%></td>
				<td><%=searchDept[i][17]%></td>
				<td><%=searchDept[i][18]%></td>
				<td><%=searchDept[i][19]%></td>
				<td><%=searchDept[i][20]%></td>
				<td><%=searchDept[i][21]%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>