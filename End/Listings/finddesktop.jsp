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
	<h1 style="background-color: white; font-family: 'Trebuchet MS', sans-serif;">Desktop Auctions Found:</h1>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs;
			
			//take all search parameters
			String condition = request.getParameter("condition");
			if(condition.equals("any")){
				condition = "item_condition";
			}
			else{
				condition = "'" + condition + "'";
			}
			String brand = request.getParameter("brand");
			if(brand.equals("")){
				brand = "brand";
			}
			else{
				brand = "'" + brand + "'";
			}
			String color = request.getParameter("color");
			if(color.equals("")){
				color = "color";
			}
			else{
				color = "'" + color + "'";
			}
			String ram = request.getParameter("ram");
			if(ram.equals("any")){
				ram = "ram";
			}
			else{
				ram = "'" + ram + "'";
			}
			String os = request.getParameter("os");
			if(os.equals("os")){
				os = "os";
			}
			else{
				os = "'" + os + "'";
			}
			String storage = request.getParameter("storage");
			if(storage.equals("any")){
				storage = "storagetype";
			}
			else{
				storage = "'" + storage + "'";
			}
			String other = request.getParameter("other");
			if(other.equals("any")){
				other = "otherparts";
			}
			else{
				other = "'" + other + "'";
			}
			String touch = request.getParameter("touch");
			if(other.equals("any")){
				touch = "touch";
			}
			else{
				touch = "'" + touch + "'";
			}
			String price = request.getParameter("maxPrice");
			if(price.equals("")){
				price = "current_price";
			}
			else{
				price = "'" + price + "'";
			}
			//creating search query
			String query;
			if(request.getParameter("sort").equals("priceHighToLow")){
				query = "select * from auctions a natural join " + 
						"(select * from items i natural join desktops p where i.item_id = p.item_id) p " +
						" where a.item_id = p.item_id and now() < end_date and " +
						"item_condition = " + condition + " and brand = " + brand + " and color = " + color +
						" and ram = " + ram + " and os = " + os + " and storagetype = " + storage +
						" and otherparts = " + other + " and touchscreen = " + touch + " and current_price <= " + price + " order by current_price desc";
			}
			else{
				query = "select * from auctions a natural join " + 
						"(select * from items i natural join desktops p where i.item_id = p.item_id) p " +
						" where a.item_id = p.item_id and now() < end_date and " +
						"item_condition = " + condition + " and brand = " + brand + " and color = " + color +
						" and ram = " + ram + " and os = " + os + " and storagetype = " + storage +
						" and otherparts = " + other + " and touchscreen = " + touch + " and current_price <= " + price + " order by current_price asc";
			}
			
			//execute search query
			rs = st.executeQuery(query);
			
			//display the auctions if found and allow bidding
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
					<th>Extra Parts Included?</th>
					<th>Touch Screen</th>
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
					<td><%= rs.getString("other")%></td>
					<td><%= rs.getString("touch")%></td>
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
						<td><%= rs.getString("other")%></td>
						<td><%= rs.getString("touch")%></td>
						<td>$<%= rs.getString("current_price")%></td>
						<td><%= rs.getString("end_date")%></td>
						<td><input type="hidden" name="auction_id" value="<%= rs.getString("auction_id")%>"/>
						<input type="submit" value="Bid" class="button"></td>						
					</tr>
				<%} %>
			</table>
		</form>
		<div style="text-align: center">
			<br><br>
				<a href="activelistings.jsp" class='button' style="margin-left:46%;">All Listings</a>
			</div>
		<%} else{%>
			<div style="text-align: center">
				No such auctions exist<br><br>
				<a href="searchdesktop.jsp" class='button' style="margin-left:46%;">Try Again</a>
			</div>
		<%}%>
</body>
</html>