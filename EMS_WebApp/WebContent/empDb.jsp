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
</style>
<script type="text/javascript">
	function loadDB() {
<%String[][] empDb = (String[][]) session.getAttribute("empDb");%>
	}
</script>
</head>
<body onload="loadDB()">
	<br>
	<hr>
	<h1>Employee Database</h1>
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
				<th>isManager</th>
				<th>ReportTo Id</th>
			</tr>
			<%
				for (int i = 0; i < empDb.length; i++) {
			%>
			<tr>
				<td><%=empDb[i][0]%></td>
				<td><%=empDb[i][1]%></td>
				<td><%=empDb[i][2]%></td>
				<td><%=empDb[i][3]%></td>
				<td><%=empDb[i][4]%></td>

				<td><%=empDb[i][5]%>, <%=empDb[i][6]%>, <%=empDb[i][7]%>, <%=empDb[i][8]%>
					[<%=empDb[i][9]%>]</td>

				<td><%=empDb[i][10]%>, <%=empDb[i][11]%>, <%=empDb[i][12]%>, <%=empDb[i][13]%>
					[<%=empDb[i][14]%>]</td>

				<td><%=empDb[i][15]%></td>
				<td><%=empDb[i][16]%></td>
				<td><%=empDb[i][17]%></td>
				<td><%=empDb[i][18]%></td>
				<td><%=empDb[i][19]%></td>
				<td><%=empDb[i][20]%></td>
				<td><%=empDb[i][21]%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>