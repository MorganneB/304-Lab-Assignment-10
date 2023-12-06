<!DOCTYPE html>
<html>
<head>
<title>Morganne and Bella's Grocery</title>
    <style>
        body {
            background-color: #ffe6f3; 
            color: #5D5348; 
            font-family: Arial, sans-serif;
        }
    
        h1 {
            color: #ff67ca; 
            font-size: 1.6em; 
        }
    
        h2 {
            color: #f991e1; 
            font-size: 1.6em; 
            text-align: center; 
        }

        input[type=text] {
            width: 25%;
            padding: 10px 17px;
            margin: 8px 0;
            box-sizing: border-box;
        }
    
        input[type=submit] {
            background-color: #f991e1;
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
    </style>
</head>

<body>

    <%@ include file="header.jsp" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="auth.jsp" %>

    <br>
    <h3 style="float:left"> Fill in the following fields to add a product: </h3> <br><br><br><br>
    <form action="addProduct.jsp" method="post">
        <label for="pname">Product Name: </label><br>
        <input type="text" id="pname" name="pname"><br>
        <br>

        Category:<br>
        <input type="radio" id="1" name="categoryChoice" value="1">
        <label for="1">Cats</label><br>
        <input type="radio" id="2" name="categoryChoice" value="2">
        <label for="2">Dogs</label><br>
        <input type="radio" id="3" name="categoryChoice" value="3">
        <label for="3">Fish</label><br>
        <input type="radio" id="4" name="categoryChoice" value="3">
        <label for="4">Birds</label><br>

        <br>
        <label for="pdesc">Description: </label><br>
        <input type="text" id="pdesc" name="pdesc">
        <br><label for="pprice">Price: </label><br>
        <input type="text" id="pprice" name="pprice">
        <br><br> <input type="submit" value="Add to Store">
    </form>

    <%
    String pname = request.getParameter("pname"); // 
    String categoryNum = request.getParameter("categoryChoice"); 
    String pdesc = request.getParameter("pdesc"); 
    String pprice = request.getParameter("pprice"); 

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw"; 

		Connection con = null;														
		PreparedStatement pstmt = null;
		ResultSet rst = null;
		String SQL;

        try {
            con = DriverManager.getConnection(url, uid, pw);						

            if (pname == null || categoryNum == null || pdesc == null || pprice == null) {
                throw new NullPointerException("All fields are required.");
            }

            if (pname.isEmpty() || categoryNum == null || pdesc.isEmpty() || pprice.isEmpty()) {
                throw new IllegalArgumentException("All fields are required.");
            }

            SQL = "INSERT product(productName, categoryId, productDesc, productPrice) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(SQL);
            pstmt.setString(1, pname);
			pstmt.setInt(2, Integer.parseInt(categoryNum));
            pstmt.setString(3, pdesc);
            pstmt.setDouble(4, Double.parseDouble(pprice));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.print("<h3>Product Added Successfully!</h3>");
                out.println("<h2><a href=\"listprod.jsp\">Go to Products</a></h2>");
            } else {
                out.print("<h3>Failed to add product. Please fill in all fields correctly! </h3>");
            }

        } catch (NumberFormatException e) {
            out.print("<h3>Error: Invalid number format. Please enter a valid number for the price.</h3>");
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            out.print("<h3>Error: " + e.getMessage() + "</h3>");
        } catch (SQLException e) {
            out.print("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        } catch (Exception e) {
            out.print("<h3>Unexpected error occurred. Please try again.</h3>");
            e.printStackTrace();
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

    } catch (Exception e) {
        e.printStackTrace();
    } 
    %>
</body>
</html>