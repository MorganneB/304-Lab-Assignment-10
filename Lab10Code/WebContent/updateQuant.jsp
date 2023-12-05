<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

String newQuantityParam = request.getParameter("newQuantity");
String id = request.getParameter("id");

ArrayList<Object> product = new ArrayList<Object>();


	int newQuant = Integer.parseInt(newQuantityParam);
    if (productList.containsKey(id)) {
		out.print("UPDATED");
		product = (ArrayList<Object>) productList.get(id);
		product.set(3, newQuant);
}


session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />