<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.util.Properties" %> 
<%@ page import="javax.mail.Message" %> 
<%@ page import="javax.mail.MessagingException" %> 
<%@ page import="javax.mail.PasswordAuthentication" %> 
<%@ page import="javax.mail.Session" %> 
<%@ page import="javax.mail.Transport" %> 
<%@ page import="javax.mail.internet.InternetAddress" %> 
<%@ page import="javax.mail.internet.MimeMessage" %>
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
// Get and Set session
String user = session.getAttribute("username").toString();
if(user==null)
	user=request.getParameter("user");
session.setAttribute("username",user);
// Get input field values
String currcity=request.getParameter("currcity");
String destcity=request.getParameter("destcity");
String date=request.getParameter("date");
String time=request.getParameter("time");
String cp = request.getParameter("acp");
//insert values into table 'booked'
try
		{
			Statement statement2 = null;
		    ResultSet rs2 = null;
		    String connectionURL2 = "jdbc:mysql://localhost:3307/bookcp";
		    Connection connection2 = null; 
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			connection2 = DriverManager.getConnection(connectionURL2, "root", "root");
			Statement st2 = connection2.createStatement();
			int i = st2.executeUpdate("insert into booked values(null, '"+user+"','"+cp+"','" + currcity + "','" + destcity + "','" + date + "','" + time + "')");
			if(i>0)
			{
				String email = "";
				try
		  		{
		  			Statement statement3 = null;
		  		    ResultSet rs3 = null;
		  		    String connectionURL3 = "jdbc:mysql://localhost:3307/bookcp";
		  		    Connection connection3 = null; 
		  		  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		  		  	connection3 = DriverManager.getConnection(connectionURL3, "root", "root");
		  		  	Statement st3 = connection3.createStatement();
		  		  	String QueryString3 = "Select * from user where username='"+user+"'";
		  		  	rs3 = st3.executeQuery(QueryString3);
		  		  	if(rs3!=null)
		  		  	{
		  		  	while(rs3.next())
		  		  	{
		  		  		email=rs3.getString(6);
		  		  	}
		  		  	}
		  		}
		  		catch(Exception e)
		  		{
  			e.printStackTrace();
		  		}
				// Send mail to the user on successful booking
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "587");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.starttls.enable", "true");
			Session sess = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("kanchabansal1212@gmail.com", "kukarobot");//change accordingly  
			}
			});
			try {
			MimeMessage message = new MimeMessage(sess);
			message.setFrom(new InternetAddress("kanchabansal1212@gmail.com"));//change accordingly  
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("Booked Charging Point Details ");
			message.setText("Hello,\nYou have booked a charging point. The details are as follows :\n\n CP : "+cp+"\n From City : "+currcity+" \n To City : "+destcity+"\n Date : "+date+"\n Time : "+time+"\n\n Thank You\n");
			Transport.send(message);
			//notify user after successful booking and redirect to prev page
			out.println("<script type=\"text/javascript\">");
		      out.println("alert('Booked successfully!! ');");
		      out.println("location='Book.jsp?user="+user+"';");
		      out.println("</script>");
			} 
			catch (MessagingException e) 
			{
			e.printStackTrace();
			throw new RuntimeException(e);
			}
				
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
		 	      out.println("alert('Could not book. Try again!! ');");
		 	      out.println("location='Book.jsp?user="+user+"';");
			      out.println("</script>");
			}
		}
		catch(Exception e)
		{
			System.out.println("Could not book!!");
			e.printStackTrace();
		}
 %>
 
<ul class="lavaLampWithImage">
   <li class="current"><a href="Home.jsp">Logout</a></li>
   <li class="current"><a href="Book.jsp?use">Book</a></li>
   <li class="current"><a href="Cancel.jsp?user=">Cancel</a></li>
</ul>
<div id="site_content">
<div id="sidebar_container">
<h3> &nbsp;&nbsp;&nbsp;&nbsp;Hi <%=user %> !</h3>
<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Book A Charging Point : Step 1 </h2>
<form name=book method=POST action="CheckACP.jsp">
<p>&nbsp;&nbsp;&nbsp;&nbsp;Current City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <select name=currcity required>
<option> --Select Current City-- </option>
</select></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Destination City&nbsp;&nbsp;: <select name=destcity required>
<option> --Select Destination City-- </option>
</select></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="date" name=ondate required></p>
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