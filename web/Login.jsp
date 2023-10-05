<jsp:include page="default.jsp"/>

<LINK REL=STYLESHEET
      HREF="CSS/Forms.css"
      TYPE="text/css">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%
    //Elexos ean to session einai null gia na doume ean o xristis einai idi sindedemenos alla einai stin login.jsp gia kapio logo, tote ton stelnoume pisw stin arxiki
    String _username = (String) session.getAttribute("username");
    if (_username != null) {
        response.sendRedirect("index.jsp");
        return;
    }
    %>
    <title>Movie Theaters | Login</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var username = document.formLogin.fieldUsername.value;
            var password = document.formLogin.fieldPassword.value;

            var errors = [];

            if (username == null || username == "") {
                errors.push(" You must enter your username!");
            }
            if (password == null || password == "") {
                errors.push(" You must enter your password!");
            }
            if (errors.length !== 0) {
                document.getElementById("div_Errors").style.display = "block";
                document.getElementById("div_Errors").style.color = "Red";
                for (i = 0; i < errors.length; i++) {
                    document.getElementById("div_Errors").innerHTML += '<i class="fas fa-times-circle"></i>' + errors[i] + '<br />';
                }
                return false;
            }
        }
    </script>
</head>
<body>
<br><br><br><br>

<div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

<div class="form"> <%-- Forma gia sindesi --%>
    <div class="form-heading">Login <i class="fas fa-user-lock"></i></div>
    <form action="Login_Request.jsp" name="formLogin" method="POST" onsubmit="return formCheck()">
        <label>
            <span>Username </span>
            <input type="text" class="input-field" name="fieldUsername" placeholder="Enter your Username"/>
        </label>
        <label>
            <span>Password </span>
            <input type="password" class="input-field" name="fieldPassword" placeholder="Enter your Password"/>
        </label>

        <br>
        <label>
            <span>Login As </span>
            <select name="fieldLoginAs" class="select-field" required>
                <option selected id="fieldLoginAsUser">User</option>
                <option id="fieldLoginAsCoAdmin">Content Administrator</option>
                <option id="fieldLoginAsAdmin">Administrator</option>
            </select>
        </label>
        <input type="submit" value="Login"/>
        <br><br>
    </form>
</div>
</body>
</html>
