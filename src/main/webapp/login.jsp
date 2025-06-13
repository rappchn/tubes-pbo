<%-- 
    Document   : login
    Created on : May 3, 2025, 7:39:35 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Admin</title>
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
                    src="https://lottie.host/fdc77d88-9c37-4e9e-abd5-9eed54ee7820/xmxcv9yE9q.lottie"
                    background="transparent"
                    speed="1"
                    style="width: 100%; height: auto;"
                    loop autoplay>
                </dotlottie-player>
            </div>
            

            <!-- Login Form -->
            <div class="col-md-6 col-lg-5">
                <div class="p-4">
                    <h2 class="text-center mb-3">Welcome!</h2>
                    <p class="text-center text-muted mb-4">Please fill the form below 😁</p>
                    
                    <form action="login" method="post">
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

                        <!-- Button -->
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">Login</button>
                        </div>
                        
                        <p class="small text-center mb-0">
                            Don't have an account?
                            <a href="register.jsp" class="link-primary">Register here</a>
                        </p>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>

</body>
</html>
