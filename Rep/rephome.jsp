<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Rep: Home Page</title>
	<link rel="shortcut icon" href="../Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="../CSS/homestyle.css"/>
	<link rel='stylesheet' href="../CSS/adminstyle.css"/>
	<link rel='stylesheet' href="../CSS/repstyle.css"/>
</head>
<body>
	<div class="header">
  		<a href="../index.jsp" class="logo">electriXchange</a>
  		<div class="header-right-logout">
	    	<a href="../index.jsp">Logout</a>		    
  		</div>
  		<div class="username">
				<p style="float:right;"><b><% 
				String userid = (String)session.getAttribute("user");
				if(userid==null)
				{
			    	response.sendRedirect("../../index.jsp");
			    	return;
				}
				else{
					out.println("Welcome, " + userid);
				}
				%>&nbsp;&nbsp;</b></p>
		</div>
	</div>
	<h1>Customer Representative Home Page</h1>
	<h3>Select an action below:</h3>
	<div class="rowstyle">
		<div class="columnstyle">
			<a href="endusers.jsp">Manage End users</a>
		</div>
		<div class="columnstyle">
			<a href="auctions.jsp">Manage Auctions</a>
		</div>
		<div class="columnstyle">
			<a href="service.jsp">Customer Service</a>
		</div>
	</div>
</body>
</html>