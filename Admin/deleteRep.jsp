<%@ page import="java.sql.*"%>
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
  		<a href="#" class="logo">electriXchange</a>
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
		<a href = "manageCustRep.jsp" class="active">Manage Customer Representatives</a>
		<a href = "manageend.jsp">Manage End Users</a>
		<a href = "manageauction.jsp">View Auctions</a>
		<a href = "generatesales.jsp">Generate Sales Reports</a>
	</div>
	<div class="body-content">
		<%
			String userid = request.getParameter("username");
			String userid2 = request.getParameter("username2");
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where username='"+userid+"' and acct_type='rep'");
			
			//if username does not exist
			if(!rs.next()){
				out.println("A customer representative with that username DOES NOT EXIST<br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//does not exist but invalid entries
			else if(userid.length()<3 || userid2.length()<3 || userid.contains(" ") || userid2.contains(" ")){
				out.println("Invalid username entered<br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//does not exist, but usernames don't match
			else if(!userid.equals(userid2)){
				out.println("Usernames don't match<br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//none, so add user to database
			else{
				String query = "delete from users where username='"+userid+"'";
				PreparedStatement ps = con.prepareStatement(query);
				ps.executeUpdate();
				con.close();
				out.println("Customer Representative account with username '"+userid+ "' has been SUCCESSFULLY DELETED<br><br><a href='manageCustRep.jsp' class='button'>Okay</a>");
			}
		%>
	</div>

</body>
</html>