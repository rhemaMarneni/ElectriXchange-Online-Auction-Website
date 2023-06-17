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
		String username = request.getParameter("userid");   
		String bid_amount = request.getParameter("amount");   
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
	    Statement st = con.createStatement();
	    Statement st2 = con.createStatement();
	    Statement st3 = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from bidOn where username='" + username+ "' and auction_id='" + auction_id + "' and amount='"+ bid_amount+"'");
	    
	    //if the username does not exist in database
	    if (!rs.next()) {
	    	out.println("Bid does not exist<br><br><div><a href='auctions.jsp' class='button'>Try again</a></div>");
	    }
	    
	    // Check to see if the entered username and password are valid
	    // Usernames and passwords cannot be blank and cannot contain spaces
	    else if(username.contains(" ") || auction_id.contains(" ") || bid_amount.contains(" ")){
	    	out.println("Invalid Entries. Recheck input.<br><bt><div><a href='auctions.jsp' class='button'>Try again</a></div>");
	    }
	   
	    // Insert the new user into the database
	    else {
	    	String query = "delete from bidOn where username='" + username+ "' and auction_id='" + auction_id + "' and amount='"+ bid_amount+"'";
	    	PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();
			ResultSet rs2=st2.executeQuery("select max(amount) m from bidOn where auction_id= '" + auction_id+"'");
			ResultSet rs3=st3.executeQuery("select current_price from auctions where auction_id= '" + auction_id+"'");
			if(rs2.next() && rs3.next()){
				if(Float.parseFloat(rs2.getString("m")) < Float.parseFloat(rs3.getString("current_price"))){
					st.executeUpdate("update auctions set current_price="+Float.parseFloat(rs2.getString("m"))+" where auction_id='"+auction_id+"'");
				}
			}
			con.close();
			out.print("Deletion of Bid from Auction: " +"'"+auction_id + "' by User: '"+ username+"' with bid amount: '" +bid_amount +"' was successful");
			%>
			<br>
			<a href='auctions.jsp' class="button">Okay</a><%
	    }
		%>
	</div>
	<br><br>

</body>
</html>