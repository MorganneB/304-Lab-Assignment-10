<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<style>
    body {
		background-color: faf5f0; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	table {
		border: 1px solid #7ca0fc; 
		border-collapse: collapse;
		width: 100%;
		margin-top: 20px;
	}

	th, td {
		border: 1px solid #7ca0fc; 
		padding: 10px;
		text-align: left;
	}

	th {
		background-color: #a2bbfc;
		color: white;
	}
	h1 {
		color: #7ca0fc; 
		font-size: 1.6em; 
	}

	h2 {
		color: #a2bbfc; 
		font-size: 1.6em; 
		text-align: center; 
	}

	h3 {
		color: #a2bbfc; 
		font-size: 1.2em; 
	}

	input[type=submit] {
		background-color: #a2bbfc;
		border: none;
		color: white;
		padding: 8px 12px;
		border-radius: 8px;
		margin: 20px 20px;
	}

</style>

<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<h2>Customer Profile</h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	String cid = (String) session.getAttribute("customerId");
%>

<%
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make connection

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	  Statement stmt = con.createStatement();)
{
		String SQL = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM customer WHERE userId = ?"; 
	
		PreparedStatement pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, userName);

		ResultSet rst = pstmt.executeQuery(); 

		//Iterate through each order 
		while (rst.next()){ 

		String customerId = rst.getString(1); 
		String firstName = rst.getString(2); 
		String lastName = rst.getString(3); 
		String email = rst.getString(4);  
		String phonenum = rst.getString(5); 
		String address = rst.getString(6); 
		String city = rst.getString(7); 
		String state = rst.getString(8); 
		String postalCode = rst.getString(9); 
		String country = rst.getString(10); 
		String userid = rst.getString(11); 
		String password = rst.getString(12); 

			out.println("<table>"); 							
				out.print("<tr>"); 							
					out.println("<th>Customer Id:</th>"); 		
					out.println("<th>First Name:</th>"); 		
					out.println("<th>Last Name:</th>"); 
					out.println("<th>Email:</th>");
					out.println("<th>Phone Number:</th>"); 	
					out.println("<th>Address:</th>"); 
					out.println("<th>City:</th>"); 	
					out.println("<th>State:</th>"); 
					out.println("<th>Postal Code:</th>"); 	
					out.println("<th>Country:</th>"); 
					out.println("<th>User Id:</th>"); 
					out.println("<th>Password:</th>"); 
				out.println("</tr>");	
				out.println("<tr>"); 
					out.println("<td>" + customerId + "</td>");
					out.println("<td>" + firstName + "</td>");
					out.println("<td>" + lastName + "</td>");
					out.println("<td>" + email + "</td>");
					out.println("<td>" + phonenum + "</td>"); 
					out.println("<td>" + address + "</td>");
					out.println("<td>" + city + "</td>");
					out.println("<td>" + state + "</td>"); 
					out.println("<td>" + postalCode + "</td>");
					out.println("<td>" + country + "</td>");
					out.println("<td>" + userid + "</td>"); 
					out.println("<td>" + password + "</td>"); 
				out.println("</tr>");
			out.println("</table>");

			}
		
		out.println("<form name=\"MyForm\" method=post action=\"updateInfo.jsp\"><input class=\"submit\" type=\"submit\" name=\"Submit2\" value=\"Click here to update personal information\"></form>");
			
		out.print("<h2>Your Orders</h2>");
		String SQL1 = "SELECT orderId, orderDate, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId FROM ordersummary WHERE customerId = ?"; 
		PreparedStatement pstmt1 = con.prepareStatement(SQL1);
		pstmt1.setString(1, cid);
		ResultSet rst1 = pstmt1.executeQuery(); 

		out.println("<table>"); 							
			out.print("<tr>"); 							
				out.println("<th>Order Id:</th>"); 		
				out.println("<th>Order Date:</th>"); 		
				out.println("<th>Address:</th>"); 

			out.println("</tr>");

		while (rst1.next()){ 
			String orderId = rst1.getString(1); 
			String orderDate = rst1.getString(2); 
			String shiptoAddress = rst1.getString(3); 	

			out.println("<tr>"); 
				out.println("<td>" + orderId + "</td>");
				out.println("<td>" + orderDate + "</td>");
				out.println("<td>" + shiptoAddress + "</td>");
			out.println("</tr>");
			
		}

		out.println("</table>");

			

} catch (Exception e) {
    out.println("Exception: " + e);
}

%>

</body>

</html>

