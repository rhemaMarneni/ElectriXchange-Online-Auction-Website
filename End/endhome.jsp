<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import ="java.util.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
	Statement st1 = con.createStatement();
	Statement st2 = con.createStatement();
	ResultSet rs1, rs2;
	
	String user = (String)session.getAttribute("user");
	rs1 = st1.executeQuery("select alert_message from alerts where username='"+user+"'");
	rs2 = st2.executeQuery("select name, current_price, end_date from auctions natural join items where end_date>now() and seller='"+user+"'");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Home Page</title>
	<link rel="shortcut icon" href="../Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="../CSS/homestyle.css"/>
	<link rel='stylesheet' href="../CSS/adminstyle.css"/>
	<link rel='stylesheet' href="../CSS/repstyle.css"/>
	<link rel='stylesheet' href="../CSS/endstyle.css"/>
</head>
<body>
	<div class="header">
  		<a href="endhome.jsp" class="logo">electriXchange</a>
  		<div class="header-right-logout">
	    	<a href="../index.jsp">Logout</a>	    
  		</div>
  		<div class="username">
			<p><b><% 
				String userid = (String)session.getAttribute("user");
				if(userid==null)
				{
			    	response.sendRedirect("../index.jsp");
			    	return;
				}
				else{
					out.println("Welcome, " + userid);
				}
				%>&nbsp;&nbsp;</b></p>		
		</div>
	</div>
	<div class="topnav">
		<a href="CreateAuction/createauction.jsp">Create Auction</a>
		<a href="Listings/activelistings.jsp">Active Listings</a>
		<a href="BidHistory/bidhistory.jsp">Auction Histories</a>
		<a href="CustService/custservice.jsp">Customer Service</a>
		<a href="Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<div>
		<img src="../Images/mainimage.jpg" alt="mainImage" width=100% height=100%/>
	</div>
	<div class="rowstyle" style="font-family: 'Trebuchet MS', sans-serif;">
		<div class="columnstyle">
			<h1>My Auction Listings</h1>
			<%if(!rs2.isBeforeFirst()){%>
				<p><em>[You have no live auctions]</em></p>
			<%}else{ %>
				<table>
					<tr>
						<th>Item</th>
						<th>Current Bid</th>
						<th>End Date</th>
					</tr>
					<%while(rs2.next()){ %>
					<tr>
						<td><%= rs2.getString("name") %></td>
						<td>$<%= rs2.getString("current_price")%></td>
						<td><%= rs2.getString("end_date")%></td>
					</tr>
					<%} %>
				</table>
			<%} %>
		</div>
		<div class="columnstyle">
			<h1>My Alerts</h1>
			<%if(!rs1.isBeforeFirst()){%>
				<p><em>[You have no alerts]</em></p>
			<%}else{ %>
				<table>
					<%while(rs1.next()){ %>
					<tr>
						<td><%= rs1.getString("alert_message") %></td>
					</tr>
					<%} %>
				</table>
			<%} %>
		</div>
	</div>
	<br><br>
</body>
</html>