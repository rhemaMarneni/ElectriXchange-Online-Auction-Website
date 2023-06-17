<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import ="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>ElectriXchange</title>
	<link rel="shortcut icon" href="../../Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="../../CSS/homestyle.css"/>
	<link rel='stylesheet' href="../../CSS/adminstyle.css"/>
	<link rel='stylesheet' href="../../CSS/repstyle.css"/>
	<link rel='stylesheet' href="../../CSS/endstyle.css"/>
</head>
<body>
	<div class="header">
  		<a href="../endhome.jsp" class="logo">electriXchange</a>
  		<div class="header-right-logout">
	    	<a href="../../index.jsp">Logout</a>	   
  		</div>
  		<div class="username">
			<p><b><% 
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
	<div class="topnav">
		<a href="../CreateAuction/createauction.jsp">Create Auction</a>
		<a href="../Listings/activelistings.jsp">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="endprofile.jsp" class="active">My Profile</a>
	</div>
	<div class="container">
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
		Statement st1 = con.createStatement();
		Statement st2 = con.createStatement();
		ResultSet rs1, rs2;
		
		String user = (String)session.getAttribute("user");
		rs1 = st1.executeQuery("select name, username, password from users where username='"+user+"'");
		%>
		<h1>Your Details</h1><br>
		<%if(rs1.next()){ %>
			<b>Username: </b><%= rs1.getString("username") %><br><br>
			<b>Name: </b><%= rs1.getString("name") %><br><br>
			<b>Password: </b><%= rs1.getString("password") %><br><br>
		<%} %>
		<br>
		<h1>Edit Account Info</h1>
		<h3 style="text-align: left;">Change Name:</h3>
		<form action="changename.jsp" method="POST">
			Enter a new name:<br><input type="text" name="name" required/> <br><br>
			Password: <br><input type="password" name="password" required/> <br><br>
        	<input type="submit" value="Submit"/>
		</form>
		<br><hr><br>
		<h3 style="text-align: left;">Change Username:</h3>
		<form action="changeusername.jsp" method="POST">
			New Username:<br> <input type="text" name="new_username" required/> <br/><br/>
        	Password:<br>	<input type="password" name="password" required/> <br/><br/>
        	<input type="submit" value="Submit"/>
     	</form>
     	<br><br><hr><br>
		<h3 style="text-align: left;">Change Password:</h3>
		<form action="changepass.jsp" method="POST">
        	Old Password:<br>	<input type="password" name="old_pass" required/> <br/><br/>
        	New Password:<br> <input type="password" name="new_pass1" required/> <br/><br/>
        	Repeat New Password:<br> <input type="password" name="new_pass2" required/><br/><br/>
        	<input type="submit" value="Submit"/><br>
     	</form>
		<br><br>
		<h1>Delete Account</h1>
		<h4>!!! Warning... This will permanently remove your profile from the database!!!</h4>
		<form action="deleteaccount.jsp" method="POST">
        	 Enter Password:<br><input type="password" name="password" required/> <br/><br/>
        	<input type="submit" value="Delete" style="background-color:#be0000; color:white;"/>
     	</form>
	</div>	
</body>
</html>