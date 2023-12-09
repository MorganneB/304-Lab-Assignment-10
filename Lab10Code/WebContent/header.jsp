<style>
    body {
		background-color: #faf5f0; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}
    h1 {
		color: #7ca0fc; 
		font-size: 2.0em; 
        font-family: impact sans-serif;
	}
    h2 {
		color: #a2bbfc; 
		font-size: 1.6em; 
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
		background-color: #a2bbfc;
	}
</style>

<h1 align="center"><b>CLOUD k9</b></h1>

<%
    boolean isauthenticated = session.getAttribute("authenticatedUser") != null;

    if (isauthenticated) {
		String userName = (String) session.getAttribute("authenticatedUser");
%>
        <ul>
            <li><a href="index.jsp">Main Page</a></li>
            <li><a href="listprod.jsp">Shop Now</a></li>
            <li><a href="listorder.jsp">Orders</a></li>
            <li><a href="showcart.jsp">My Cart</a></li>
            <li><a href="admin.jsp">Administrators</a></li>
			<li><a href ="editProducts.jsp">Edit Products</a></li>
			 <li style="float:right"><a href="logout.jsp">Logout</a></li>
			<li style="float:right"><a href="customer.jsp">My Profile</a></li>
        </ul>
<%
    } else {
%>
        <ul>
            <li><a href="index.jsp">Main Page</a></li>
            <li><a href="listprod.jsp">Shop Now</a></li>
            <li><a href="listorder.jsp">Orders</a></li>
            <li><a href="showcart.jsp">My Cart</a></li>
            <li><a href="admin.jsp">Administrators</a></li>
			<li style="float:right"><a href="createUser.jsp">Sign Up</a></li>
            <li style="float:right"><a href="login.jsp">Login</a></li>
        </ul>
<%
    }
%>
