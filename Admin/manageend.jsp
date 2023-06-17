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
		<a href = "manageend.jsp" class="active">Manage End Users</a>
		<a href = "manageauctions.jsp">View Auctions</a>
		<a href = "generatesales.jsp">Generate Sales Reports</a>
	</div>
	<div class="body-content">
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
		<hr>
		<!-- DELETE END USER ACCOUNT -->
		<h2>Delete an End User account</h2>
   		<h4><mark>!!! Warning... This will permanently remove the Customer Representative from the database!!!</mark></h4>
		<form action="deleteuser.jsp" method="post">
			Enter Username:<br> <input type="text" name="username1"/><br>
			Re-Enter Username:<br> <input type="text" name="username2"/><br>
			<input type="submit" value="Submit"/>
		</form>
	</div>
	<br>
	<br>

</body>
</html>