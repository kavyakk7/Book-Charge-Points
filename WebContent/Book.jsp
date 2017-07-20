<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
String user = request.getParameter("user");
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
<%
String[] time = {"00:30:00","01:00:00","01:30:00","02:00:00","02:30:00","03:00:00","03:30:00","04:00:00","04:30:00","05:00:00","05:30:00","06:00:00","06:30:00","07:00:00","07:30:00","08:00:00","08:30:00","09:00:00","09:30:00","10:00:00","10:30:00","11:00:00","11:30:00","12:00:00","12:30:00","13:00:00","13:30:00","14:00:00","14:30:00","15:00:00","15:30:00","16:00:00","16:30:00","17:00:00","17:30:00","18:00:00","18:30:00","19:00:00","19:30:00","20:00:00","20:30:00","21:00:00","21:30:00","22:00:00","22:30:00","23:00:00","23:30:00","24:00:00"};	
%>
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=session.getAttribute("username").toString() %> !</h3>
<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Book A Charging Point : Step 1 </h2>
<form name=book method=POST action="CheckACP.jsp">
<input type=hidden name=user value='<%=user%>'>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Current City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <select name=currcity required>
<option> --Select Current City-- </option>
<%
// Get city list from table 'city' 
//store values in variable and display it
ArrayList<String> cities = new ArrayList<String>();
try 
{
	Statement statement = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	String QueryString = "Select city from city";
	rs = st.executeQuery(QueryString);
	while(rs.next())
	{
		cities.add(rs.getString(1));
		%>
		<option><%=rs.getString(1) %></option>
		<%
	}
}
catch(Exception ex){
out.println("Unable to connect to database.");
}

%>
</select></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Destination City&nbsp;&nbsp;: <select name=destcity required>
<option> --Select Destination City-- </option>
<%
//Get city list from table 'city'
for(int i = 0; i < cities.size() ; i++)
{
%>
		<option><%=cities.get(i) %></option>
		<%
}
%>
</select></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="date" name=date required></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="time" name=time required></p>
&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit name=check value=" Check Available Charge Points " >&nbsp;&nbsp;&nbsp;&nbsp;
<input type=reset value=" Reset Value ">
</form>
</div>
<div id="content">
<img width="450" height="450" src="images/Mmap.png" alt="map" />
</div>
</div>
</div>
</body>
</html>