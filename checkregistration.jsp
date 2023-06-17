<%@ page import="java.sql.*"%>
<% 

String uname = request.getParameter("name");
String userid = request.getParameter("username");
String pwd = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/electronics","root", "password");
Statement st = con.createStatement();
ResultSet rs;

//check username already exists
rs = st.executeQuery("select * from users where username='"+userid+"'");
if(rs.next()){
	out.println("Username already taken <br><a href='register.jsp'>Try Again</a>");
	con.close();
}
//check for valid name and password
else if(pwd.length()<1 || pwd.contains(" ") || userid.length()<1 || userid.contains(" ") || uname.length()<1 || uname.contains(" ")){
	out.println("Invalid credentials <br><a href='register.jsp'>Try Again</a>");
	con.close();	
}
//otherwise, add user to database
else{
	String query = "insert into users values(?,?,?,?,now())";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1,userid);
	ps.setString(2,pwd);
	ps.setString(3,uname);
	ps.setString(4,"end");
	ps.executeUpdate();
	con.close();
	
	//this user's current session
	session.setAttribute("user",userid);
	response.sendRedirect("End/endhome.jsp");
	con.close();
}
%>