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
			String userid1 = request.getParameter("username1");
			String userid2 = request.getParameter("username2");
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where username ='" + userid1+"' and acct_type='end';");
			
			//if invalid entries
			if(userid1.length()<3 || userid2.length()<3 || userid1.contains(" ") || userid2.contains(" ")){
				out.println("<b>Invalid Credentials</b> entered. Check your input<br><br><a href='endusers.jsp' class='button'>Try again</a>");
			}
			//if username does not exist
			else if(!rs.next()){
				out.println("Username does not exist<br><br><a href='endusers.jsp' class='button'>Try again</a>");
			}
			//if usernames don't match
			else if(!userid1.equals(userid2)){
				out.println("Username's do not match<br><br><a href='endusers.jsp' class='button'>Try again</a>");
			}
			//otherwise, delete from database
			else{
				String query = "delete from users where username='"+userid1+"' and acct_type='end'";
				PreparedStatement ps = con.prepareStatement(query);
				ps.executeUpdate();
				con.close();
				out.println("End user with username '"+ userid1 +"' <b>SUCCESSFULLY DELETED</b><br><br><a href='endusers.jsp' class='button'>Okay</a>");
			}
		%>
					
	</div>
	<br>
	<br>

</body>
</html>