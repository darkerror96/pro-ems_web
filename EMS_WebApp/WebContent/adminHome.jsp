<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>Admin Home</title>
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

.logoutBtn {
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

.logoutBtn:hover {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: black;
	background-color: lime;
	border-radius: 8px;
	cursor: pointer;
}

.customBtn {
	border: black;
	font-size: 20px;
	padding: 5px 22px;
	color: black;
	background-color: white;
	border-radius: 8px;
	cursor: pointer;
}

.customBtn:hover {
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

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 200px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	overflow: auto;
	max-height: 200px;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown a:hover {
	background-color: #e9e9e9;
}

.show {
	display: block;
}
</style>
<script type="text/javascript">
function checkFlag() {
	
	<%String[][] empDbEN = (String[][]) session.getAttribute("empDbEN");
			String amsgErr = (String) session.getAttribute("adminFlag");
			String cmsgErr = (String) session.getAttribute("createFlag");
			String umsgErr = (String) session.getAttribute("updateFlag");
			String dmsgErr = (String) session.getAttribute("deleteFlag");%>
		
		var amsg = "<%=amsgErr%>";
		if (amsg !== "null") {
			<%session.setAttribute("adminFlag", "null");%>
			alert(amsg);
		}
	
		var cmsg = "<%=cmsgErr%>";
		if (cmsg !== "null") {
			<%session.setAttribute("createFlag", "null");%>
			alert(cmsg);
		}
		
		var dmsg = "<%=dmsgErr%>";
		if (dmsg !== "null") {
			<%session.setAttribute("deleteFlag", "null");%>
			alert(dmsg);
		}
		
		var umsg = "<%=umsgErr%>";
		if (umsg !== "null") {
<%session.setAttribute("updateFlag", "null");%>
	alert(umsg);
		}
	}

	/* When the user clicks on the button, 
	 toggle between hiding and showing the dropdown content */
	function myFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

	// Close the dropdown if the user clicks outside of it
	window.onclick = function(event) {
		if (!event.target.matches('.customBtn')) {
			var dropdowns = document.getElementsByClassName("dropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}
</script>
</head>
<body onload="checkFlag()">
	<hr>
	<h1>Admin Dashboard</h1>
	<hr>
	<button class="logoutBtn" onclick="window.location='login.jsp'">Logout</button>
	<hr>
	<br>
	<fieldset>
		<legend class="legend">EMS Menu</legend>
		<table class="center">
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th><button class="customBtn"
						onclick="window.location.href='createEmp.jsp'">Create
						Employee</button> <br></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th><button class="customBtn"
						onclick="window.location.href='searchEmp.jsp' ">Search
						Employee</button> <br></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>

				<th>
					<div class="dropdown">
						<button onclick="myFunction()" class="customBtn">Update
							Employee</button>
						<div id="myDropdown" class="dropdown-content">

							<%
								for (int i = 0; i < empDbEN.length; i++) {

									if (Integer.valueOf(empDbEN[i][2]) == 1) {
							%>
							<a href="updateEmp.jsp?eId=<%=empDbEN[i][0]%>"><%=empDbEN[i][1]%>
								(Manager)</a>

							<%
								} else {
							%>
							<a href="updateEmp.jsp?eId=<%=empDbEN[i][0]%>"><%=empDbEN[i][1]%></a>
							<%
								}
								}
							%>
						</div>
					</div>
				</th>

				<th></th>
				<th></th>
				<th><button class="customBtn"
						onclick="window.location.href='deleteEmp.jsp' ">Delete
						Employee</button> <br>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
			<tr>
				<th></th>
			</tr>
		</table>
	</fieldset>
	<jsp:include page="empDb.jsp" />
</body>
</html>