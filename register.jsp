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
		<img class = "navimage" src = "./Images/eleclogo.jpg">
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
				<h1>New User Registration</h1>
				<form action="checkregistration.jsp" method = "post">
					<label for="name">Enter Your Name:</label><br>
					<input type="text" name = "name" size = "44" required/>
					<br>
					<label for="username">Create Username:</label><br>
					<input type="text" name = "username" size = "44" required/>
					<br>
					<label for="password">Create Password:</label><br>
					<input type="password" name = "password" size = "44" required/>
					<br>
					<div>
						<input type="submit" value="Sign up"/><br>
						<a style="color: black;" href='index.jsp'>Having an account already? Login here</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>