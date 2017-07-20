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
//Get values from input fields
String name=request.getParameter("name");
String ctype = request.getParameter("ctype");
String cno = request.getParameter("cno");
String expm = request.getParameter("my");  // format:"YYYY-MM"
String[] data = expm.split("-");  // split 'expm' to get month and year separately
int cvv = Integer.parseInt(request.getParameter("cvv"));
//Insert the values into table 'creditcard_details'
try
	{
		Statement statement2 = null;
	    ResultSet rs2 = null;
	    String connectionURL2 = "jdbc:mysql://localhost:3307/bookcp";
	    Connection connection2 = null; 
		Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		connection2 = DriverManager.getConnection(connectionURL2, "root", "root");
		Statement st2 = connection2.createStatement();
		String query = "insert into creditcard_details values('"+user+"' ,'"+name+"','"+cno+"','" + Integer.parseInt(data[1]) + "','" + Integer.parseInt(data[0]) + "','" + cvv + "','" + ctype + "')";
		int i = st2.executeUpdate(query);
		if(i>0)
		{
			//notify user after successful saving of card and redirect to Add credit card page
			out.println("<script type=\"text/javascript\">");
		      out.println("alert('Card saved!! ');");
		      out.println("location='AddCC.jsp?user="+user+"';");
		      out.println("</script>");
	  	}
		else
		{
			//notify user on unsuccessful saving of card and redirect to Add credit card page
			out.println("<script type=\"text/javascript\">");
		      out.println("alert('Could not save card!! ');");
		      out.println("location='AddCC.jsp?user="+user+"';");
		      out.println("</script>");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
<ul class="lavaLampWithImage">
   <li class="current"><a href="UserHome.jsp?user=<%=user %>">Home</a></li>
   <li class="current"><a href="Book.jsp?user=<%=user %>">Book</a></li>
   <li class="current"><a href="ViewBookings.jsp?user=<%=user %>">View</a></li>
   <li class="current"><a href="Cancel.jsp?user=<%=user %>">Cancel</a></li>
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