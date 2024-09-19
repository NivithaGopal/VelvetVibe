<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    // Invalidate the current session
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // Invalidate the session
    }

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Logging Out</title>
</head>
<body>
    <p>Logging out...</p>
</body>
</html>
