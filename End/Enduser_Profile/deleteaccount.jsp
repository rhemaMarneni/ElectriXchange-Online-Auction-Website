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
</head>
<body>
	<div class="header">
  		<a href="../endhome.jsp" class="logo">electriXchange</a>
	</div>
	<div class="container">
		<%
			String username = session.getAttribute("user").toString();
			String password = request.getParameter("password");
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root","password");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from users where username ='"+username+"' and password ='"+password+"'");
			
			//if username/password exists
			if(!rs.next()){
				out.println("Incorrect Password <br><br><a href='endprofile.jsp' class='button'>Try again</a>");
				con.close();
			}
			//else, update
			else{
				String query="delete from users where username='"+username +"'";
				PreparedStatement ps = con.prepareStatement(query);
				ps.executeUpdate();
				con.close();
				out.println("Your profile has been deleted<br><br><a href='endprofile.jsp' class='button'>Return to Login Page</a>");
				response.sendRedirect("../../index.jsp");
			}
		%>
	</div>
	
	
</body>
</html>