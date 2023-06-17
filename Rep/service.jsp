<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Rep: End users</title>
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
		<a href="auctions.jsp">Manage Auctions</a>
		<a href="service.jsp" class="active">Customer Service</a>
		<a href="rephome.jsp" style="background-color: black; color:white; font-weight:bold; border-style: none; text-align:center;">HOME PAGE</a>
		
	</div>
	<div class="body-content">
		<h1 style="background-color:white;">Customer Service</h1>
		<h2>Pending Questions</h2>
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");

			Statement stmt = con.createStatement();
			String query = "SELECT * from ask WHERE answer IS NULL";

			ResultSet rs = stmt.executeQuery(query);
			
		%>
		<ul>
		
			<% while (rs.next()) { %>
			
				<% String question = rs.getString("question"); %>

				<li>
				
					<div>
						<% System.out.println(question); %>
						<% out.print(question); %>
						<form action="answerQuestion.jsp" method="POST">
							Answer:	<input type="text" maxlength="200" size="130" name="answer"/><br/><br/>
						
						<input name="question" type="hidden" value='<%= question %>'>
						<input type="submit" value="Submit"/>
			</form>
					</div>
				
				
				</li>
				
			<% }
			con.close();
			%>
		
		</ul>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		<br><hr>
		<h2>Answered Questions</h2>
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");

			String username = (String)session.getAttribute("user");
			String query = "SELECT * FROM ask WHERE representative_username = ? and answer IS NOT NULL";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();
			
		%>
		<table>
		
			<tr>
				<th>Question</th>
				<th>Answer</th>
			</tr>
		
			<% while (rs.next()) { %>
			
				<tr>
					<td><%= rs.getString("question") %></td>
					<td><%= rs.getString("answer") %></td>
				</tr>
				
			<% }
			con.close();
			%>
		
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	</div>
	<br><br>

</body>
</html>