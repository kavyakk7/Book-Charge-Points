<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
//Get values of input fields
String user = request.getParameter("name");
String password = request.getParameter("pwd");
//Check for username and password
try 
{
	Statement statement = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	String QueryString = "Select username from user where username='"+user+"' and password='"+password+"'";
	rs = st.executeQuery(QueryString);
	if(rs.next())
	{
		session.setAttribute("username", user);
		//notify user after successful login and redirect to user home page
		out.println("<script type=\"text/javascript\">");
	    out.println("alert('Logged In!!');");
	    out.println("</script>");
		response.sendRedirect("UserHome.jsp?user="+user);
	}
	else
	{
		//notify user of unsuccessful login and redirect to home page
		out.println("<script type=\"text/javascript\">");
	    out.println("alert('Could not find user! Check your credentials!');");
	    out.println("location='Home.jsp';");
	    out.println("</script>");
	}
}
catch(Exception ex){
out.println("Unable to connect to database.");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<title> Book Charging Point </title>
</head>
<body>
<div id="main">
<ul class="lavaLampWithImage">
   <li class="current"><a href="Home.jsp">home</a></li>
</ul>
<div id="site_content">
<div id="sidebar_container">
<div id="welcome">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iiWELCOMEii</h3>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="Up"> Sign Up</h2>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="In"> Sign In</h2>
  ------------------------------------------------------------------------------------
</div>
</div>
<div id="content">
<img width="450" height="450" src="images/charge_station.jpg" alt="photo_one" />
</div>
</div>
</div>
</body>
</html>