<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | User Promoted!</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        String _usernameSession = (String) session.getAttribute("username");
        String _usertypeSession = (String) session.getAttribute("user_type");
        if (_usernameSession == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
            </div>
            <%
            return;
        }
        else if (!_usertypeSession.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%return;
        }

        String _username = request.getParameter("field_user");
        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("UPDATE users " +
                                        "SET usertype=? " +
                                        "WHERE username=?");
            pst.setString(1, "Content Administrator");
            pst.setString(2, _username);
            int i = pst.executeUpdate();
            if (i > 0) {
                %>
                <br><br><br>
                <div style="color: #32f024" class="form form-submit-details-wrong">
                    <i class="fas fa-check-circle"></i> <%=_username%> has been promoted to Content Admin.
                </div>
                <%
                return;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        %>
        <br><br><br>
        <div style="color: red" class="form form-submit-details-wrong">
            <i class="fas fa-times-circle"></i> <%=_username%> couldn't be promoted to Content Admin.
        </div>
    </body>
</html>