<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<LINK REL=STYLESHEET
      HREF="CSS/Forms.css"
      TYPE="text/css">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <title>Movie Theaters | Promote a User</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var user = document.form_PromoteUser.field_user.value;
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
        String _username = (String) session.getAttribute("username");
        String _usertype = (String) session.getAttribute("user_type");
        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
            </div>
            <%
            return;
        }
        else if (!_usertype.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <div class="form">
            <div class="form-heading"><i class="fas fa-arrow-alt-circle-up"></i> Promote a User to Content Admin</div>
            <form action="Panel_User_Promote_Request.jsp" name="form_PromoteUser" method="POST" onsubmit="return formCheck();">
            <label>
                <span>User <span class="required">*</span></span>
                <select name="field_user" class="select-field" required>
                    <option selected hidden disabled>-</option>
                    <%
                        try {
                            Connection conn = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;

                            conn = Connect_Database.getConnection();
                            pst = conn.prepareStatement("SELECT username " +
                                                        "FROM users " +
                                                        "WHERE usertype=?");
                            pst.setString(1, "User");
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                String username = rs.getString("username");
                                %>
                                <option value="<%=username%>"><%=username%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>
            <button style="margin-left: 119px">Promote <i class="fas fa-arrow-alt-circle-up"></i></button>
            <br><br>
        </form>
    </div>
</body>
</html>
