<!DOCTYPE html>
<html>
<head>
	<title>CLOUD k9</title>
        
	<style> 
			body {
					background-color: #faf5f0; 
					color: #a2bbfc; 
					font-family: Arial, sans-serif;
			}
	
			h1 {
					color: #7ca0fc; 
					font-size: 1.8em; 
					text-align: center; 
			}

			h2 {
					color: #a2bbfc; 
					font-size: 1.5em; 
					text-align: center; 
			}

			ul {
					list-style-type: none;
					margin: 0;
					padding: 0;
					overflow: hidden;
					background-color: #7ca0fc;
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
			
			li a:hover {
					background-color: #7ca0fc;
			}

			</style>
</head>
<body>
<h1 align="center">CLOUD k9</h1>

<%
    boolean authenticated = session.getAttribute("authenticatedUser") != null;

    if (authenticated) {
		String userName = (String) session.getAttribute("authenticatedUser");
		out.println("<h2 align=\"center\"> Hi, "+userName+"</h2>");
%>
		<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>
		<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>
		<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>
		<h2 align="center"><a href="admin.jsp">Administrators</a></h2>
		<h2 align="center"><a href="showcart.jsp">My Cart</a></h2>
		<h2 align="center"><a href="editProducts.jsp">Edit Products</a></h2>
		<h2 align="center"><a href="logout.jsp">Log out</a></h2>
		<%
		if (userName != null)
			out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
		%>
<%
    } else {
%>
		<h2 align="center"><a href="login.jsp">Login</a></h2>
		<h2 align="center"><a href="createUser.jsp">Sign Up</a></h2>
		<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>
		<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>
		<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>
		<h2 align="center"><a href="admin.jsp">Administrators</a></h2>
<%
    }
%>



<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>
<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>
</head>


