<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.sql.*,java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<style> 
	body {
		background-color: #ffe6f3; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

	table {
		border: 1px solid #7ca0fc; 
		border-collapse: collapse;
		width: 100%;
		margin-top: 20px;
	}

	th, td, title {
		border: 1px solid #7ca0fc; 
		padding: 10px;
		text-align: left;
	}

	th {
		background-color: #a2bbfc;
		color: white;
	}

	h1 {
		color: #7ca0fc; 
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

	li a:hover {
		background-color: #7ca0fc;
	}


	</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
} else {
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Update</th><th>Remove</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.print("<td align=\"center\">"+product.get(3)+"</td>");

		//update quantity start
		out.print("<td>");
		out.print("<form method=\"post\" action=\"updateQuant.jsp\">");
		out.print("<input type=\"hidden\" name=\"id\" value=\"" + product.get(0) + "\" />");
		out.print("<input type=\"text\" name=\"newQuantity\" size=\"1\">");
		out.print("   <input type=\"submit\" value=\"Submit\">"); 
		out.print("</form></td>");
		//update quantity end
		
		out.println("<td><a href='delCart.jsp?id=" + product.get(0) + "&name=" + product.get(1) + "'>Remove From Cart</a></td>");

		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"6\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"secureCheckout.jsp\">Confirm payment and shipping information</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

