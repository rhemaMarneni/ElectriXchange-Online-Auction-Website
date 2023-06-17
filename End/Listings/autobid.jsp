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
	<!-- NAV BAR -->
	<div class="topnav">
		<a href="../CreateAuction/createauction.jsp">Create Auction</a>
		<a href="activelistings.jsp" class="active">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<h1 style="background-color: white;">Bidding on an active listing</h1>
	<div class="container">
	<%
		//connection
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");	
		Statement st = con.createStatement();
		ResultSet rs;
		//parameters from previous page
		String bidder = (String)session.getAttribute("user");
		float inc = Float.parseFloat(request.getParameter("bidinc"));
		float max_amt = Float.parseFloat(request.getParameter("max"));
		String auction_ID = request.getParameter("auction_id");
		int thisID = Integer.parseInt(auction_ID);
		//some more parameters and store them
		String query = "select seller, name, current_price, now() < end_date valid from auctions natural join items where auction_id = " + thisID;
		rs = st.executeQuery(query);
		rs.next();
		String seller = rs.getString("seller");
		String itemName = rs.getString("name");
		float curr_price = Float.parseFloat(rs.getString("current_price"));
		boolean valid = rs.getBoolean("valid");
		//if own auction
		if(seller.equals((String)session.getAttribute("user"))){
			out.println("Cannot bid on your auction. Check on active listings and bid items listed by other users.<br><br><a href='allListings.jsp' class='button'>All Listings</a>");
		}
		//auction expired during bidding process
		else if(!valid){
			out.println("Auction ended. Check on active listings and bid items listed by other users.<br><br><a href='allListings.jsp' class='button'>All Listings</a>&nbsp;&nbsp;<a href='../endhome.jsp' class='button'>Home Page</a>");
		}
		//max bid amount less than current bid
		else if(max_amt <= curr_price){
			out.println("The current bid on this item is larger than the maximum amount you entered. Please enter a larger amount.<br><br><a href='biditem.jsp?auction_id' class='button'>Try Again</a>");
		}
		//valid bid
		else{
			String autobid = "insert into autobid values(?,?,true,?,?)";
			PreparedStatement ps = con.prepareStatement(autobid);
			ps.setString(1,bidder);
			ps.setInt(2,thisID);
			ps.setFloat(3,max_amt);
			ps.setFloat(4,inc);
			ps.executeUpdate();
			
			//increment existing autobids if any
			rs = st.executeQuery("select count(username) autobidders from autobid at, auctions ac where at.active_status = true and ac.auction_id = " + thisID + " and ac.auction_id = at.auction_id");
			rs.next();
			
			//only 1 autobid exists
			if(rs.getInt("autobidders") == 1){
				if(inc + curr_price <= max_amt){
					String new_price = "update auctions set current_price = " + (curr_price + inc) + " where auction_id = " + thisID;
					ps = con.prepareStatement(new_price);
					ps.executeUpdate();
					
					ps = con.prepareStatement("insert into bidon values(?,?,now(),?)");
					ps.setString(1,bidder);
					ps.setInt(2,thisID);
					ps.setFloat(3,curr_price+inc);
					ps.executeUpdate();
					
					curr_price += inc;
				}
				else{
					String new_price = "update auctions set current_price = " + max_amt + " where auction_id = " + thisID;
					ps = con.prepareStatement(new_price);
					ps.executeUpdate();
					
					ps = con.prepareStatement("insert into bidon values(?,?,now(),?)");
					ps.setString(1,bidder);
					ps.setInt(2,thisID);
					ps.setFloat(3,curr_price+inc);
					ps.executeUpdate();
					
					curr_price = max_amt;
				}
			}
			else{
				//get prev username
				String prev = "select username, highest_price from autobid where auction_id = "
						+ thisID + " and highest_price = (select max(highest_price) from autobid where auction_id = "
						+ thisID + " and highest_price < (select max(highest_price) from autobid where auction_id = " + thisID + "))";
				rs = st.executeQuery(prev);
				rs.next();
				String prevUsername = rs.getString("username");
				float prevMaxPrice = rs.getFloat("highest_price");
				// Insert the prev highest autobidder's bid
				st.executeUpdate("insert into bidOn values('" + prevUsername + "', " + thisID + ", now(), " + prevMaxPrice + ")");
				// Get the highest autobidder
				String highest = "select username, highest_price, bid_interval from autobid where auction_id = " + thisID + " and highest_price = (select max(highest_price) from autobid)";
				rs = st.executeQuery(highest);
				rs.next();
				String highestAutoBidder = rs.getString("username");
				float thisMax, thisIncrement;
				thisMax = rs.getFloat("highest_price");
				thisIncrement = rs.getFloat("bid_interval");	
				// Compute the proper bid of the highest autobidder
				if (prevMaxPrice + thisIncrement <= thisMax) {
					st.executeUpdate("insert into bidon values('" + highestAutoBidder + "', " + thisID + ", now(), " + (prevMaxPrice + thisIncrement) + ")");
					st.executeUpdate("update auctions set current_price = " + (prevMaxPrice + thisIncrement) + " where auction_id = " + thisID);				
				} 
				else{
					st.executeUpdate("insert into bidon values('" + highestAutoBidder + "', " + thisID + ", now(), " + thisMax + ")");
					st.executeUpdate("update auctions set current_price = " + thisMax + " where auction_id = " + thisID);				
				} 
				// Alert the second highest bidder that he has been outbid
				st.executeUpdate("insert into alerts values('" + prevUsername + "', 'Someone has bid higher than your maximum on " + itemName + "!', 'outbid', now())");
					
				// Change the active status of the second highest autobidder
				st.executeUpdate("update autobid set active_status = false where auction_id = " + thisID + " and username = " + prevUsername);
			}
			Statement newst = con.createStatement();
			ResultSet newRS = st.executeQuery("select username, highest_price, bid_interval from autobid where auction_id = "
				+ thisID + " and active_status = 1 and highest_price < (select max(highest_price) from autobid)");
			String help;
			float yes;
			while (newRS.next()) {
				help = newRS.getString("username");
				yes = newRS.getFloat("highest_price");
				newst.executeUpdate("insert into bidon values('" + help + "', " + thisID + ", now(), " + yes + ")");
			}
			
			//Find all of the users that have been outbid
			String outBidUser, outBidQuery;
			outBidQuery = "select distinct b.username, i.name from bidon b, auctions a, items i where a.item_id = i.item_id and a.auction_id = b.auction_id and b.auction_id = "
					+ thisID + " and b.username not in (select username from bidon where amount = (select max(amount) from bidon where auction_id = "
					+ thisID + ")) and b.username not in (select username from autobid where auction_id = " + thisID + ")";
			rs = st.executeQuery(outBidQuery);

			// Make an alert for all of the users that have been outbid
			ArrayList<String> bidders = new ArrayList<String>();
			ArrayList<String> items = new ArrayList<String>();
			while (rs.next()) {
				outBidUser = rs.getString("username");
				itemName = rs.getString("name");
				bidders.add(outBidUser);
				items.add(itemName);
			}

			for (int i = 0; i < bidders.size(); i++) {
				st.executeUpdate("update autobid set active_status = false where username = '" + bidders.get(i) + "' and auction_id = " + thisID);
				String outBidString = "insert into alerts values('" + bidders.get(i) + "', 'You have been outbid on " + items.get(i) + "!', 'outbid', now())";
				st.executeUpdate(outBidString);
			}
			
			// Remove all of the inactive autobidders (this allows the user to set up a new autobid)
			String inactive = "delete from autobid where active_status = false";
			st.executeUpdate(inactive);

			
			out.println("Your bid has been successfully placed.<br><br> <a href='../endhome.jsp' class='button'>Home</a>");
		}
	
	%>
	</div>
</body>
</html>