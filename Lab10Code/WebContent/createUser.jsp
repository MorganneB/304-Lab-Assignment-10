<!DOCTYPE html>
<html>
<head>
<title>Sign Up</title>
<style>
	body {
		background-color: #ffe6f3; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	h3 {
		color: #ff67ca; 
		font-size: 1.1em; 
	}
		
	input[type=submit] {
        background-color: #f991e1;
  		border: none;
		color: white;
		padding: 8px 12px;
		border-radius: 8px;
		margin: 2px 2px;
    }
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Create a Customer Profile</h3>

<br>
<form name="MyForm" method=post action="validateCreateUser.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Username:</font></div></td>
	<td><input type="text" name="username"  size=15 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Password:</font></div></td>
	<td><input type="password" name="password" size=15 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">First Name:</font></div></td>
	<td><input type="text" name="firstName"  size=15 maxlength=30></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Last Name:</font></div></td>
	<td><input type="text" name="lastName" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Email Address:</font></div></td>
	<td><input type="text" name="email" size=15 maxlength="30"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Create Profile">
</form>

</div>

</body>
</html>

