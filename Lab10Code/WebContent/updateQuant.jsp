<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

String newQuantityParam = request.getParameter("newQuantity");
String id = request.getParameter("id");

int newQuant = 0;

try {
	newQuant = Integer.parseInt(newQuantityParam);
} catch (NumberFormatException e) {
	out.print("Error parsing quantity. Please enter a valid number.");
}

if (productList.containsKey(id)) {
		ArrayList<Object> product = productList.get(id);
		product.set(3, newQuant);
} else {
	out.print("Product not found in shopping cart: ");
}

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />

</body>
</html>
