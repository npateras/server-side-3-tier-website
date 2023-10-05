<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Deleting showtime...</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        String username_Session = (String) session.getAttribute("username");
        String usertype_Session = (String) session.getAttribute("user_type");
        if (username_Session == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
            </div>
            <%
            return;
        }
        else if (usertype_Session.equalsIgnoreCase("User")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%return;
        }
        String provoli_id = request.getParameter("field_showtimes");
        if (provoli_id == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("DELETE " +
                                        "FROM provoles " +
                                        "WHERE provoli_id=?");
            pst.setString(1, provoli_id);
            int i = pst.executeUpdate();
            if (i > 0) {
                %>
                <br><br><br>
                <div style="color: #32f024" class="form content-container">
                    <i class="fas fa-check-circle"></i> Showtime with id:(<%=provoli_id%>) has been deleted from database.
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
        <div style="color: red" class="form content-container">
            <i class="fas fa-times-circle"></i> Showtime with id:(<%=provoli_id%>) couldn't be deleted from database! You need to remove all other showtime data before deleting it!
        </div>
    </body>
</html>