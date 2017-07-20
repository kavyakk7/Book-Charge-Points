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
<ul class="lavaLampWithImage">
</ul>
<div id="site_content">
<div id="sidebar_container">
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=session.getAttribute("username").toString() %>  !</h3>
<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancel A Booked Charge Point : </h2>
<form name=cancel method=POST action="CancelCP.jsp">
<%
//Get and set session
String user = session.getAttribute("username").toString();
if(user==null)
	user=request.getParameter("user");
session.setAttribute("username",user);
// Get values of checked boxes
String[] delete = request.getParameterValues("bid");
// variable 'bookid'is used for querying
String bookid = "(";
for (int i = 0; i < delete.length; i++) 
{
	if(i==delete.length-1)
		bookid+="\'"+delete[i]+"\'";
	else
		bookid+="\'"+delete[i]+"\',";
}
bookid+=")";
// Deleting the selected booking details from the table 'booked'
try 
{
	Statement st = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
	Connection connection = null;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	st = connection.createStatement();
    String query = "Delete from booked where bookid in "+bookid+"";
    st.execute(query);
    out.println("<script type=\"text/javascript\">");
	out.println("alert('Cancelled Booking!! ');");
	out.println("location='Book.jsp?user="+user+"';");
	out.println("</script>");
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Could not Cancel!");
}
%>
</form>
</div>
</div>
</div>
</body>
</html>