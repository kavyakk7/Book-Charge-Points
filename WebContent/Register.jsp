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
<%
//Get values from the input fields
String fname = request.getParameter("fname");
String add = request.getParameter("address");
String city = request.getParameter("city");
String uname = request.getParameter("uname");
String pwd = request.getParameter("pwd");
String email = request.getParameter("email");
//Insert the values into table 'user'
try
{
	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3307/bookcp";
    Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	int i = st.executeUpdate("insert into user values('"+uname+"','"+fname+"','"+add+"','" + city + "','" + pwd + "','" + email + "')");
	if(i>0)
	{
		//Send mail to the user on successful registration
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
		message.setSubject("Registration successful ");
		message.setText("Hello "+fname+",\n\n Thank You for Signing Up. Have a nice day!!\n");
		Transport.send(message);
		//notify user after successful registration and redirect to home page for login
		out.println("<script type=\"text/javascript\">");
	    out.println("alert('Successfully Registered!! ');");
	    out.println("location='Home.jsp';");
	    out.println("</script>");
		} catch (MessagingException e) {
		e.printStackTrace();
		throw new RuntimeException(e);
		}
		
	}
	else
	{
		//notify user on unsuccessful registration and redirect to home page for registering again
		out.println("<script type=\"text/javascript\">");
 	    out.println("alert('Could not add you. Try Again!! ');");
 	    out.println("location='Home.jsp';");
 	    out.println("</script>");
	}
}
catch(Exception e)
{
	System.out.println("Could not connect to db!!");
	e.printStackTrace();
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