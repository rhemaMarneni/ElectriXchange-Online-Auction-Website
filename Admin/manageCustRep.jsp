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
		<a href = "manageCustRep.jsp" class="active">Manage Customer Representatives</a>
		<a href = "manageend.jsp">Manage End Users</a>
		<a href = "manageauctions.jsp">View Auctions</a>
		<a href = "generatesales.jsp">Generate Sales Reports</a>
	</div>
	<div class="body-content">
		<!-- LIST OF ALL CUSTOMER REPRESENTATIVES -->
		<h2>List of all Customer Representatives</h2>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from users where acct_type='rep';");
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
			<%}%>
		
		</table>
		<br>
		<hr>
		
		<!-- CREATE NEW CUSTOMER REPRESENTATIVE -->
		<h2>Create a new Customer Representative</h2>
		<div>
   			<form action="newrep.jsp" method="POST">
   				Name:	<br><input type="text" name="name" required/><br>
       			Create Username:	<br><input type="text" name="username" size=34 required/><br>
       			Create Password:	<br><input type="password" name="password" size=34 required/><br>
       			Re-enter Password:	<br><input type="password" name="password2" size=34 required/><br>
       			<input type="submit" value="Submit"/>
     		</form>
   		</div>
   		<hr>
   		<!-- DELETE A CUSTOMER REPRESENTATIVE -->
   		<h2>Delete a Customer Representative</h2>
   		<h4><mark>!!! Warning... This will permanently remove the Customer Representative from the database!!!</mark></h4>
   		<div>
   			<form action="deleteRep.jsp" method="post">
   				Enter Username: <br><input type="text" name="username" size=34 required/><br>
   				Re-Enter Username: <br><input type="text" name="username2" size=34 required/><br>
   				<input type="submit" value="Submit"/>
   			</form>
   		</div>
	</div>
	<br>
	<br>

</body>
</html>