<%-- 
    Document   : login
    Created on : May 3, 2025, 7:39:35 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    
    <title>Login Admin</title>
</head>
<body>
<h2>Login</h2>
<form action="login" method="post">
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <input type="submit" value="Login">
</form>
<a href="register.jsp">Belum punya akun? Daftar di sini</a>
<c:if test="${not empty error}">
    <div style="color:red">${error}</div>
</c:if>

</body>
</html>
