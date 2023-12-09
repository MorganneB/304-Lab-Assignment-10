<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%@ include file="jdbc.jsp" %>

<html>
<head>
<title> Product Information </title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>

	a {
		text-decoration: none;
		color: #7ca0fc;
	}

	.add {
		background-color: #a2bbfc;
  		border: none;
		color: white;
		padding: 8px 19px;
		border-radius: 6px;
		margin: 2px 2px;
		font-size: 14px;
	}

	img {
		padding: 20px,20px,30px,30px; 
		width: 20%;
		margin-left: auto;

	}

	h3 {
		color: #7ca0fc;
		padding-left: 20px;
		margin-left: auto;
		margin-right: auto;
	}
	

	.productPage {
		padding-bottom: 10px;
		padding-left: 20px;
	}

	table {
		border: 1px solid #7ca0fc; 
		border-collapse: collapse;
		width: 50%;
		margin-top: 20px;
		margin-left: auto;
		margin-right: auto;
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
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product

String productId = request.getParameter("id");
try {
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw"; 

	Connection con = null;														//Create variables for connection
	PreparedStatement pstmt = null;
	ResultSet rst = null;

	try {
		con = DriverManager.getConnection(url, uid, pw);
		String sql = "SELECT productName, productId, productDesc, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, productId);
		rst = pstmt.executeQuery();

		out.print("<div class = \"productPage\">");
		while(rst.next()) {										
			int id = rst.getInt("productId");
			String pname = rst.getString("productName");
			double pprice = rst.getDouble("productPrice");
			String pURL = rst.getString("productImageURL");
			String pDesc = rst.getString("productDesc");
			String pBin = rst.getString("productImage");

			out.println("<h1>&emsp;" + pname + "</h1>");

			//If there is a productImageURL, display using IMG tag
			if(pURL != null) {										
				out.println("<img src= " + pURL + " >");										
			}

			//  Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
			if(pBin != null) {
				out.println("<img src= 'displayImage.jsp?id=" + id + "' ><br>");
			}
			out.println("<br><br><b>&emsp; Product ID:</b> " + id);

			out.println("<br><b>&emsp; Price:</b> " + NumberFormat.getCurrencyInstance().format(pprice) + "<br><br>");
			out.println("&emsp;&emsp; " + pname + " includes " + pDesc);

			//Reviews
			out.println("<h3>Product Reviews: </h3>");
            String reviewSQL = "SELECT productId, reviewRating, reviewDate, customerId, reviewComment FROM review WHERE productId = ?";
            PreparedStatement pstmt2 = con.prepareStatement(reviewSQL);
            pstmt2.setInt(1, id);
            ResultSet rst2 = pstmt2.executeQuery();
			
			boolean reviewExists = false;

            while (rst2.next()) {
				reviewExists = true;
                int rating = rst2.getInt("reviewRating");
                Date date = rst2.getDate("reviewDate");
                int customerId = rst2.getInt("customerId");
                String comment = rst2.getString("reviewComment");

				out.println("<h4> Customer ID: " + customerId + "<br>Date: " + date + "</h4>");
				out.println("Rating: " + rating + "<br> Comment: " + comment);
			}

			if(!reviewExists) {
				out.println("&emsp; &emsp;This item has no reviews.");
			}

			boolean authenticated = session.getAttribute("authenticatedUser") != null;
    		if (authenticated) {
				out.print("&emsp; &emsp; &emsp;<br><br><a class = \"add\" href='addReview.jsp'> Add A Review </a>");
    		} 

			//inventory by warehouse
            out.println("<br><br><br><h3>Inventory: </h3>");

            String warehouseSQL = "SELECT w.warehouseName, pi.quantity FROM warehouse w JOIN productinventory pi ON w.warehouseId = pi.warehouseId WHERE pi.productId = ?";
            PreparedStatement pstmt3 = con.prepareStatement(warehouseSQL);
            pstmt3.setInt(1, id);
            ResultSet rst3 = pstmt3.executeQuery();
			int quantity = 0;

            out.println("<table>");
            out.println("<tr><th>Warehouse</th> <th>Quantity</th></tr>");

            while (rst3.next()) {
                String warehouseName = rst3.getString("warehouseName");
                quantity = rst3.getInt("quantity");
                out.println("<tr><td>" + warehouseName + "</td><td>" + quantity + "</td></tr>");
            }

            out.println("</table>");

			out.println("<br><h3><a href='addcart.jsp?id=" + id + "&name=" + URLEncoder.encode(pname, "UTF-8") + "&price=" + pprice + "'> Add to Cart </a></h3>");
			out.println("<h3><a href='listprod.jsp'> Continue Shopping </a></h3>");

			out.print("</div>");
		}
	

		} catch (SQLException ex) {
			out.println("Exception: " + ex);
		} finally {
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
} catch (NullPointerException ex) {
	out.println("Exception: " + ex);
}

		
%>

</body>
</html>
