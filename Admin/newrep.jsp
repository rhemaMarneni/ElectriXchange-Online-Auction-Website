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
  		<a href="index.jsp" class="logo">electriXchange</a>
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
			String name = request.getParameter("name");
			String userid = request.getParameter("username");
			String pwd = request.getParameter("password");
			String pwd2 = request.getParameter("password2");
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
			Statement st = con.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where username='"+userid+"' and acct_type='rep'");
			
			//if username already exists
			if(rs.next()){
				out.println("A customer representative already exists with that username <br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//does not exist but invalid entries
			else if(pwd.length()<3 || userid.length()<3 || name.length()<3 || pwd.contains(" ") || userid.contains(" ") || name.contains(" ")){
				out.println("All inputs should have at least 3 characters<br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//does not exist, but passwords don't match
			else if(!pwd.equals(pwd2)){
				out.println("Passwords don't match<br><br><a href='manageCustRep.jsp' class='button'>Try again</a>");
			}
			//none, so add user to database
			else{
				String query = "insert into users values (?,?,?,?,now())";
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1,userid);
				ps.setString(2,pwd);
				ps.setString(3,name);
				ps.setString(4,"rep");
				ps.executeUpdate();
				con.close();
				//store the username in session
				session.setAttribute("user",userid);
				out.println("Customer Representative account with username '"+userid+ "' has been successfully created<br><br><a href='manageCustRep.jsp' class='button'>Okay</a>");
			}
		%>
	</div>

</body>
</html>