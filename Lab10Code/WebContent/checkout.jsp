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

	h3 {
		color: #7ca0fc; 
		font-size: 1.3em; 
		text-align: left; 
	}

    input[type=text] {
        width: 25%;
        padding: 10px 17px;
        margin: 8px 0;
        box-sizing: border-box;
    }

	input[type=submit] {
        background-color: #7ca0fc;
  		border: none;
		color: white;
		padding: 10px 25px;
		border-radius: 8px;
		margin: 2px 2px;
    }

	input[type=reset] {
        background-color: #7ca0fc;
  		border: none;
		color: white;
		padding: 10px 25px;
		border-radius: 8px;
		margin: 2px 2px;
    }

	</style>
</head>
<body>

	<%@ include file="auth.jsp" %>

<h3>Please review your shipping and payment information below: </h3>


<form method="get" action="order.jsp">
<label for="fname">Customer Id:</label><input type="text" name="customerId" size="50"> 

<label for="fname">Password:</label>
<input type="text" name="customerPassword" size="50"> <br>
<input type="submit" value="Submit"> 	<input type="reset" value="Reset">
</form>


</body>
</html>

