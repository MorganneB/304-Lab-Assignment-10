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
    
        h1 {
            color: #7ca0fc; 
            font-size: 1.6em; 
        }
    
        h2 {
            color: #a2bbfc; 
            font-size: 1.8em; 
            text-align: center; 
        }

        .options {
            background-color: #a2bbfc;
            border: none;
            color: white;
            padding: 12px 19px;
            border-radius: 6px;
            margin-top: 50px;
            margin-bottom: 50px;
            font-size: 16px;
            text-decoration: none;
        }
    </style>
</head>

<body>

    <%@ include file="header.jsp" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="auth.jsp" %>

    <%
    out.print("<h2><a class=\"options\" href='addProduct.jsp'> Add A Product </a></h2><br>");
    out.print("<h2><a class=\"options\" href='updateProduct.jsp'> Update A Product </a></h2><br>");
    out.print("<h2><a class=\"options\" href='deleteProduct.jsp'> Delete A Product </a></h2>");

    %>
</body>
</html>