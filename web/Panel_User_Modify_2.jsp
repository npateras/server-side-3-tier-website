<%@ page import="mainpackage.Members.Users" %>
<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>Movie Theaters | Create a User</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var username = document.form_ModifyUser2.field_username.value;
            var firstname = document.form_ModifyUser2.field_first_name.value;
            var lastname = document.form_ModifyUser2.field_last_name.value;
            var email = document.form_ModifyUser2.field_email.value;
            var telephone = document.form_ModifyUser2.field_telephone.value;
            var password = document.form_ModifyUser2.field_password.value;

            var errors = [];

            var reName = /^[A-Za-z]+$/;
            var reUsername = /^[A-Za-z0-9]+$/;
            var reOnlyDigits = /^\d+$/;
            var rePassword = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{8,}$/;

            if (username == "" || username == null) {
                errors.push(" Username can't be empty!");
            }
            else {
                if (!reUsername.test(username)) {
                    errors.push(" Username must not contain special characters!");
                }
                for (var i = 0; i < username.length; i++) {
                    var j = username[i];
                    if (j == " "){
                        errors.push(" Username must not contain spaces!");
                    }
                }
            }
            /*Elexoi gia ean einai kena ta pedia firstname kai lastname
            kai ser periptosi pou den einai, to periexomeno tous na min periexei xaraktires i arithmous*/
            if (firstname == "" || firstname == null) {
                errors.push(" First Name can't be empty!");
            }
            else if (!reName.test(firstname)) {
                errors.push(" First Name can't have special characters or any digits!");
            }
            if (lastname == "" || lastname == null) {
                errors.push(" Last Name can't be empty!");
            }
            else if (!reName.test(lastname)) {
                errors.push(" Last Name can't have special characters or any digits!");
            }

            if (email == null || email === "") {
                errors.push(" Email can't be empty!");
            }
            else {
                if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)))
                {
                    errors.push(" Invalid Email address!");
                }
            }
            if (telephone != "") {
                if (telephone.length !== 10) {
                    errors.push(" Telephone must contain 10 digits!");
                }
                if (!reOnlyDigits.test(telephone)) {
                    errors.push(" Telephone must be of only digits!");
                }
            }
            if (password != "") {
                if (!(rePassword.test(password))) {
                    errors.push(" Your new password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters");
                }
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
    <%
    String username_Session = (String) session.getAttribute("username");
    String usertype_Session = (String) session.getAttribute("user_type");
    if (username_Session == null) {
        %>
        <div style="color: red" class="form content-container">
            <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
        </div>
        <%
        return;
    }
    else if (!usertype_Session.equalsIgnoreCase("Administrator")) {
        %>
        <div style="color: red" class="form content-container">
            <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
        </div>
        <%
        return;
    }
    Users users = new Users();
    String username_Form = request.getParameter("field_user");
    String[] full_name_db = users.getFullName(username_Form).split(" ");
    String email_db = users.getEmail(username_Form);
    String telephone_db = users.getTelephone(username_Form);
    String usertype_db = users.getUsertype(username_Form);
    %>

    <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

    <%--Forma gia dimiourgia xristi--%>
    <div class="form">
        <div class="form-heading"><i class="fas fa-user-edit"></i> Modify User</div>
        <form action="Panel_User_Modify_Request.jsp" name="form_ModifyUser2" method="POST" onsubmit="return formCheck()">
            <label>
                <span style="width: 150px"><i class="fas fa-user-circle"></i> Username <span class="required">*</span></span>
                <input type="text" class="input-field" name="field_username" placeholder="Enter User's username" value="<%=username_Form%>">
            </label>

            <label>
                <span style="width: 150px"><i class="fas fa-key"></i> Password <span class="required">*</span></span>
                <input type="password" class="input-field" name="field_password" placeholder="Modify User's password" autocomplete="off" title="Adding a new password will override the new one!"/>
            </label>

            <br>
            <label>
                <span style="width: 150px"><i class="fas fa-id-card"></i> First Name <span class="required">*</span></span>
                <input type="text" class="input-field" name="field_first_name" placeholder="Enter User's first name" value="<%=full_name_db[0]%>"/>
            </label>

            <label>
                <span style="width: 150px"><i class="fas fa-id-card"></i> Last Name <span class="required">*</span></span>
                <input type="text" class="input-field" name="field_last_name" placeholder="Enter User's last name" value="<%=full_name_db[1]%>"/>
            </label>

            <label>
                <span style="width: 150px"><i class="fas fa-at"></i> Email <span class="required">*</span></span>
                <input type="text" class="input-field" name="field_email" placeholder="Enter User's email address" value="<%=email_db%>"/>
            </label>

            <label>
                <span style="width: 150px"><i class="fas fa-phone"></i> Telephone </span>
                <input type="text" class="input-field" name="field_telephone" placeholder="Enter User's phone number" value="<%=telephone_db%>"/>
            </label>
            <br>
            <label>
                <span style="width: 150px"><i class="fas fa-medal"></i> User Type <span class="required">*</span></span>
                <select name="field_usertype" class="select-field" value="<%=usertype_db%>">
                    <%
                    if (usertype_db.equalsIgnoreCase("User")) {
                        %>
                        <option selected>User</option>
                    <%} else %> <option>User</option>
                    <%
                    if (usertype_db.equalsIgnoreCase("Content Administrator")) {
                        %>
                        <option selected>Content Administrator</option>
                    <%} else %> <option>Content Administrator</option>
                    <%
                    if (usertype_db.equalsIgnoreCase("Administrator")) {
                        %>
                        <option selected>Administrator</option>
                    <%} else %> <option>Administrator</option>
                </select>
            </label>
            <button style="margin-left: 170px">Modify <i class="fas fa-pencil-alt"></i></button>
            <input type="hidden" value="<%=username_Form%>" name="input_hidden_username" id="input_hidden_username"/>
            <br><br>
        </form>
    </div>
</body>
</html>
