<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
    body {
		background-color: #ffe6f3; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	table {
		border: 1px solid #ff67ca; 
		border-collapse: collapse;
		width: 100%;
		margin-top: 20px;
	}

	th, td {
		border: 1px solid #ff67ca; 
		padding: 10px;
		text-align: left;
	}

	th {
		background-color: #ffc1f1;
		color: white;
	}

	h2 {
		color: #ff67ca; 
		font-size: 1.1em; 
	}
</style>
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>

<%

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";	// Make connection	
String uid = "sa";
String pw = "304#sa#pw";

Connection con = null;						
PreparedStatement pstmt = null;
ResultSet rst = null;

try {
    con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();

	//Print out orders
	String sql = "SELECT CONVERT(VARCHAR, orderDate, 23) AS formatDate, SUM(totalAmount) AS total " +
    "FROM ordersummary GROUP BY CONVERT(VARCHAR, orderDate, 23)";
    pstmt = con.prepareStatement(sql);
    rst = pstmt.executeQuery();

    out.println("<h2> Adminstrator Sales Report by Day </h2>");
    out.println("<table>"); 							
        out.print("<tr>"); 							
            out.println("<th>Order Date:</th>"); 		
            out.println("<th>Total Order Amount:</th>"); 		
        out.println("</tr>");

    while(rst.next()) {	
        String orderDate = rst.getString("formatDate");
        double total = rst.getDouble("total");

        out.println("<tr>"); 
            out.println("<td>" + orderDate + "</td>");
            out.println("<td> $" + total + "</td>"); 
        out.println("</tr>");
    }

    out.println("</table>");

	//print out all customers
	String customersql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer";

	PreparedStatement pstmt1 = con.prepareStatement(customersql);
    ResultSet rst1 = pstmt1.executeQuery();

	out.println("<h2> Customer Accounts </h2>");
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
        out.println("</tr>");
	
		while(rst1.next()) {	
			String customerId = rst1.getString(1); 
			String firstName = rst1.getString(2); 
			String lastName = rst1.getString(3); 
			String email = rst1.getString(4);  
			String phonenum = rst1.getString(5); 
			String address = rst1.getString(6); 
			String city = rst1.getString(7); 
			String state = rst1.getString(8); 
			String postalCode = rst1.getString(9); 
			String country = rst1.getString(10); 
			String userid = rst1.getString(11);

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
			out.println("</tr>");
    	}		
	
	out.println("</table>");

} catch (SQLException ex) {
    out.println(ex);
} finally {
    try {																								//Close all connections
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


%>

</body>
</html>

