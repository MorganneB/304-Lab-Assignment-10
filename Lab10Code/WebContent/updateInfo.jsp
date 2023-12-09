<!DOCTYPE html>
<html>
<head>
<title>Update personal information</title>
<style>
	body {
		background-color: #faf5f0; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	h2 {
<<<<<<< HEAD
		color: #a2bbfc; ; 
=======
		color: #7ca0fc; 
>>>>>>> 937ea7f06e05b82a7fb55b338a967f26f86dd518
		font-size: 1.2em; 
	}

	h3 {
<<<<<<< HEAD
		color: #a2bbfc; ; 
=======
		color: #7ca0fc; 
>>>>>>> 937ea7f06e05b82a7fb55b338a967f26f86dd518
		font-size: 1.1em; 
	}


	input[type=submit] {
<<<<<<< HEAD
        background-color: #a2bbfc; ;
=======
        background-color: #7ca0fc;
>>>>>>> 937ea7f06e05b82a7fb55b338a967f26f86dd518
  		border: none;
		color: white;
		padding: 8px 12px;
		border-radius: 8px;
		margin: 2px 4px;
    }
</style>
</head>
<body>

	<%@ include file="header.jsp" %>
	<%@ include file="jdbc.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<h2>Update personal information below</h2>
<h3>Enter your new information below, leave sections blank to keep old data</h3>

<br>
<form name="MyForm" method=post action="updateInfo.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">First Name:</font></div></td>
	<td><input type="text" name="firstname"  size=15 maxlength=30></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Last Name:</font></div></td>
	<td><input type="text" name="lastname" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Email Address:</font></div></td>
	<td><input type="text" name="email" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Phone Number:</font></div></td>
	<td><input type="text" name="phonenum" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Address:</font></div></td>
	<td><input type="text" name="address" size=15 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">City:</font></div></td>
	<td><input type="text" name="city" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">State:</font></div></td>
	<td><input type="text" name="state" size=15 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Postal Code:</font></div></td>
	<td><input type="text" name="postalcode" size=15 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Country:</font></div></td>
	<td><input type="text" name="country" size=15 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="3">Password:</font></div></td>
	<td><input type="password" name="password" size=15 maxlength="30"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Update information">
</form>
</div>

<%
String firstname = request.getParameter("firstname"); 
String lastname = request.getParameter("lastname"); 
String email = request.getParameter("email"); 
String phonenum = request.getParameter("phonenum"); 
String address = request.getParameter("address"); 
String city = request.getParameter("city"); 
String state = request.getParameter("state"); 
String postalcode = request.getParameter("postalcode");
String country = request.getParameter("country"); 
String password = request.getParameter("password"); 

try {
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw"; 

	Connection con = null;														
	PreparedStatement pstmt = null;
	ResultSet rst = null;
	String SQL = "UPDATE customer SET city = ?";
	int rowsAffected = 0; 

	try {
		con = DriverManager.getConnection(url, uid, pw);						

		if (!firstname.isEmpty() && firstname != null) {
			SQL = "UPDATE customer SET firstname = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, firstname); 
			rowsAffected = pstmt.executeUpdate(); 
		}
		if (!lastname.isEmpty() && lastname != null) {
			SQL = "UPDATE customer SET lastname = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, lastname); 
			rowsAffected = pstmt.executeUpdate(); 
		}
		if (!email.isEmpty() && email != null) {
			SQL = "UPDATE customer SET email = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, email); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!phonenum.isEmpty() && phonenum != null) {
			SQL = "UPDATE customer SET phonenum = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, phonenum); 
			rowsAffected = pstmt.executeUpdate();		
		}
		if (!address.isEmpty() && address != null) {
			SQL = "UPDATE customer SET address = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, address); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!city.isEmpty() && city != null) {
			SQL = "UPDATE customer SET city = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, city); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!state.isEmpty() && state != null) {
			SQL = "UPDATE customer SET state = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, state); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!postalcode.isEmpty() && postalcode != null) {
			SQL = "UPDATE customer SET postalcode = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, postalcode); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!country.isEmpty() && country != null) {
			SQL = "UPDATE customer SET country = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, country); 
			rowsAffected = pstmt.executeUpdate();
		}
		if (!password.isEmpty() && password != null) {
			SQL = "UPDATE customer SET password = ?";
			pstmt = con.prepareStatement(SQL); 
			pstmt.setString(1, password); 
			rowsAffected = pstmt.executeUpdate();
		}
	
		if (rowsAffected != 0) {
			out.print("<h3>Information updated Added Successfully!</h3>");
			out.println("<h2><a href=\"customer.jsp\">Go to customer profile</a></h2>");
		} else {
			out.print("<h3>Failed to update personal information. Please fill at least one field! </h3>");
			throw new NullPointerException("At least one field required.");
			} 
		}	
		catch (SQLException e) {
            out.print("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
		finally {
            try {														//Close all connections
                if (rst != null)
                    rst.close();
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (SQLException ex) {
                out.println("SQLException in finally: " + ex.getMessage());
            }
        }
	
	} catch (Exception e) {
        e.printStackTrace();
    } 
	
%>

</body>
</html>
