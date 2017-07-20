<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<title> Book Charging Point </title>
</head>
<body>
<div id="main">
<%
//Get and set session
String user = session.getAttribute("username").toString();
if(user==null)
	user=request.getParameter("user");
session.setAttribute("username",user);
%>
<ul class="lavaLampWithImage">
   <li class="current"><a href="UserHome.jsp?user=<%=user %>">Home</a></li>
   <li class="current"><a href="Book.jsp?user=<%=user %>">Book</a></li>
   <li class="current"><a href="ViewBookings.jsp?user=<%=user %>">View</a></li>
   <li class="current"><a href="Cancel.jsp?user=<%=user %>">Cancel</a></li>
   <li class="current"><a href="AddCC.jsp?user=<%=user %>">Add Card</a></li>
   <li class="current"><a href="Home.jsp">Logout</a></li>
</ul>
<div id="site_content">
<div id="sidebar_container">
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=session.getAttribute("username").toString() %>  !</h3>
<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancel A Booked Charge Point : </h2>
<form name=cancel>
<input type=hidden name=user value='<%=user%>'>
<%
// Get details of bookings, if any, from table 'booked' and display in html <table>
try
{
	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select DISTINCT b.bookid,b.cpid,b.currcity,b.destcity,b.ondate,b.time from booked b,user u where b.user in (Select username from user where fullname='"+user+"')";
  	rs = st.executeQuery(QueryString);
  	if(rs!=null)
  	{
  		%>
  		<table class="table1">
	  	   <thead>
	  	        <tr>
	  	            <th scope="col">BookID</th>
	  	            <th scope="col">CP</th>
	  	            <th scope="col">Current City</th>
	  	            <th scope="col">Destination City</th>
	  	            <th scope="col">Date</th>
	  	            <th scope="col">Time</th>
	  	        </tr>
	  	    </thead>
	    <tbody>
  		<%
  		while(rs.next())
  		{
  		%>
  		<tr>
  			<td><%=rs.getString(1) %></td>
  			<td><%=rs.getString(2) %></td>
  			<td><%=rs.getString(3) %></td>
  			<td><%=rs.getString(4) %></td>
  			<td><%=rs.getString(5) %></td>
  			<td><%=rs.getString(6) %></td>
	    <tr>
  		<%
  		}
  		%>
  		</tbody>  		
  		</table>
  		<%
  	}
  	else
  	{
  		%><h2>You have not booked any charge points yet!</h2><% 
  	}
}
catch(Exception e)
{
	e.printStackTrace();	
}
%>
</form>
</div>
</div>
</div>
</body>
</html>