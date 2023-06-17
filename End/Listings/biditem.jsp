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
	<h1 style="background-color: white;">Bidding on an active listing</h1>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root","password");
		Statement st = con.createStatement();
		ResultSet rs;
		
		String thisID = request.getParameter("auction_id");
		String phone, laptop, desktop;
		phone = "select * from auctions a natural join (select * from items i natural join phones p" +
		" where i.item_id = p.item_id) p where a.auction_id = '" + thisID + "' and a.item_id=p.item_id";
		rs = st.executeQuery(phone);
		while(rs.next()){%>
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
					<th>Charger Included?</th>
					<th>Current Price</th>
					<th>Auction End Date</th>
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
					<td><%= rs.getString("charger")%></td>
					<td>$<%= rs.getString("current_price")%></td>
					<td><%= rs.getString("end_date")%></td>
				</tr>
			</table>
		<%}
		laptop = "select * from auctions a natural join (select * from items i natural join laptops p" +
				" where i.item_id = p.item_id) p where a.auction_id = '" + thisID + "' and a.item_id=p.item_id";
		rs = st.executeQuery(laptop);
		while(rs.next()){%>
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
					<th>Charger Included?</th>
					<th>Touch Screen</th>
					<th>Current Price</th>
					<th>Auction End Date</th>
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
					<td><%= rs.getString("charger")%></td>
					<td><%= rs.getString("touch")%></td>
					<td>$<%= rs.getString("current_price")%></td>
					<td><%= rs.getString("end_date")%></td>
				</tr>
			</table>
		<%}
		desktop = "select * from auctions a natural join (select * from items i natural join desktops p" +
			" where i.item_id = p.item_id) p where a.auction_id = '" + thisID + "' and a.item_id=p.item_id";
		rs = st.executeQuery(desktop);
		while(rs.next()){%>
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
					<th>Extra Parts Included?</th>
					<th>Touch Screen</th>
					<th>Current Price</th>
					<th>Auction End Date</th>
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
					<td><%= rs.getString("other")%></td>
					<td><%= rs.getString("touch")%></td>
					<td>$<%= rs.getString("current_price")%></td>
					<td><%= rs.getString("end_date")%></td>
				</tr>
			</table>
		<%}
	%>
	<div class="container">
		<p><b>Normal Bid</b><br>You can choose normal manual bidding for the item you wish to bid on. 
		In case no one bids as much as you, you will be the winner of the auction. Otherwise,
		you will be notified if you were outbid.</p>
		<form action="processbid.jsp" method="POST">
			Enter amount($): <input type = "number" step="0.1" name="bidamt"><br>
			<input type="hidden" name="auction_id" value="<%= thisID %>">
			<input type="submit" value="Submit">
		</form>
	</div>
	<div class="container">
		<p><b>Auto Bid</b><br>For a better chance at winning your auction, you can choose automatic manual bidding. 
		Unlike normal bids, you can specify a starting bid amount which automatically increases when someone else bids higher.
		In other words, the system can help you outbid your competitor. Set a maximum limit until which you are willing to raise your bid.
		In case no one bids as much as you, you will be the winner of the auction. Otherwise,
		you will be notified if you were outbid. However, you can set only one autobid at a time.</p>
		<form action="autobid.jsp" method="POST">
			Enter bid increment amount($): <input type = "number" step="0.1" name="bidinc"><br>
			Enter maximum amount limit($): <input type = "number" step="0.1" name="max"><br>
			<input type="hidden" name="auction_id" value="<%= thisID %>">
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>