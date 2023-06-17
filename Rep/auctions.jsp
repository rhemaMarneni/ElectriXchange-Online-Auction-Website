<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Rep: Auctions</title>
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
	<div class="sidebar">
		<a href="endusers.jsp" class="actclassive">Manage End users</a>
		<a href="auctions.jsp" class="active">Manage Auctions</a>
		<a href="service.jsp">Customer Service</a>
		<a href="rephome.jsp" style="background-color: black; color:white; font-weight:bold; border-style: none; text-align:center;">HOME PAGE</a>
		
	</div>
	<div class="body-content">
		<h2>List of Auction History</h2>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from auctions");
	%>
	<table>
		<tr>
			<th>Auction ID</th>
			<th>Seller</th>
			<th>Item ID</th>
			<th>Buyer</th>
			<th>Reserve Price</th>
			<th>Current/Sold Price</th>
			<th>Start Date</th>
			<th>End Date</th>
		</tr>
		<%while(rs.next()){ %>
		<tr>
			<td><%=rs.getString("auction_id") %></td>
			<td><%=rs.getString("seller") %></td>
			<td><%=rs.getString("item_id") %></td>
			<td><%=rs.getString("buyer") %></td>
			<td><%=rs.getString("reserve_price") %></td>
			<td><%=rs.getString("current_price") %></td>
			<td><%=rs.getString("start_date") %></td>
			<td><%=rs.getString("end_date") %></td>
		</tr>
		<%} %>
	</table>
	<br><hr>
	<h2>Delete Auction</h2>
	<h4><mark>!!! Warning... This will permanently remove the Customer Representative from the database!!!</mark></h4>
	<form action="deleteauction.jsp" method="post">
		<b>Enter Auction ID:</b><br><input type="text" name="auctionid" required/><br>
		<input type="submit" value="Submit"/>
	</form>
	<br><hr>
	<h2>Delete Bid</h2>
	<p>Delete a bid made by a certain username for a certain auction</p>
	<form action="deletebid.jsp" method="post">
		<b>Enter AuctionID:</b><br><input type="text" name="auctionid" required/><br>
		<b>Enter Username:</b><br><input type="text" name="userid" required/><br>
		<b>Enter Bid amount:</b><br><input type="text" name="amount" required/><br>
		<input type="submit" value="Submit"/>
	</form>
	</div>
	<br><br>

</body>
</html>