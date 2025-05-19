<%-- 
    Document   : register
    Created on : May 3, 2025, 7:38:57 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register Admin</title>
</head>
<body>
<h2>Register</h2>

<!-- Tampilkan pesan error jika ada -->
<c:if test="${not empty error}">
    <div style="color:red">${error}</div>
</c:if>

<form action="register" method="post">
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <input type="submit" value="Register">
</form>

<a href="login.jsp">Sudah punya akun? Login di sini</a>
</body>
</html>

