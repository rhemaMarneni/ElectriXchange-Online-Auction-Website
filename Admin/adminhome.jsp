<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Admin: Home Page</title>
	<link rel="shortcut icon" href="../Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="../CSS/homestyle.css"/>
	<link rel='stylesheet' href="../CSS/adminstyle.css"/>
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
		<a href = "manageCustRep.jsp">Manage Customer Representatives</a>
		<a href = "manageend.jsp">Manage End Users</a>
		<a href = "manageauctions.jsp">View Auctions</a>
		<a href = "generatesales.jsp">Generate Sales Reports</a>
	</div>
	<div class="body-content">
	Select an option from the left to get started.<br><br>
	<b>Note:</b> Only Admin is capable of creating and deleting a Customer Representative account.
	</div>

</body>
</html>