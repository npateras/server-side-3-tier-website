<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Profile</title>
        <script type="text/javascript">
            function formCheck() {
                document.getElementById("div_Errors").innerHTML = "";
                document.getElementById("div_Errors").style.display = "none";

                var firstname = document.forms["form_Profile"].field_first_name.value;
                var lastname = document.forms["form_Profile"].field_last_name.value;
                var email = document.forms["form_Profile"].field_email.value;
                var telephone = document.forms["form_Profile"].field_telephone.value;
                var currentPassword = document.forms["form_Profile"].field_current_password.value;
                var newPassword = document.forms["form_Profile"].field_new_password.value;
                var passChanged = false;

                var errors = [];

                var reName = /^[A-Za-z]+$/;
                var reOnlyDigits = /^\d+$/;
                var reNewPassword = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{8,}$/;
                if (firstname == "") {
                    errors.push(" Your First Name can't be empty!");
                }
                else if (!(reName.test(firstname))) {
                    errors.push(" First Name can't have special characters or any digits!");
                }

                if (lastname == "") {
                    errors.push(" Your Last Name can't be empty!");
                }
                else if (!(reName.test(lastname))) {
                    errors.push(" Last Name can't have special characters or any digits!");
                }

                if (email == null || email == "") {
                    errors.push(" Your Email can't be empty!");
                }
                else {
                    if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)))
                    {
                        errors.push(" Invalid Email address!");
                    }
                }
                if (telephone != null || telephone != "") {
                    if (telephone.length != 10) {
                        errors.push(" Telephone must be of 10 digits!");
                    }
                    if (!(reOnlyDigits.test(telephone))) {
                        errors.push(" Telephone must be of only digits!");
                    }
                }
                if (newPassword != "") {
                    if (!(reNewPassword.test(newPassword))) {
                        errors.push(" Your new password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters");
                    }
                    else {
                        passChanged = true;
                    }
                }
                if (currentPassword == null || currentPassword == "") {
                    errors.push(" You need to enter your current password!");
                }
                if (errors.length !== 0) {
                    document.getElementById("div_Errors").style.display = "block";
                    document.getElementById("div_Errors").style.color = "Red";
                    for (var i = 0; i < errors.length; i++) {
                        document.getElementById("div_Errors").innerHTML += '<i class="fas fa-times-circle"></i>' + errors[i] + '<br />';
                    }
                    return false;
                }
                if (passChanged) {
                    var r = confirm("• You have entered a new password!\n• Are you sure you want to proceed? Your password will be updated.");
                    if (!r) {
                        return false;
                    }
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
            <div class="div-container-black">
                <p>You must be logged-in to view this page!</p>
            </div>
            <%
            return;
        }
        try {
            String full_name_db[], email_db, telephone_db;

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT * " +
                                        "FROM users " +
                                        "WHERE username=?");
            pst.setString(1, username_Session);
            rs = pst.executeQuery();
            //Ean den yparxei o xristis stin vasi gia opiodipote logo
            if (!rs.next()) {
                %>
                <div style="color: red;" class="form form-submit-details-wrong">
                    <i class='fas fa-times-circle'></i> An error has occured while loading your profile! Please try again later or contact a staff member.
                </div>
                <%
                return;
            }
            //Tote sinexizoume
            full_name_db = rs.getString("full_name").split(" ");
            email_db = rs.getString("email");
            telephone_db = rs.getString("telephone");
            %>
            <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>
            <div style="max-width: 700px; width: 600px" class="form">
                <div class="form-heading"><i class="fas fa-user-circle"></i> <%= username_Session %></div>
                    <form action="Profile_Request.jsp" name="form_Profile" method="POST" onsubmit="return formCheck();">
                        <br>
                        <label>
                            <span style="width: 150px"><i class="fas fa-medal"></i> Rank </span>
                            <input type="text" class="not-allowed-input-field" name="field_usertype" readonly value="<%=usertype_Session%>"/>
                        </label>
                        <br><br>

                        <label>
                            <span style="width: 150px"><i class="fas fa-id-card"></i> First Name </span>
                            <input type="text" class="input-field" name="field_first_name" placeholder="Enter your first name" value="<%=full_name_db[0]%>" title="Enter your first name"/>
                        </label>

                        <label>
                            <span style="width: 150px"><i class="fas fa-id-card"></i> Last Name </span>
                            <input type="text" class="input-field" name="field_last_name" placeholder="Enter your last name" value="<%=full_name_db[1]%>" title="Enter your last name"/>
                        </label>

                        <label>
                            <span style="width: 150px"><i class="fas fa-at"></i> Email </span>
                            <input type="text" class="input-field" name="field_email" placeholder="Enter a valid email address" value="<%=email_db%>" title="Enter your email address"/>
                        </label>

                        <%
                        if (telephone_db == null) {
                            telephone_db = "";
                        }
                        %>
                        <label>
                            <span style="width: 150px"><i class="fas fa-phone"></i> Telephone </span>
                            <input type="text" class="input-field" name="field_telephone" placeholder="Enter a your phone number" value="<%=telephone_db%>" maxlength="10" title="Enter a your phone number"/>
                        </label>

                        <br>
                        <label>
                            <span style="width: 150px"><i class="fas fa-key"></i> New Password </span>
                            <input type="password" class="input-field" name="field_new_password" placeholder="Leave empty if you don't wish to change current password" title="Leave empty if you don't wish to change current password"/>
                        </label>
                        <label>
                            <span style="width: 150px"><i class="fas fa-key"></i> Current Password </span>
                            <input type="password" class="input-field" name="field_current_password" placeholder="Enter your current password"/>
                        </label>

                        <input type="hidden" name="field_hidden_username" id="field_hidden_username" value="<%=username_Session%>"/>
                        <button style="margin-left: 170px">Save <i class="fas fa-save"></i></button>
                        <br><br>
                    </form>
            </div>
        <%
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </body>
</html>
