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
   <li class="current"><a href="Home.jsp">Logout</a></li>
</ul>
<div id="site_content">
<div id="sidebar_container">
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=session.getAttribute("username").toString() %>  !</h3>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Book.jsp?user=<%=user %>">Click here </a>to Book A Charge Point ; </h3>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="ViewBookings.jsp?user=<%=user %>">Click here </a>to View Booked Charge Points ;  </h3>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Cancel.jsp?user=<%=user %>">Click here </a>to Cancel A Booked Charge Point ; </h3>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddCC.jsp?user=<%=user %>">Click here </a>to Add Credit Card details ; </h3>
</div>
</div>
</div>
</body>
</html>