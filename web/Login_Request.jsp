<%@ page import = "mainpackage.Utils.Connect_Database,mainpackage.Members.Users,java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="mainpackage.Utils.Encryption" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Movie Theaters</title>
    </head>
    <body>
        <br><br><br><br>

        <%
        try {
            String username_Form = request.getParameter("fieldUsername");
            String password_Form = request.getParameter("fieldPassword");
            String usertype_Form = request.getParameter("fieldLoginAs");
            if (username_Form == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            String username_db, password_db, usertype_db;
            String hashed_password_Form = Encryption.hashPassword(password_Form);

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT username, password, usertype " +
                                        "FROM users " +
                                        "WHERE username=? AND password=? AND usertype=?");
            pst.setString(1, username_Form);
            pst.setString(2, hashed_password_Form);
            pst.setString(3, usertype_Form);
            rs = pst.executeQuery();
            if (rs.next()) {
                username_db = rs.getString("username");
                password_db = rs.getString("password");
                usertype_db = rs.getString("usertype");
                if (username_Form.equalsIgnoreCase(username_db)
                        && hashed_password_Form.equals(password_db)
                        && usertype_Form.equalsIgnoreCase(usertype_db)) {
                    HttpSession sess = request.getSession(true);
                    sess.setAttribute("username", username_Form);
                    sess.setAttribute("user_type", usertype_db);
                    Users users = new Users();
                    users.setOnlineStatus(username_Form, true);
                    response.sendRedirect("index.jsp");
                }
            }
            else {
                %>
                <br><br><br>
                <div style="color: red" class="form content-container">
                    <i class="fas fa-times-circle"></i> Invalid login credentials!
                </div>
                <%
            }
        }
        catch (Exception e)
        {
            %>
            <br><br><br>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> Something went wrong. Please try again
            </div>
            <%
            e.printStackTrace();
            }
        %>
    </body>
</html>