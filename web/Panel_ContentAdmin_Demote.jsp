<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <title>Movie Theaters | Promote a User</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var user = document.form_DemoteUser.field_content_admin.value;
            var errors = [];

            if (user == null || user === "" || user === "-") {
                errors.push(" You must select a Content Admin before processing!");
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
            <div class="form-heading"><i class="fas fa-times"></i> Remove a Content Admin</div>
            <form action="Panel_ContentAdmin_Demote_Request.jsp" name="form_DemoteUser" method="POST" onsubmit="return formCheck();">
            <label>
                <span>Content Admin <span class="required">*</span></span>
                <select name="field_content_admin" class="select-field" required>
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
                            pst.setString(1, "Content Administrator");
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
            <button style="margin-left: 119px">Remove <i class="fas fa-arrow-alt-circle-down"></i></button>
            <br><br>
            Note: Content Admin will be demoted to User.
        </form>
    </div>
</body>
</html>
