<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
<title>Search Employee</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

input[type=number], input[type=text] {
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: black;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	outline: none;
	margin-left: auto;
	margin-right: auto;
}

input[type=number]:focus, input[type=text]:focus {
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
	margin-left: 270%;
	width: 70%;
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

/*the container must be positioned relative:*/
.autocomplete {
	position: absolute;
	display: inline-block;
	text-align: center;
	margin-left: 41.5%;
	margin-top: -3.95%;
}

.autocomplete-items {
	position: absolute;
	border: 1px solid #d4d4d4;
	border-bottom: none;
	border-top: none;
	z-index: 99;
	top: 88.4%;
	left: 0;
	right: 0;
	overflow: auto;
	max-height: 195px;
}

.autocomplete-items div {
	padding: 10px;
	cursor: pointer;
	background-color: #fff;
	border-bottom: 1px solid #d4d4d4;
}

/*when hovering an item:*/
.autocomplete-items div:hover {
	background-color: #e9e9e9;
}

/*when navigating through the items using the arrow keys:*/
.autocomplete-active {
	background-color: DodgerBlue !important;
	color: #ffffff;
}
</style>
<script type="text/javascript">
function checkFlagLoadDb() {
	
	<%String[][] empDbEN = (String[][]) session.getAttribute("empDbEN");
			ArrayList<?> empList = (ArrayList<?>) session.getAttribute("empList");
			ArrayList<?> manList = (ArrayList<?>) session.getAttribute("manList");
			ArrayList<?> deptList = (ArrayList<?>) session.getAttribute("deptList");
			ArrayList<?> jobList = (ArrayList<?>) session.getAttribute("jobList");

			String smsgErr = (String) session.getAttribute("searchFlag");%>
		
	var emp = [ 
			<%for (int i = 0; i < empList.size(); i++) {%>
				"<%=empList.get(i)%>",
			<%}%>
		"" ];

	document.forms["searchEmpForm"]["searchInput"].placeholder = "Search by Employee Name";
	document.forms["searchEmpForm"]["searchInput"].focus();
	autocomplete(document.getElementById("searchInput"), emp);
			
	var smsg = "<%=smsgErr%>";
	if (smsg !== "null") {
		<%session.setAttribute("searchFlag", "null");%>
		alert(smsg);
	}
}

function radioCheck() {

	if (document.getElementById('sEmp').checked) {
    	
    	var emp = [ 
    			<%for (int i = 0; i < empList.size(); i++) {%>
    				"<%=empList.get(i)%>",
    			<%}%>
    		"" ];
    	
    	document.forms["searchEmpForm"]["searchInput"].value = "";
    	document.forms["searchEmpForm"]["searchInput"].placeholder = "Search by Employee Name";
    	document.forms["searchEmpForm"]["searchInput"].focus();
    	autocomplete(document.getElementById("searchInput"), emp);
	} else if (document.getElementById('sMan').checked) {
    	
		var manager = [ 
    			<%for (int i = 0; i < manList.size(); i++) {%>
    				"<%=manList.get(i)%>",
    			<%}%>
    		"" ];
		
		document.forms["searchEmpForm"]["searchInput"].value = "";
		document.forms["searchEmpForm"]["searchInput"].placeholder = "Search by Manager Name";
		document.forms["searchEmpForm"]["searchInput"].focus();
    	autocomplete(document.getElementById("searchInput"), manager);
	} else if (document.getElementById('sJobTitle').checked) {
		
		var job = [ 
				<%for (int i = 0; i < jobList.size(); i++) {%>
					"<%=jobList.get(i)%>",
				<%}%>
			"" ];
		
		document.forms["searchEmpForm"]["searchInput"].value = "";
		document.forms["searchEmpForm"]["searchInput"].placeholder = "Search by Job Title";
		document.forms["searchEmpForm"]["searchInput"].focus();
		autocomplete(document.getElementById("searchInput"), job);
	} else if (document.getElementById('sDept').checked) {
		
		var dept = [ 
				<%for (int i = 0; i < deptList.size(); i++) {%>
					"<%=deptList.get(i)%>",
				<%}%>
			"" ];
		
		document.forms["searchEmpForm"]["searchInput"].value = "";
		document.forms["searchEmpForm"]["searchInput"].placeholder = "Search by Department";
		document.forms["searchEmpForm"]["searchInput"].focus();
		autocomplete(document.getElementById("searchInput"), dept);
	}
}
</script>
</head>
<body onload="checkFlagLoadDb()">
	<hr>
	<h1>Search Employee</h1>
	<hr>
	<button class="customBtn" onclick="window.location='adminHome.jsp'">Admin
		Home</button>
	<hr>
	<br>
	<form name="searchEmpForm" action="Search" method="post"
		autocomplete="off">
		<fieldset>
			<legend class="legend">Employee Search Engine</legend>
			<br>

			<table class="center">
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th><input type="radio" id="sEmp" name="sR" value="1"
						onclick="javascript:radioCheck();" checked> Search by
						Employee Name</th>

					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>

					<th><input type="radio" id="sMan" name="sR" value="2"
						onclick="javascript:radioCheck();"> Search by Manager Name</th>

					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>

					<th><input type="radio" id="sJobTitle" name="sR" value="3"
						onclick="javascript:radioCheck();"> Search by Job Title</th>

					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>

					<th><input type="radio" id="sDept" name="sR" value="4"
						onclick="javascript:radioCheck();"> Search by Department</th>
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
					<th><input type="submit" value="Search" /></th>
				</tr>
				<tr>
					<th></th>
				</tr>
				<tr>
					<th></th>
				</tr>
			</table>
			<div class="autocomplete" style="width: 250px;">
				<input id="searchInput" type="text" name="searchInput"
					style="width: 250px; text-align: center;" required>
			</div>
		</fieldset>
	</form>
	<jsp:include page="empDb.jsp" />
	<script>
	
function autocomplete(inp, arr) {
  var currentFocus;
  inp.addEventListener("input", function(e) {
      var a, b, i, val = this.value;
      
      closeAllLists();
      
      if (!val) { return false;}
      
      currentFocus = -1;
      a = document.createElement("DIV");
      a.setAttribute("id", this.id + "autocomplete-list");
      a.setAttribute("class", "autocomplete-items");
      this.parentNode.appendChild(a);
      
      for (i = 0; i < arr.length; i++) {
        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
          b = document.createElement("DIV");
          /*make the matching letters bold:*/
          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
          b.innerHTML += arr[i].substr(val.length);
          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
          /*execute a function when someone clicks on the item value (DIV element):*/
          b.addEventListener("click", function(e) {
              /*insert the value for the autocomplete text field:*/
              inp.value = this.getElementsByTagName("input")[0].value;
              closeAllLists();
          });
          a.appendChild(b);
        }
      }
  });
  
  /*execute a function when user presses a arrow-keys on the keyboard:*/
  inp.addEventListener("keydown", function(e) {
      var x = document.getElementById(this.id + "autocomplete-list");
      if (x) x = x.getElementsByTagName("div");
      if (e.keyCode == 40) {
        /*If the arrow DOWN key is pressed,
        increase the currentFocus variable:*/
        currentFocus++;
        addActive(x);
      } else if (e.keyCode == 38) { //up
        /*If the arrow UP key is pressed,
        decrease the currentFocus variable:*/
        currentFocus--;
        addActive(x);
      } else if (e.keyCode == 13) {
        /*If the ENTER key is pressed, prevent the form from being submitted,*/
        e.preventDefault();
        if (currentFocus > -1) {
          if (x) x[currentFocus].click();
        }
      }
  });
  
  function addActive(x) {
    if (!x) return false;
    
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    x[currentFocus].classList.add("autocomplete-active");
  }
  
  function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("autocomplete-active");
    }
  }
  
  function closeAllLists(elmnt) {
    var x = document.getElementsByClassName("autocomplete-items");
    for (var i = 0; i < x.length; i++) {
      if (elmnt != x[i] && elmnt != inp) {
        x[i].parentNode.removeChild(x[i]);
      }
    }
  }
  
  document.addEventListener("click", function (e) {
      closeAllLists(e.target);
  });
}

</script>
</body>
</html>
