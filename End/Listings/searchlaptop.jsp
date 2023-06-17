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
			<p><b>Welcome, <%out.println(session.getAttribute("user").toString()); 
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
	<!-- NAV BAR -->
	<div class="topnav">
		<a href="../CreateAuction/createauction.jsp">Create Auction</a>
		<a href="activelistings.jsp" class="active">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<h1 style="background-color: white; font-family: 'Trebuchet MS', sans-serif;">Specify search parameters:</h1>
	<!-- PHONE PARAMETERS -->
	<div class="container" style="text-align: left;">
		<form action="findlaptop.jsp" method="post">
			<!-- CONDITION -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Condition:  </label></div>
				<div class="itemcolumn2">
					<select name="condition" id="condition">
						<option value="new">New</option>
						<option value="excellent">Used: Excellent Condition</option>
						<option value="good">Used: Good</option>
						<option value="damage">Used: Some damage</option>
					</select><br>
				</div>
			</div>
			<!-- BRAND -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Brand:</label></div>
				<div class="itemcolumn2"><input type="text" name="brand"/><br></div>
			</div>
			<!-- COLOR -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Color:</label></div>
				<div class="itemcolumn2"><input type="text" name="color"/><br><br></div>
			</div>
			<!-- RAM -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>RAM: (select)</label></div>
				<div class="itemcolumn2">
					<select name="ram" id="ram">
						<option value="8">8 GB</option>
						<option value="16">16 GB</option>	
						<option value="32">32 GB</option>				
					</select><br>
				</div>
			</div>
			<!-- OS -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>OS: (select)</label></div>
				<div class="itemcolumn2">
					<select name="os" id="os">
						<option value="windows">Windows</option>
						<option value="mac">Macintosh</option>
						<option value="linux">Linux</option>
					</select><br>
				</div>
			</div>
			<!-- STORAGE -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Storage (select):</label></div>
				<div class="itemcolumn2">
					<select name="storage" id="storage">
						<option value="64">256 GB</option>
						<option value="128">512 GB</option>
						<option value="256">1 TB</option>
					</select><br>
				</div>
			</div>
			<!-- CHARGER -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Charger Included:</label></div>
				<div class="itemcolumn2">
					<select name="charger" id="charger">
						<option value="yes">Yes</option>
						<option value="no">No</option>
					</select>
				</div>
			</div>
			<!-- TOUCH SCREEN -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Touch Screen? (select):</label></div>
				<div class="itemcolumn2">
					<select name="touch" id="touch">
						<option value="yes">Yes</option>
						<option value="no">No</option>
					</select>
				</div>
			</div>
			<!-- MAXIMUM PRICE -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Maximum Price ($USD):</label></div>
				<div class="itemcolumn2"><input type="number" step="1" name="maxPrice"/></div>
			</div>
			<!-- SORT BY -->
			<div class="itemrow">
				<div class="itemcolumn1"><label>Sort items by:</label></div>
				<div class="itemcolumn2">
					<select name="sort" id="sort">
						<option value="priceHighToLow">Price: High to Low</option>
						<option value="priceLowToHigh">Price: Low to High</option>
					</select>
				<br></div>
			</div><br><br>	
			<!-- SUBMIT -->
			<input type="submit" value="Submit" style="margin-left:50%;">
		</form>
	</div>
</body>
</html>