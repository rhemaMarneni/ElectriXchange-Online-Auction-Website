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
	<!-- NAV BAR -->
	<div class="topnav">
		<a href="../CreateAuction/createauction.jsp">Create Auction</a>
		<a href="activelistings.jsp">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp" class="active">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<h1 style="background-color: white;">Site-wide Auction History</h1>
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			String query = "SELECT * from auctions;";
			ResultSet rs = st.executeQuery(query);
	%>
	<table>
		<tr>
			<th><b>Auction ID</b></th>
			<th><b>Seller</b></th>
			<th><b>Current Price</b></th>
			<th><b>Highest Bidder</b></th>
			<th><b>End Date</b></th>
			<!-- <th><b>Status</b></th> -->
		</tr>
		<%while(rs.next()){ %>
			<tr>
				<td><%= rs.getString("auction_id")%></td>
				<td><%= rs.getString("seller")%></td>
				<td><%= rs.getString("current_price")%></td>
				<td><%= rs.getString("buyer")%></td>
				<td><%= rs.getString("end_date")%></td>
			</tr>
		<%}con.close(); 
		%>
	</table>
	<% }catch(Exception e){
		out.println(e);
	}%>
</body>
</html>