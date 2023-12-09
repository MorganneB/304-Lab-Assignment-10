<%@ page import="java.sql.Date" %>
<%@ page import ="java.util.Calendar" %>


<!DOCTYPE html>
<html>
<head>
<title>CLOUD k9</title>
    <style>
        body {
            background-color: #ffe6f3; 
            color: #5D5348; 
            font-family: Arial, sans-serif;
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
    <h3 style="float:left"> Fill in the following fields to add a review! </h3> <br><br><br><br>
    <form action="addReview.jsp" method="post">
        <label for="productId">Product ID: </label><br>
        <input type="text" id="productId" name="productId" required><br>
        <br>
    
        <label for="reviewRating">Rating (1-5): </label><br>
        <input type="text" id="reviewRating" name="reviewRating" required><br>
        <br>
    
        <label for="reviewComment">Review Comment: </label><br>
        <textarea id="reviewComment" name="reviewComment" rows="4" required></textarea><br>
        <br>
    
        <input type="submit" value="Submit Review">
    </form>

    <%
    
    String rpid = request.getParameter("productId");
    String pRating = request.getParameter("reviewRating");
    String pComment = request.getParameter("reviewComment");

    if (rpid != null && !rpid.isEmpty() && pRating != null && !pRating.isEmpty() && pComment != null && !pComment.isEmpty()) {

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw"; 

		Connection con = null;														
		PreparedStatement pstmt = null;

        try {
            con = DriverManager.getConnection(url, uid, pw);	
            
            Date currentDate = new Date(Calendar.getInstance().getTime().getTime());

            String sql = "INSERT INTO review (productId, reviewRating, reviewDate, reviewComment) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(rpid));
            pstmt.setInt(2, Integer.parseInt(pRating));
            pstmt.setDate(3, currentDate);
            pstmt.setString(4, pComment);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.print("<h3>Review Submitted Successfully!</h3>");
                out.println("<h2><a href=\"product.jsp?id=" + rpid + "\">Go back to Product</a></h2>");
            } else {
                out.print("<h3>Failed to submit review. Please fill in all fields correctly!</h3>");
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
} 
    %>
</body>
</html>