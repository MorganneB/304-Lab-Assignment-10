<!DOCTYPE html>
<html>
<head>
<title> Update A Product </title>
    <style>
        body {
            background-color: #faf5f0; 
            color: #5D5348; 
            font-family: Arial, sans-serif;
        }
    
        h1 {
            color: #7ca0fc; 
            font-size: 1.6em; 
        }
    
        h2 {
            color: #7ca0fc; 
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
            background-color: #7ca0fc;
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
    <h3 style="float:left"> Fill in the following fields to update a product: </h3><br><br><br><br>
    <form action="updateProduct.jsp" method="post">
        <label for="instructions">Only fill in fields you want to change. </label><br>
        <br><label for="productId">Product ID - Do Not Change: </label><br>
        <input type="text" id="productId" name="productId" required><br>
        <br>

        <label for="updatedName">Name: </label><br>
        <input type="text" id="updatedName" name="updatedName"><br>
        <br>
    
        <label for="updatedPrice">Price: </label><br>
        <input type="text" id="updatedPrice" name="updatedPrice"><br>
        <br>
        
        <label for="updatedDesc">Description: </label><br>
        <input type="text" id="updatedDesc" name="updatedDesc"><br>
        <br>
    
        <input type="submit" value="Submit Update">
    </form>

    <%

    String pid = request.getParameter("productId"); 
    String updatedName = request.getParameter("updatedName");
    String updatedPrice = request.getParameter("updatedPrice"); 
    String updatedDesc = request.getParameter("updatedDesc");

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw"; 

        Connection con = null;														
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        String SQL;
        int rowsAffected = 0; 

        try {
            con = DriverManager.getConnection(url, uid, pw);	

            if (!updatedName.isEmpty() && updatedName != null) {
                SQL = "UPDATE product SET productName = ? WHERE productId = ?";
                pstmt = con.prepareStatement(SQL); 
                pstmt.setString(1, updatedName); 
                pstmt.setInt(2, Integer.parseInt(pid)); 
                rowsAffected = pstmt.executeUpdate();
            }
            if (!updatedPrice.isEmpty() && updatedPrice != null) {
                SQL = "UPDATE product SET productPrice = ? WHERE productId = ?";
                pstmt = con.prepareStatement(SQL); 
                pstmt.setDouble(1, Double.parseDouble(updatedPrice)); 
                pstmt.setInt(2, Integer.parseInt(pid)); 
                rowsAffected = pstmt.executeUpdate();
            }
            if (!updatedDesc.isEmpty() && updatedDesc != null) {
                SQL = "UPDATE product SET productDesc = ? WHERE productId = ?";
                pstmt = con.prepareStatement(SQL); 
                pstmt.setString(1, updatedDesc); 
                pstmt.setInt(2, Integer.parseInt(pid)); 
                rowsAffected = pstmt.executeUpdate();
            }

            if (rowsAffected != 0) {
                out.print("<h3>Product updated Added Successfully!</h3>");
                out.println("<h2><a href=\"listprod.jsp\"> View All Products</a></h2>");
            } else {
                out.print("<h3>Failed to update product information. Please fill at least one field! </h3>");
                throw new NullPointerException("At least one field required.");
                } 
            } catch (SQLException e) {
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
        out.println("Error updating this product: " + e.getMessage());
    }

%>
</body>
</html>