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
	<script src="../../CSS/script.js"></script>
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
		<a href="activelistings.jsp" class="active">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<br><br>
	<a href="allListings.jsp" class='button' style="margin-left:44.75%; width:150px; font-family: 'Trebuchet MS', sans-serif;">Display all Items</a>
	<h3>--OR--</h3>
	<h1 style="background-color: white; font-family: 'Trebuchet MS', sans-serif;">Search device by type</h1>
	<div class="rowst">
		<div class="columnst"><img src="../../Images/phones.webp" width=250 height=250><br><br><a href="searchphone.jsp">Search Phones</a></div>
		<div class="columnst"><img src="../../Images/laptops.webp" width=250 height=250><br><br><a href="searchlaptop.jsp">Search Laptops</a></div>
		<div class="columnst"><img src="../../Images/desktops.jfif" width=250 height=250><br><br><a href="searchdesktop.jsp">Search Desktops</a></div>			
	</div>
</body>
</html>