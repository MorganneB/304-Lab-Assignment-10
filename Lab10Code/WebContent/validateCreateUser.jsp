<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";	// Make connection	
	String uid = "sa";
	String pw = "304#sa#pw";

	try {
		authenticatedUser = validateCreation(out,request,session);         //Update method name to createUser (Done) 
	} catch(IOException e) {
		System.err.println(e);
	}

	if(authenticatedUser != null)
		response.sendRedirect("customer.jsp");		// Successful login
	else
		response.sendRedirect("createUser.jsp");		// Failed login - redirect back to login page with a message 

%>


<%!
	String validateCreation(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
        String firstName = request.getParameter("firstName"); 
        String lastName = request.getParameter("lastName"); 
        String email = request.getParameter("email"); 

		String retStr = null;

		if(username == null || password == null || firstName == null || lastName == null || email == null || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {              
			return null;
		}

		Connection con = null;														//Create variables for connection
		PreparedStatement pstmt = null;
		ResultSet rst = null;

		try {
			con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();
			
			// Check if userId and password match some customer account. If so, set retStr to be the username AND insert customer table 
			String SQL = "SELECT userId, customerId FROM customer WHERE userId = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, username);
			rst = pstmt.executeQuery();

			if(!rst.next()) {
				retStr = username;                                                      //Insert new customer into customer relation 
            	String SQL2 = "INSERT INTO customer (firstName, lastName, email, userid, password) VALUES (?, ?, ?, ?, ?)";
            	pstmt = con.prepareStatement(SQL2);
				pstmt.setString(1, firstName);
				pstmt.setString(2, lastName);
           		pstmt.setString(3, email);
				pstmt.setString(4, username);
           		pstmt.setString(5, password);

				int rowsAffected = pstmt.executeUpdate(); 

           		 if (rowsAffected > 0) {
				
               		//out.print("<h3>Profile successfully created!</h3>");
              		//out.println("<h2><a href=\"customer.jsp\">Go to Profile</a></h2>");
           		 } 
			}
				else {
					out.println("<h2>Incorrect username or password</h2>");
				}
		} 
		catch (SQLException ex) {
			out.println(ex);
		} catch (NullPointerException ex) {
			out.println("<h2>Incorrect username or password</h2>");
		} finally {
			closeConnection();
		}	
		
			if(retStr != null)
			{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", username);
			}
			else {
				session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
			}
		return retStr;
		}
%>
