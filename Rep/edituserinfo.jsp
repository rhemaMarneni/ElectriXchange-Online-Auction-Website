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
		<a href="repProfile.jsp">Manage Personal Profile</a>
		<a href="service.jsp">Customer Service</a>
		
	</div>
	<div class="body-content">
		<%
		String old_username = request.getParameter("username1");
		String new_username = request.getParameter("username2");
		String new_password = request.getParameter("password");
		String name = request.getParameter("name");
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from users where username='"+old_username+"' and acct_type = 'end';");
		
		//if old-username does not exist
		if(!rs.next()){
			out.println("User does not exist<br><br><a href='endusers.jsp' class='button'>Try again</a>");
		}
		//if invalid credentials
		else if(new_username.length()<3 || new_password.length()<3 || name.length()<3 || new_username.contains(" ") || new_password.contains(" ") || name.contains(" ")){
			out.println("Invalid credentials<br><br><a href='endusers.jsp' class='button'>Try again</a>");
		}
		//otherwise update info
		else{
			String query = "update users set username='"+new_username+"', password='"+new_password+"',name='"+name+"' where username='"+old_username+"'";
			PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();
			con.close();
			out.println("The old username: '"+old_username+ "' has been updated to: '"+new_username+"'");
			out.println("<br>The new password is: '" +new_password+"'");
			out.println("<br><br><a href='endusers.jsp' class='button'>Okay</a>");
		}
		%>
	</div>

</body>
</html>