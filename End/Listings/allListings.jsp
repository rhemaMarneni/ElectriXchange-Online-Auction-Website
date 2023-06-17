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
		<a href="activelistings.jsp" class="active">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<h1 style="background-color: white; font-family: 'Trebuchet MS', sans-serif;">All Live Auctions Found:</h1>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs;
			
			String query = "select * from auctions a natural join items i where " +
			"a.item_id = i.item_id and now() < end_date";
			
			//execute search query
			rs = st.executeQuery(query);
			
			//display all active listings
			if(rs.next()){
		%>
		<form action = "biditem.jsp" method = "post">
			<table>
				<tr>
					<th>Auction ID</th>
					<th>Item Name</th>
					<th>Item Condition</th>
					<th>Brand</th>
					<th>Color</th>
					<th>RAM</th>
					<th>OS</th>
					<th>Storage Capacity</th>
					<th>Current Price</th>
					<th>Auction End Date</th>
					<th></th>
				</tr>
				<tr>
					<td><%= rs.getString("auction_id") %></td>
					<td><%= rs.getString("name")%></td>
					<td><%= rs.getString("item_condition")%></td>
					<td><%= rs.getString("brand")%></td>
					<td><%= rs.getString("color")%></td>
					<td><%= rs.getString("ram")%></td>
					<td><%= rs.getString("os")%></td>
					<td><%= rs.getString("storagetype")%></td>
					<td>$<%= rs.getString("current_price")%></td>
					<td><%= rs.getString("end_date")%></td>
					<td><input type="hidden" name="auction_id" value="<%= rs.getString("auction_id")%>"/>
					<input type="submit" value="Bid" class="button"></td>
				</tr>
				<%while(rs.next()){ %>
					<tr>
						<td><%= rs.getString("auction_id") %></td>
						<td><%= rs.getString("name")%></td>
						<td><%= rs.getString("item_condition")%></td>
						<td><%= rs.getString("brand")%></td>
						<td><%= rs.getString("color")%></td>
						<td><%= rs.getString("ram")%></td>
						<td><%= rs.getString("os")%></td>
						<td><%= rs.getString("storagetype")%></td>
						<td>$<%= rs.getString("current_price")%></td>
						<td><%= rs.getString("end_date")%></td>	
						<td><input type="hidden" name="auction_id" value="<%= rs.getString("auction_id")%>"/>
						<input type="submit" value="Bid" class="button"></td>				
					</tr>
				<%} %>
			</table>
			</form>
		<%} else{%>
			<div style="text-align: center">
				No auctions currently listed<br><br>
				<a href="activelistings.jsp" class='button' style="margin-left:46%;">Okay</a>
			</div>
		<%}%>
</body>
</html>