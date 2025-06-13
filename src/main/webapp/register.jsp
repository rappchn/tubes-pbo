<%-- 
    Document   : register
    Created on : May 3, 2025, 7:38:57 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">

    <!-- Lottie Player -->
    <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
</head>
<body class="bg-light">

<section class="vh-100">
    <div class="container h-100">
        <div class="row d-flex align-items-center justify-content-center h-100">
            
            <!-- Animation -->
            <div class="col-md-6 d-none d-md-block">
                <dotlottie-player
                    src="https://lottie.host/6aaf3cfd-2a67-4523-8f8d-15074cda6428/1U859I6i7r.lottie"
                    background="transparent"
                    speed="1"
                    style="width: 100%; height: auto;"
                    loop autoplay>
                </dotlottie-player>
            </div>

            <!-- Register Form -->
            <div class="col-md-6 col-lg-5">
                <div class="p-4">
                    <h2 class="text-center mb-3">Register Here!</h2>
                    <p class="text-center text-muted mb-4">Create your new account below 😁</p>
                    
                    <form action="register" method="post">
                        <!-- Username -->
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="username" id="floatingName" placeholder="Username" required>
                            <label for="floatingName">Username</label>
                        </div>
                        
                        <!-- Password -->
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="password" id="floatingPass" placeholder="Password" required>
                            <label for="floatingPass">Password</label>
                        </div>

                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <!-- Submit Button -->
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">Register</button>
                        </div>

                        <!-- Link to login -->
                        <p class="small text-center mb-0">
                            Already have an account?
                            <a href="login.jsp" class="link-primary">Login here</a>
                        </p>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>

</body>
</html>