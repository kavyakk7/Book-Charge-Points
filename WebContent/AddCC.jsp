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
//Set session
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
<form name=card method=POST action="SaveCC.jsp">
<input type=hidden name=user value='<%=user%>'>
<p>Name on card : <input type=text name=name required></p>
<p>Card Type: <select name=ctype>
<option>--Select Card Type--</option>
<option>MasterCard</option>
<option>Visa</option>
</select></p>
<p>Card number : <input type=text name=cno required></p>
<p>Month & Year of Expiry : <input type=month name=my required></p>
<p>CVV : <input type=text name=cvv required></p>
<input type=submit value=" Save Card ">
</form>
</div>
</div>
</div>
</body>
</html>