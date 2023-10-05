<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <title>Movie Theaters | Modify a User</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var user = document.form_ModifyUser1.field_user.value;
            var errors = [];

            if (user == null || user === "" || user === "-") {
                errors.push(" You must select a User before processing!");
            }
            if (errors.length !== 0) {
                document.getElementById("div_Errors").style.display = "block";
                document.getElementById("div_Errors").style.color = "Red";
                for (var i = 0; i < errors.length; i++) {
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
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <div class="form">
            <div class="form-heading"><i class="fas fa-user-edit"></i> Modify a User</div>
            <form action="Panel_User_Modify_2.jsp" name="form_ModifyUser1" method="POST" onsubmit="return formCheck();">
            <label>
                <span>User </span>
                <select name="field_user" class="select-field" required>
                    <option selected hidden disabled>-</option>
                    <%
                        Connection conn = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        conn = Connect_Database.getConnection();
                        try {
                            pst = conn.prepareStatement("SELECT username, usertype " +
                                                        "FROM users " +
                                                        "WHERE username!=? " +
                                                        "ORDER BY usertype DESC");
                            pst.setString(1, username_Session);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                String username_db = rs.getString("username");
                                String usertype_db = rs.getString("usertype");
                                %>
                                <option value="<%=username_db%>">[<%=usertype_db%>] <%=username_db%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>
            <button style="margin-left: 119px">Next <i class="fas fa-arrow-circle-right"></i></button>
            <br><br>
        </form>
    </div>
</body>
</html>
