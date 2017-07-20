<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<div id="site_content" style="min-height:400px">
<div id="sidebar_container">
<script type="text/javascript">
//function that displays div according to the id of the chosen radiobutton(SignUp/SignIn)
function yesnoCheck() {
    if (document.getElementById('Up').checked) {
        document.getElementById('signUp').style.display = 'block';
        document.getElementById('signIn').style.display = 'none';
    }
    else{
    	document.getElementById('signIn').style.display = 'block';
    	document.getElementById('signUp').style.display = 'none';
    }
}
</script>
<div id="welcome">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iiWELCOMEii</h3>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="Up"> Sign Up</h2>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="In"> Sign In</h2>
  ------------------------------------------------------------------------------------
</div>
<div id="signUp" style="display:none">Sign Up
<form name=register method=POST action=Register.jsp>
<p>>> Full Name : <input type=text name=fname required></p>
<p>>> Address : &nbsp;&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="20" name=address required></textarea></p>
<p>>> City : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=city required></p>
<p>>> Username : <input type=text name=uname required></p>
<p>>> Password : &nbsp;<input type=password name=pwd required></p>
<p>>> Email : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=email required>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value=" SignUp "></p>
</form>
</div>
<div id="signIn" style="display:none">
<h3>Sign In</h3>
<form name=login method=POST action=Login.jsp>
<p>Username : <input type=text name=name></p>
<p>Password : <input type=password name=pwd></p>
<input type=submit value=" Sign In ">
</form>
</div>
</div>
<div id="content">
<img width="450" height="450" src="images/charge_station.jpg" alt="photo_one" />
</div>
</div>
</div>
</body>
</html>