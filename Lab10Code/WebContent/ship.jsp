<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String oid = session.getAttribute("orderId").toString();

	//make connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	Connection con = null;													
	PreparedStatement pstmt = null;
	ResultSet rst = null;

	try {
		con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();
		
		//turn off auto commit 
		con.setAutoCommit(false);								

		//Check if valid order id in database
		String findOID = "SELECT * FROM ordersummary WHERE orderId = ?";
		pstmt = con.prepareStatement(findOID);
		pstmt.setString(1, oid);
		rst = pstmt.executeQuery();
		
		if(!rst.next()) {
			throw new NullPointerException();
		} 

		// TODO: Retrieve all items in order with given id
		String retrieveItems = "SELECT item FROM ordersummary WHERE orderId = ?";
		pstmt = con.prepareStatement(retrieveItems);
		pstmt.setString(1, oid);
		rst = pstmt.executeQuery();
		
		// TODO: Create a new shipment record.
		String newShipment = "INSERT INTO shipment (orderId, shipmentDate) VALUEs (?, ?)";
		pstmt = con.prepareStatement(newShipment, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, oid);
		pstmt.setDate(2, new java.sql.Date(new java.util.Date().getTime()));

		// TODO: For each item verify sufficient quantity available in warehouse 1.
		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		


	} catch (NullPointerException ex) {
		out.println("Order does not exist");
	} finally {
		if(con != null) {
			//Auto-commit should be turned back on
			con.setAutoCommit(true);
			closeConnection();

		}
	}
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
