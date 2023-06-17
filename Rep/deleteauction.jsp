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
		<%
			String auction_id = request.getParameter("auctionid");
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from auctions where auction_id='"+auction_id+"'");
			//if auctionid does not exist
			if(!rs.next()){
				out.println("There is no such auction<br><br><a href='auctions.jsp' class='button'>Try again</a>");
			}
			else{
				String query = "delete from actions where auction_id='"+auction_id+"'";
				PreparedStatement ps = con.prepareStatement(query);
				ps.executeUpdate();
				con.close();
				out.println("Auction #"+auction_id+" was successfully deleted<br><br><a href='auctions.jsp' class='button'>Try again</a>");
			}
		%>
	</div>
	<br><br>

</body>
</html>