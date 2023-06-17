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
	<script src="../../CSS/script.js"></script>
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
		<a href="custservice.jsp" class="active">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<br><br>
	<h1 style='background-color:white;'>My Unanswered Questions</h1>
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			String username = (String)session.getAttribute("user");
			String query = "select * from ask where customer_username=? and answer is null";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,username);
			ResultSet rs = ps.executeQuery();
	%>
	<ul>
		<%while(rs.next()){ %>
			<li><%=rs.getString("question") %></li>
		<%} con.close(); %>
	</ul>
	<%}catch(Exception e){ 
		out.println(e);		
	}%>
	<br>
	<br>
	<div style='margin-left:48%;'>
		<a href='custservice.jsp' class='button'>Back</a>
	</div>
</body>
</html>