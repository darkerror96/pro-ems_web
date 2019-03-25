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
<%String[][] searchJob = (String[][]) session.getAttribute("searchJob");%>
	}
</script>
</head>
<body onload="loadDB()">
	<hr>
	<h1>
		Search by '<%=searchJob[0][0]%>' as Job Title
	</h1>
	<hr>
	<button class="customBtn" onclick="window.location='searchEmp.jsp'">Search</button>
	<hr>
	<br>
	<div class="table-responsive">
		<table
			class="table table-dark table-striped table-bordered table-hover">
			<tr>
				<th>Job Title</th>
				<th>Employee Id</th>
				<th>Name</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Contact No</th>
				<th>Home Address</th>
				<th>Work Address</th>
				<th>SSN</th>
				<th>eMail</th>
				<th>Department</th>
				<th>Salary</th>
				<th>isManager</th>
				<th>ReportTo Id</th>
			</tr>
			<%
				for (int i = 0; i < searchJob.length; i++) {
			%>
			<tr>
				<td><%=searchJob[i][0]%></td>
				<td><%=searchJob[i][1]%></td>
				<td><%=searchJob[i][2]%></td>
				<td><%=searchJob[i][3]%></td>
				<td><%=searchJob[i][4]%></td>

				<td><%=searchJob[i][5]%>, <%=searchJob[i][6]%>, <%=searchJob[i][7]%>,
					<%=searchJob[i][8]%> [<%=searchJob[i][9]%>]</td>

				<td><%=searchJob[i][10]%>, <%=searchJob[i][11]%>, <%=searchJob[i][12]%>,
					<%=searchJob[i][13]%> [<%=searchJob[i][14]%>]</td>
				<td><%=searchJob[i][15]%></td>
				<td><%=searchJob[i][16]%></td>
				<td><%=searchJob[i][17]%></td>
				<td><%=searchJob[i][18]%></td>
				<td><%=searchJob[i][19]%></td>
				<td><%=searchJob[i][20]%></td>
				<td><%=searchJob[i][21]%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>