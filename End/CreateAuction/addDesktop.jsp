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
		<a href="../CreateAuction/createauction.jsp" class="active">Create Auction</a>
		<a href="../Listings/activelistings.jsp">Active Listings</a>
		<a href="../BidHistory/bidhistory.jsp">Auction Bid Histories</a>
		<a href="../CustService/custservice.jsp">Customer Service</a>
		<a href="../Enduser_Profile/endprofile.jsp">My Profile</a>
	</div>
	<div class="container" style="text-align: left;">
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();
			Statement st3 = con.createStatement();
			ResultSet rs;
			
			//seller is current user session
			String seller = (String)session.getAttribute("user");
			
			//get all Desktop parameters
			String itemName = request.getParameter("name");
			String itemCondition =  request.getParameter("condition");
			String manLoc = request.getParameter("loc");
			String brand = request.getParameter("brand");
			String color = request.getParameter("color");
			String ram = request.getParameter("ram");
			String os = request.getParameter("os");
			String storage = request.getParameter("storage");
			String quantity = request.getParameter("quantity");
			String other = request.getParameter("other");  
			String touch = request.getParameter("touch");
			String dim = request.getParameter("dimensions");
			String endDate = request.getParameter("date");
			if(endDate.equals("")){
				out.println("Auction End Date Invalid. Try Again<br><br><a href='createDesktop.jsp' class='button'>Try Again</a>");
			}
			else{
				String dateQuery = "select now() < ? validDate";
				PreparedStatement ps = con.prepareStatement(dateQuery);
				ps.setString(1, endDate);
				rs = ps.executeQuery();
				rs.next();
				Boolean validDate = rs.getBoolean("validDate");
				
				String minPrice = request.getParameter("minPrice");
				String notes = request.getParameter("notes");
				if(minPrice.equals("0") || minPrice.equals("")){
					out.println("The minimum price must be above $1<br><br><a href='createDesktop.jsp' class='button'>Try Again</a>");
				}
				else if(!validDate){
					out.println("Auction End Date Invalid. Try Again<br><br><a href='createDesktop.jsp' class='button'>Try Again</a>");
				}
				else{
					//query to check for similar item
					String query = "select * from items natural left join desktops where name = ? and item_condition = ? and manufacturing_location = ? and brand = ? and color = ? and "+
					"ram = ? and os = ? and storagetype = ? and otherparts = ? and touchscreen = ? and dimensions = ?";
					
					ps = con.prepareStatement(query);
					ps.setString(1,itemName);
					ps.setString(2,itemCondition);
					ps.setString(3,manLoc);
					ps.setString(4,brand);
					ps.setString(5,color);
					ps.setString(6,ram);
					ps.setString(7,os);
					ps.setString(8,storage);
					ps.setString(9,other);
					ps.setString(10,touch);
					ps.setString(11,dim);
					
					rs = ps.executeQuery();
					
					//if yes, increase quantity and create new auction
					if(rs.next()){
						int similarID = rs.getInt("item_id");
						st.executeUpdate("update items set quantity = quantity + " + quantity + " where item_id = " + similarID);
						//anyone checking for this item will be alerted
						ResultSet similarAlert = st2.executeQuery("select username, name from desiredItems natural join items where item_id = " + similarID);
						while(similarAlert.next()){
							st3.executeUpdate("insert into alerts values('" + similarAlert.getString("username") + "', 'Your desired item, " + similarAlert.getString("name") + " is now available for bidding!', 'item', now())");
							st3.executeUpdate("delete from desiredItems where item_id = " + similarID + " and username = " + similarAlert.getString("username") + "'");
						}
						
						//since creating new auction, create new auction_id (continue counting)
						ResultSet lastID = st.executeQuery("select max(auction_id) highest from auctions");
						lastID.next();
						Integer newAuctionID = lastID.getInt("highest");
						if(newAuctionID == null){  //that means no auctions exist, so start at 0
							newAuctionID = 0;
						}
						newAuctionID += 1;
						
						String addAuctionQuery = "insert into auctions (seller, auction_id, item_id, reserve_price, current_price, start_date, end_date) values(?, ?, ?, ?, 0, now(), convert(?, datetime))";
						PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
						addAuctionStatement.setString(1, seller);
						addAuctionStatement.setInt(2, newAuctionID);
						addAuctionStatement.setInt(3, similarID);
						addAuctionStatement.setString(4, minPrice);
						addAuctionStatement.setString(5, endDate);
						
						addAuctionStatement.executeUpdate();
						st3.executeUpdate("insert into alerts values('" + similarAlert.getString("username") + "', 'You created a new auction listing of " + itemName + " !', 'item', now())");
						
						out.println("Your item has been listed.<br><br><a href='../endhome.jsp' class='button'>Okay</a>");
					}
					else{ //similar item does not exist
						// creating new item ID
						Integer newItemID, newAuctionID;
						ResultSet lastID = st.executeQuery("select max(item_id) highest from items");
						lastID.next();
						newItemID = lastID.getInt("highest");
						if (newItemID == null) {
							newItemID = 0;
						}
						newItemID += 1;
						
						String addItemQuery = "insert into items values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
						PreparedStatement addItemStatement = con.prepareStatement(addItemQuery);
						addItemStatement.setInt(1, newItemID);
						addItemStatement.setString(2, itemName);
						addItemStatement.setString(3, itemCondition);
						addItemStatement.setString(4, manLoc);
						addItemStatement.setString(5, brand);
						addItemStatement.setString(6, color);
						addItemStatement.setString(7, ram);
						addItemStatement.setString(8, os);
						addItemStatement.setString(9, storage);
						addItemStatement.setString(10, quantity);
						addItemStatement.setString(11, notes);
						
						
						addItemStatement.executeUpdate();
						
						String addDesktopQuery = "insert into desktops values(?, ?, ?, ?)";
						PreparedStatement addDesktopStatement = con.prepareStatement(addDesktopQuery);
						addDesktopStatement.setInt(1, newItemID);
						addDesktopStatement.setString(2, touch);
						addDesktopStatement.setString(3, other);
						addDesktopStatement.setString(4, dim);	
						
						addDesktopStatement.executeUpdate();
						
						lastID = st.executeQuery("select max(auction_id) highest from auctions");
						lastID.next();
						newAuctionID = lastID.getInt("highest");
						if (newAuctionID == null) {
							newAuctionID = 0;
						}
						newAuctionID += 1;
						
						String addAuctionQuery = "insert into auctions (seller, auction_id, item_id, reserve_price, current_price, start_date, end_date) values(?, ?, ?, convert(?, decimal(9,2)), 0, now(), convert(?, datetime))";
						PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
						addAuctionStatement.setString(1, seller);
						addAuctionStatement.setInt(2, newAuctionID);
						addAuctionStatement.setInt(3, newItemID);
						addAuctionStatement.setString(4, minPrice);
						addAuctionStatement.setString(5, endDate);
						
						addAuctionStatement.executeUpdate();
						
						out.println("Your item has been listed. <br><br><a href='../endhome.jsp' class='button'>Okay</a>");
					}
				}
			}
			
		%>
	</div>
</body>
</html>