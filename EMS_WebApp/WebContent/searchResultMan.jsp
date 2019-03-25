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
			
			<%String[][] searchMan = (String[][]) session.getAttribute("searchMan");
			String[][] searchManTeam = (String[][]) session.getAttribute("searchManTeam");
			String msgErr = (String) session.getAttribute("searchManFlag");%>
			
		var smmsg = "<%=msgErr%>
	";
		if (smmsg !== "null") {
<%session.setAttribute("searchManFlag", "null");%>
	alert(smmsg);
		}
	}
</script>
</head>
<body onload="loadDB()">
	<hr>
	<h1>
		Manager <%=searchMan[0][0]%>
	</h1>
	<hr>
	<button class="customBtn" onclick="window.location='searchEmp.jsp'">Search</button>
	<hr>
	<br>
	<div class="table-responsive">
		<table
			class="table table-dark table-striped table-bordered table-hover">
			<tr>
				<th>Name</th>
				<th>Employee Id</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Contact No</th>
				<th>Home Address</th>
				<th>Work Address</th>
				<th>SSN</th>
				<th>eMail</th>
				<th>Job Title</th>
				<th>Department</th>
				<th>Salary</th>
				<th>isManager</th>
				<th>ReportTo Id</th>
			</tr>
			<%
				for (int i = 0; i < searchMan.length; i++) {
			%>
			<tr>
				<td><%=searchMan[i][0]%></td>
				<td><%=searchMan[i][1]%></td>
				<td><%=searchMan[i][2]%></td>
				<td><%=searchMan[i][3]%></td>
				<td><%=searchMan[i][4]%></td>

				<td><%=searchMan[i][5]%>, <%=searchMan[i][6]%>, <%=searchMan[i][7]%>,
					<%=searchMan[i][8]%> [<%=searchMan[i][9]%>]</td>

				<td><%=searchMan[i][10]%>, <%=searchMan[i][11]%>, <%=searchMan[i][12]%>,
					<%=searchMan[i][13]%> [<%=searchMan[i][14]%>]</td>
				<td><%=searchMan[i][15]%></td>
				<td><%=searchMan[i][16]%></td>
				<td><%=searchMan[i][17]%></td>
				<td><%=searchMan[i][18]%></td>
				<td><%=searchMan[i][19]%></td>
				<td><%=searchMan[i][20]%></td>
				<td><%=searchMan[i][21]%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	<br>
	<hr>
	<h1>
		<%=searchMan[0][0]%>'s Team
	</h1>
	<hr>
	<br>
	<div class="table-responsive">
		<table
			class="table table-dark table-striped table-bordered table-hover">
			<tr>
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
				<th>Department</th>
				<th>Salary</th>
			</tr>
			<%
				for (int i = 0; i < searchManTeam.length; i++) {
			%>
			<tr>
				<td><%=searchManTeam[i][0]%></td>
				<td><%=searchManTeam[i][1]%></td>
				<td><%=searchManTeam[i][2]%></td>
				<td><%=searchManTeam[i][3]%></td>
				<td><%=searchManTeam[i][4]%></td>

				<td><%=searchManTeam[i][5]%>, <%=searchManTeam[i][6]%>, <%=searchManTeam[i][7]%>,
					<%=searchManTeam[i][8]%> [<%=searchManTeam[i][9]%>]</td>

				<td><%=searchManTeam[i][10]%>, <%=searchManTeam[i][11]%>, <%=searchManTeam[i][12]%>,
					<%=searchManTeam[i][13]%> [<%=searchManTeam[i][14]%>]</td>
				<td><%=searchManTeam[i][15]%></td>
				<td><%=searchManTeam[i][16]%></td>
				<td><%=searchManTeam[i][17]%></td>
				<td><%=searchManTeam[i][18]%></td>
				<td><%=searchManTeam[i][19]%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>