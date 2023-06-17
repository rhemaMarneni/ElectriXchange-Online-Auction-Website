<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Welcome Page</title>
	<link rel="shortcut icon" href="./Images/eleclogo.jpg" type="image/x-icon" />
	<link rel='stylesheet' href="./CSS/homestyle.css"/>
</head>
<body>
	<div class="header">
  		<a href="index.jsp" class="logo">electriXchange</a>
  		<div class="header-right">
	    	<a href="#search" style="font-weight: bold;">About Us</a>		    
  		</div>
	</div>
	<div class="row">
		<div class="column">
			<img class="image" src = "./Images/eleclogo.jpg">
		</div>
		<div class="column">
			<div class = "back">
				<h1>User Login</h1>
				<form action="checklogin.jsp" method = "post">
					<label for="username">Username:</label><br>
					<input type="text" name = "username" size = "44" required/>
					<br><br>
					<label for="password">Password:</label><br>
					<input type="password" name = "password" size = "44" required/>
					<br>
					<br><br>
					<div>
						<input type="submit" value="Login"/><br>
						<a style="color: black;" href='register.jsp'>New user? Register here</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>