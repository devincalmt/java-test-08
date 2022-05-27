<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("authenticated")!=null && session.getAttribute("authenticated").equals(true))
    {
        response.sendRedirect("home");
    }
%>
<%!
    String getOrDefault(String text, String defaultStr){
        return text == null ? defaultStr : text;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Login Page</title>
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/util.css">
    <script src="asset/data/users.json"></script>
</head>
<body>
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <div class="login100-pic js-tilt" data-tilt>
                    <img src="images/img-01.png" alt="IMG">
                </div>

                <form class="login100-form validate-form" method="post" id="loginForm" action="login-validation">
                        <span class="login100-form-title">
                            User Login
                        </span>

                    <div class="wrap-input100 validate-input">
                        <input class="input100" type="text" name="userId" id="userId" placeholder="User ID">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span>
                    </div>

                    <div class="wrap-input100 validate-input">
                        <input class="input100" type="password" name="password" id="password" placeholder="Password">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="text-center p-t-12">
                        <span class="txt1 text-danger" id="errorLabel">
                            <%
                                String invalid = request.getParameter("invalid");
                            %>
                            <%= getOrDefault(invalid, "").equals("true") ? "User ID or Password is incorrect" : "" %>
                        </span>
                    </div>

                    <div class="container-login100-form-btn">
                        <button class="login100-form-btn" id="loginBtn">
                            Login
                        </button>
                    </div>

                    <div class="p-t-12"></div>
                    <div class="p-t-136"></div>
                </form>
            </div>
        </div>
    </div>

    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/select2/select2.min.js"></script>
    <script src="vendor/tilt/tilt.jquery.min.js"></script>
    <script src="js/login.js"></script>
</body>
</html>