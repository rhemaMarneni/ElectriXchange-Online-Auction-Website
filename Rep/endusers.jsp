<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Rep: End users</title>
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
		<a href="endusers.jsp" class="active">Manage End users</a>
		<a href="auctions.jsp">Manage Auctions</a>
		<a href="service.jsp">Customer Service</a>
		<a href="rephome.jsp" style="background-color: black; color:white; font-weight:bold; border-style: none; text-align:center;">HOME PAGE</a>
		
	</div>
	<div class="body-content">
		This page lets you view end users, delete end-user account, and edit end-user information<br>
		<!-- LIST OF ALL END USERS -->
		<h2>List of all End Users</h2>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from users where acct_type = 'end';");
		%>
		<table>
			<tr>
				<th>Name</th>
				<th>Username</th>
				<th>Password</th>
			</tr>	
			<%
				while(rs.next()){
			%>
				<tr>
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getString("username") %></td>
					<td><%=rs.getString("password") %></td>
				</tr>
				<%}
			%>	
		</table>
		<%con.close(); %>
		<br><hr>
		<!-- DELETE END USER ACCOUNT -->
		<h2>Delete an End User account</h2>
   		<h4><mark>!!! Warning... This will permanently remove the Customer Representative from the database!!!</mark></h4>
		<form action="repdeleteuser.jsp" method="post">
			<b>Enter Username:</b><br> <input type="text" name="username1" required/><br>
			<b>Re-Enter Username:</b><br> <input type="text" name="username2" required/><br>
			<input type="submit" value="Submit"/>
		</form>
		<!-- EDIT USER INFO -->
		<br><hr>
		<h2>Edit End User account</h2>
		<b>Note:</b>If only one field needs to be edited, enter old credentials in the remaining fields<br><br>
		<form action="edituserinfo.jsp" method="post">
			<b>Old Username:</b><br><input type="text" name="username1" required/><br>
			<b>New Username:</b><br><input type="text" name="username2" required/><br>
			<b>New Password:</b><br><input type="password" name="password" required/><br>
			<b>New Name:</b><br><input type="text" name="name" required/><br>
			<input type="submit" value="Submit"/>
		</form>
	</div>
	<br><br>

</body>
</html>