<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Set" %>

<!DOCTYPE html>
<html>
<head>
<title>CLOUD k9</title>
<style> 
	body {
		background-color: #faf5f0; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	table {
		border: 1px solid #a2bbfc; 
		border-collapse: collapse;
		width: 80%;
		margin-top: 20px;
		margin-left: auto;
		margin-right: auto;
	}

	th, td {
		border: 1px solid #a2bbfc; 
		padding: 10px;
		text-align: left;
	}

	th {
		background-color: #a2bbfc;
		color: white;
	}

	h1 {
		color: #a2bbfc; 
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

	input[type=text] {
        width: 25%;
        padding: 10px 17px;
        margin: 8px 0;
        box-sizing: border-box;
    }

	input[type=submit] {
        background-color: #a2bbfc;
  		border: none;
		color: white;
		padding: 10px 25px;
		border-radius: 8px;
		margin: 2px 2px;
    }

	input[type=reset] {
        background-color: #a2bbfc;
  		border: none;
		color: white;
		padding: 10px 25px;
		border-radius: 8px;
		margin: 2px 2px;
    }

	select {
		padding: 10px 17px;
		border: none;
		border-radius: 4px;
	}

	ul {
		list-style-type: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
		background-color: #a2bbfc;
}

	li {
		float: left;
	}

	li a {
		display: block;
		color: white;
		text-align: center;
		padding: 14px 16px;
		text-decoration: none;
	}


	a {
		text-decoration: none;
		color: #5D5348;
	}

	</style>
</head>
<body>

<%@ include file="header.jsp" %>


<h2> Search for the products you want to buy: </h2>


<form method="get" action="listprod.jsp">
<select name="categoryOption">
	<option value="All">All</option>
	<option value="1">Cats</option>
	<option value="2">Dogs</option>
	<option value="3">Fish</option>
	<option value="4">Birds</option>
</select>

<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% 
String name = request.getParameter("productName"); // Get product name to search for
String categoryNum = request.getParameter("categoryOption"); 
		
//Note: Forces loading of SQL Server driver
if(name != null) {
	try {	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw"; 

		Connection con = null;														//Create variables for connection
		PreparedStatement pstmt = null;
		ResultSet rst = null;
		String SQL;

		try {
			con = DriverManager.getConnection(url, uid, pw);						// Make the connection

			if (name.equals("") && categoryNum.equals("All")) {
				// Show all products
				SQL = "SELECT * FROM Product";
				pstmt = con.prepareStatement(SQL);
			} else if (name.equals("")) {
				// Show products based on category
				SQL = "SELECT * FROM Product WHERE categoryId = ?";
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, categoryNum);
			} else {
				// Show products based on search term and category
				if(categoryNum.equals("1") | categoryNum.equals("2") | categoryNum.equals("3") | categoryNum.equals("4")) {
					SQL = "SELECT * FROM Product WHERE productName LIKE ? AND categoryId = ?";
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, "%" + name + "%");
					pstmt.setString(2, categoryNum);
				} else {
					SQL = "SELECT * FROM Product WHERE productName LIKE ?";
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, "%" + name + "%");
				}
			}
			rst = pstmt.executeQuery();

			if(!rst.isBeforeFirst()) { //if the cursor is not at the default position (top of the table), then print no products with given name
				out.println("<h2> No products found containing " + name + "</h2>");
			} else {
				if (name.equals("") && categoryNum.equals("All")) {
					// Show all products
					out.println("<h2> Showing All Products </h2>");
				} else if (name.equals("")) {
					// Show products based on category
					if(categoryNum.equals("1")) {
						out.println("<h2> Showing All Products in Category 'Cats' </h2>");
					} else if(categoryNum.equals("2")) {
						out.println("<h2> Showing All Products in Category 'Dogs' </h2>");
					} else if(categoryNum.equals("3")) {
						out.println("<h2> Showing All Products in Category 'Fish' </h2>");
					} else if(categoryNum.equals("4")) {
						out.println("<h2> Showing All Products in Category 'Fish' </h2>");
					} else {
						out.println("<h2> Showing All Products in All Categories </h2>");
					}
				} else {
					// Show products based on search term and category
					if(categoryNum.equals("1")) {
						out.println("<h2> Showing Products Containing '" + name + "' in Category 'Cats' </h2>");
					} else if(categoryNum.equals("2")) {
						out.println("<h2> Showing Products Containing '" + name + "' in Category 'Dogs' </h2>");
					} else if(categoryNum.equals("3")) {
						out.println("<h2> Showing Products Containing '" + name + "' in Category 'Fish' </h2>");
					} else if(categoryNum.equals("4")) {
						out.println("<h2> Showing Products Containing '" + name + "' in Category 'Fish' </h2>");
					} else {
						out.println("<h2> Showing Products Containing '" + name + "' in All Categories </h2>");
					}
				}			
			} 	

				out.println("<table>");												//start table
					out.println("<tr>");											//start new row for headers
						out.println("<th> Add to Cart </th>");
						out.println("<th> Product Name - Click to Learn More! </th> ");
						out.println("<th> Price </th>");
					out.println("</tr>");											//end row
					

					Set<String> deleteProducts = (Set<String>) session.getAttribute("deleteProducts");

					while(rst.next()) {												//iterate through SQL output to print matching products
						int id = rst.getInt("productId");

						//check if it has been marked 'deleted' first, if it has, don't print it
						if(deleteProducts == null || !deleteProducts.contains(String.valueOf(id))) {
							String pname = rst.getString("productName");
						double pprice = rst.getDouble("productPrice");
						
						out.println("<tr>");										//new row, print add to cart link, product name, and price
						out.println("<td><a href='addcart.jsp?id=" + id + "&name=" + URLEncoder.encode(pname, "UTF-8") + "&price=" + pprice + "'>Add to Cart</a></td>");
						out.println("<td><a href='product.jsp?id=" + id + "&name=" + URLEncoder.encode(pname, "UTF-8") + "&price=" + pprice + "'>" + pname + "</a></td>");
						out.println("<td>" + NumberFormat.getCurrencyInstance().format(pprice) + "</td>");
                		out.println("</tr>");										//end row
					
						}
					}
				
					
				out.println("</table>");											//end the table
					
					} catch (SQLException ex) {
						out.println("SQLException: " + ex.getMessage());
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
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	} 
}
%>
</body>
</html>