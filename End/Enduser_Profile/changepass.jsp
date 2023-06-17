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
	<div class="topnav">
		<a href="../CreateAuction/createauction.jsp">Create Auction</a>
		<a href="../Listings/activelistings.jsp">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="endprofile.jsp" class="active">My Profile</a>
	</div>
	<div class="container">
		<%
			String username = session.getAttribute("user").toString();
			String old_password = request.getParameter("old_pass");
			String new_password1 = request.getParameter("new_pass1");
			String new_password2 = request.getParameter("new_pass2");
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root","password");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from users where username ='"+username+"' and password ='"+old_password+"'");
			
			//if username/password exists
			if(!rs.next()){
				out.println("Incorrect Password <br><br><a href='endprofile.jsp' class='button'>Try again</a>");
				con.close();
			}
			//if passwords don't match
			else if(!new_password1.equals(new_password2)){
				out.println("The new passwords do not match<br><br><a href='endprofile.jsp' class='button'>Try again</a>");
			}
			//else, update
			else{
				String query="update users set password='"+new_password1+"' where username='"+username+"'";
				PreparedStatement ps = con.prepareStatement(query);
				ps.executeUpdate();
				con.close();
				out.println("Password successfully changed<br><br><a href='endprofile.jsp' class='button'>Okay</a>");
			}
		%>
	</div>
	
	
</body>
</html>