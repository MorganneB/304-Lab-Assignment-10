<!DOCTYPE html>
<html>
<head>
<title>Check out</title>
<style> 
	body {
		background-color: #faf5f0; 
		color: #5D5348; 
		font-family: Arial, sans-serif;
	}

    table {
		border: 1px solid #7ca0fc; 
		border-collapse: collapse;
		width: 75%;
		margin-top: 20px;
        margin-left: auto;
        margin-right: auto;
	}

     td {
		border: 1px solid #7ca0fc; 
		padding: 10px;
		text-align: left;
	}

	th {
		background-color: #a2bbfc;
		color: white;
        text-align:center;
        padding: 10px;
    }

	h3 {
		color: #7ca0fc; 
		font-size: 1.3em; 
		text-align: center; 
	}

    input[type=text] {
        width: 50%;
        padding: 10px 17px;
        margin: 8px;
        box-sizing: border-box;
    }

    input[type=text2] {
        width: 25%;
        padding: 10px 17px;
        margin: 8px;
        box-sizing: border-box;
    }

    input[type=text3] {
        width: 40%;
        padding: 10px 17px;
        margin: 8px;
        box-sizing: border-box;
    }

	input[type=submit] {
        background-color: #7ca0fc;
  		border: none;
		color: white;
		padding: 10px 25px;
		border-radius: 8px;
		margin: 20px 20px;
    }


	</style>
</head>
<body>

	<%@ include file="auth.jsp" %>
    <%@ include file="header.jsp" %>
	<%@ include file="jdbc.jsp" %>

<h3>Please review your shipping and payment information below: </h3>


<form method="get" action="checkout.jsp">

<table>
    <tr>
        <th>Shipping Information: </th>
        <th>Payment Information: </th>
    </tr>
    <tr>
        <td><label for="fname">Street Address:</label><input type="text" name="address" size="50"> </td>
        <td><label for="fname">Payment Type:</label>

                <select name="paymentOption">
                    <option value="0">Select..</option>
                    <option value="1">Visa</option>
                    <option value="2">Mastecard</option>
                    <option value="3">Interact</option>
                </select></td>
    </tr>
    <tr>
        <td><label for="fname">City:</label><input type="text3" name="city" size="50"><label for="fname">State:</label><input type="text2" name="state" size="50"> <required></required></td>
        <td><label for="fname">Card Number:</label><input type="text" name="cardNum" size="50"><required></required></td>
    </tr>
    <tr>
        <td><label for="fname">Country:</label><input type="text3" name="country" size="50"><label for="fname">Postal Code:</label><input type="text2" name="postalcode" size="50"><required></required> </td>
        <td><label for="fname">Card Expiry:</label><input type="text" name="cardExpiry" size="50"><required></td>
    </tr>
</table>

<input type="submit" value="Check out"> 	
</form>


<% 

//response.sendRedirect("CheckOut.jsp");

/*
String cardNum = request.getParameter("cardNum"); 
String cardExpiry = request.getParameter("cardExpiry"); 
String paymentOption = request.getParameter("paymentOption"); 
String address = request.getParameter("address"); 
String city = request.getParameter("city"); 
String state = request.getParameter("state"); 
String postalcode = request.getParameter("postalcode");
String country = request.getParameter("country"); 

try {
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw"; 

	Connection con = null;														
	PreparedStatement pstmt = null;
	ResultSet rst = null;
	String SQL = "UPDATE customer SET city = ?";
	int rowsAffected = 0; 

	try {
		con = DriverManager.getConnection(url, uid, pw);	

        if (paymentOption == 0){ 
            // THROW AN ERROR, METHOD NOT SELECTED 
        }
        if (!cardNum.length() == 16) {
            // THROW AN ERROR, INFORMATION NOT FILLED IN 
        }
        if (!cardExpiry.length() == 4) { 
              THROW ERROR, INVALID 
        }
    } else {
        out.print("<h3>Failed to process check out information. Please fill in all fields! </h3>");
        throw new NullPointerException("All fields required.");
        } 

    }

*/
%>


</body>
</html>

