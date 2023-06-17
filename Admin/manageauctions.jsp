<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Admin: Home Page</title>
	<link rel="shortcut icon" href="../Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="../CSS/homestyle.css"/>
	<link rel='stylesheet' href="../CSS/adminstyle.css"/>
</head>
<body>
	<div class="header">
  		<a href="index.jsp" class="logo">electriXchange</a>
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
		<a href = "manageCustRep.jsp">Manage Customer Representatives</a>
		<a href = "manageend.jsp">Manage End Users</a>
		<a href = "manageauctions.jsp" class="active">View Auctions</a>
		<a href = "generatesales.jsp">Generate Sales Reports</a>
	</div>
	<div class="body-content">
	<!-- list of auction history -->
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
		

	</div>
	<br>
	<br>

</body>
</html>