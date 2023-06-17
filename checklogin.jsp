<%@ page import = "java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root","password");
Statement st1 = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs1, rs2;

//----------FOR ALERTS UPDATE------------
//Auctions that did not have any bids
String noBids = "select seller, name, item_id, auction_id from auctions "
	+ "natural join items where now() > end_date and current_price = 0 "
	+ "and auction_id not in (select distinct auction_id from sold)";
rs1 = st1.executeQuery(noBids);

String seller, itemName;
int thisAuction, thisItem;

while(rs1.next()) {
	
	// Get the parameters to update tables
	seller = rs1.getString("seller");
	itemName = rs1.getString("name");
	thisAuction = rs1.getInt("auction_id");
	thisItem = rs1.getInt("item_id");
	
	// Move the auction into the sold table (item did not 'sell', but the auction has ended)
	//st2.executeUpdate("insert into sold values('" + seller + "', '', " + thisAuction + ", 0)");
	st2.executeUpdate("insert into sold values('" + seller + "', '" + seller + "', " + thisAuction + ", 0)");
	
	// Alert the seller that his item has not been sold
	st2.executeUpdate("insert into alerts values('" + seller + "', 'Your item, "
		+ itemName + " has not been sold since the bids did not reach your reserve price.', 'notsold', now())");
	
	// Reduce the quantity of the item that was being sold
	st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
}

//Update all other auction information
String doneAuctionQuery = "select a.seller, b.username buyer, a.auction_id, "
	+ "a.reserve_price, a.current_price final_price, name, item_id "
	+ "from auctions a natural join items i natural join bidOn b "
	+ "where now() > end_date and a.current_price = b.amount "
	+ "and a.auction_id not in (select auction_id from sold)";
rs1 = st1.executeQuery(doneAuctionQuery);

String winner;
float reservePrice, currentPrice;

while (rs1.next()) {
	seller = rs1.getString("seller");
	winner = rs1.getString("buyer");
	thisAuction = rs1.getInt("auction_id");
	reservePrice = rs1.getFloat("reserve_price");
	currentPrice = rs1.getFloat("final_price");
	itemName = rs1.getString("name");
	thisItem = rs1.getInt("item_id");
	
	// If the item did not reach it's minumum price
	if (currentPrice < reservePrice) {
		
		// Move the auction into the sold table (item did not 'sell', but the auction has ended)
		st2.executeUpdate("insert into sold (seller, auction_id, final_price) values('" + seller + "', '', " + thisAuction + ", " + currentPrice + ")");
		
		// Alert the seller that his item did not sell
		st2.executeUpdate("insert into alerts values('" + seller + "', 'Your item, "
			+ itemName + " has not been sold since the bids did not reach your reserve price.', 'notsold', now())");
		
		// Reduce the quantity of the item that was being sold
		st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
		
	} else {
		
		// Insert the winner into the sold table
		st2.executeUpdate("insert into sold values('" + seller + "', '" + winner + "', " + thisAuction + ", " + currentPrice + ")");
		
		// Alert the winner of the auction
		st2.executeUpdate("insert into alerts values ('" + winner + "', 'You have won " + itemName + " for $" + currentPrice + "!', 'won', now())");
				
		// Update the item quantity of the item that has been sold
		st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
				
		// Make all of the autobids on the auction inacitve
		st2.executeUpdate("update autoBid set active_status = false where auction_id = " + thisAuction);
	}
}


//-----------FOR LOGIN------------
//get user input information
String userid = request.getParameter("username");
String pwd = request.getParameter("password");
//if credentials in database
rs1 = st1.executeQuery("select * from users where username='"+userid+"' and password='"+pwd+"'");
if(rs1.next()){
	//store username in session
	session.setAttribute("user", userid);
	//redirect users to appropriate homepages
	String usertype = rs1.getString("acct_type");
	if(usertype.equals("end")){
		response.sendRedirect("End/endhome.jsp");
	}
	else if(usertype.equals("rep")){
		response.sendRedirect("Rep/rephome.jsp");
	}
	else{
		response.sendRedirect("Admin/adminhome.jsp");
	}
}
//if not in database
else{
	out.println("Bruh you screwed up, Go check your credentials <a href='index.jsp'>Go Back</a>");
	//String message = "Invalid email/password";
    //request.setAttribute("message", message);
}
con.close();
%>