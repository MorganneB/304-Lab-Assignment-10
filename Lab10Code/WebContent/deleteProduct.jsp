<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>


<!DOCTYPE html>
<html>
<head>
<title> Delete A Product </title>
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
    <h3 style="float:left"> Fill in the following fields to delete a product: </h3><br><br><br><br>
    <form action="deleteProduct.jsp" method="post">
        <br><label for="productId">Product ID: </label><br>
        <input type="text" id="productId" name="productId" required><br>
        <br>
        <input type="submit" value="Submit Delete">
    </form>

    <%

    String pid = request.getParameter("productId"); 

    try {
        Set<String> deleteProducts = (Set<String>) session.getAttribute("deleteProducts");
    
        if (deleteProducts == null) {
            deleteProducts = new HashSet<>();
        }
    
        if (pid != null && !pid.isEmpty()) {
            // Mark the product as 'deleted' 
            deleteProducts.add(pid);

            session.setAttribute("deleteProducts", deleteProducts);
            out.print("<h3> Product Successfully Marked as Deleted. </h3>");
            out.println("<h2><a href=\"listprod.jsp\"> View All Products</a></h2>");

        }
    } catch (Exception e) {
        out.print("Error Deleting Product: " + e.getMessage());
    }

%>
</body>
</html>