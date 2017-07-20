<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@page import="algorithm.Dijkstra"%>
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
<%
//Get values of input fields
String currcity=request.getParameter("currcity");
String destcity=request.getParameter("destcity");
String date=request.getParameter("date");
String time=request.getParameter("time");
%>
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=user %> !</h3>
<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Book A Charging Point : Step 2 </h2>
<form name=book method=POST action="BookingCP.jsp">
<input type=hidden name=user value='<%=user%>'>
<p>Current City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <input type=text name=currcity value='<%=currcity %>' readonly></p>
<p>Destination City&nbsp;&nbsp;: <input type=text name=destcity value='<%=destcity %>' readonly></p>
<p>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type=text name=date value='<%=date %>' readonly></p>
<p>Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type=text name=time value='<%=time %>' readonly></p>
<p>Available Charge Points* : CP<select name=acp>
<option>-Select Charge Point-</option>
<%
//variable 'cps' stores the charge points that are available, i.e.,the CPs that do not clash with the required data and time
ArrayList<Integer> cps = new ArrayList<Integer>();
try
	{
		Statement statement1 = null;
	    ResultSet rs1 = null;
	    String connectionURL1 = "jdbc:mysql://localhost:3307/bookcp";
	    Connection connection1 = null; 
	  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	  	connection1 = DriverManager.getConnection(connectionURL1, "root", "root");
	  	Statement st1 = connection1.createStatement();
	  	String QueryString1 = "select cpid from chargepoint where cpid not in (select cpid from booked where ondate='"+date+"' and time='"+time+"')";
	  	rs1 = st1.executeQuery(QueryString1);
	  	int i = 1;
	  	while(rs1.next())
	  	{
	  		%>
	  		<option><%=rs1.getString(1) %></option>
	  		<%
	  		cps.add(Integer.parseInt(rs1.getString(1)));
	  	}
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}
%>
</select></p>
<p>List of Nearest Charge Points using Dijkstra Algorithm : <br></p>
<%
int n = 0; // number of charge points available in the system which is queried from the table 'chargepoint'
try
	{
		Statement statement1 = null;
	    ResultSet rs1 = null;
	    String connectionURL1 = "jdbc:mysql://localhost:3307/bookcp";
	    Connection connection1 = null; 
	  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	  	connection1 = DriverManager.getConnection(connectionURL1, "root", "root");
	  	Statement st1 = connection1.createStatement();
	  	String QueryString1 = "select count(*) from chargepoint";
	  	rs1 = st1.executeQuery(QueryString1);
	  	if(rs1.next())
	  	{ 	
	  		n=Integer.parseInt(rs1.getString(1));
	  	}
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}
n+=1; //Altered to create of matrix required for Dijkstra algorithm
int graph[][] = new int[n][n]; // matrix for Dijkstra Algorithm which holds the distance between points
graph[0][0] = 0; // distance between same ponts is 0
//Get distances between the given city and the charge points and store in 'graph[][]'
try
{
	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "select * from distance_citytocp where city='"+currcity+"'";
  	rs = st.executeQuery(QueryString);
  	while(rs.next())
  	{ 	
  		int i = 0;
  		for(int j=1;j<n;j++)
  		{
  			graph[i][j]=Integer.parseInt(rs.getString(j+1));
  			graph[j][i]=graph[i][j];
  		}
  	}
  //Get distances from one charge point to another and store in 'graph[][]'
  	try
  	{
  		Statement statement1 = null;
  	    ResultSet rs1 = null;
  	    String connectionURL1 = "jdbc:mysql://localhost:3307/bookcp";
  	    Connection connection1 = null; 
  	  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	  	connection1 = DriverManager.getConnection(connectionURL1, "root", "root");
  	  	Statement st1 = connection1.createStatement();
  	  	String QueryString1 = "select * from distance_cptocp";
  	  	rs1 = st1.executeQuery(QueryString1);
  	  	int i = 1;
  	  	while(rs1.next())
  	  	{ 	
	  	 if(i<n)
	  	{
	  		 for(int j=1;j<n;j++)
	  	  	{
	  	  		graph[i][j]=Integer.parseInt(rs1.getString(j+1));
	  	  		graph[j][i]=graph[i][j];
	  	  	}
	  	  	i+=1;
	  	  }
  	  	}
  	}
  	catch(Exception e)
  	{
  		e.printStackTrace();	
  	}
}
catch(Exception e)
{
	e.printStackTrace();	
}
/* Call Dijkstra algorithm;
passing the matrix, 'graph[][]' and number of CPs,  'n';
returns an ArrayList<Integer> containing the value of the nearest CP!
*/
ArrayList<Integer> path = Dijkstra.main(graph,n);  
//Print list of Nearest CP
for(int i = 0;i<path.size()-1;i++)
{
	if(cps.contains(path.get(i)))
	{
	%>
	<p>&nbsp;&nbsp;&nbsp;CP<%=path.get(i) %> - Available</p>
	<%
	}
	else{
		%>
		<p>&nbsp;&nbsp;&nbsp;CP<%=path.get(i) %> - Not Available</p>
		<%
		}
}
%>
***If the Nearest CP is available choose that CP in the Available Charge Points* field and then click Book!
<input type=submit value=" Book Charge Point ">
</form>
</div>
<div id="content">
<img width="450" height="450" src="images/Mmap.png" alt="map" />
</div>
</div>
</div>
</body>
</html>