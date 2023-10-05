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
        else if (!usertype_Session.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%return;
        }

        String _film_Title = request.getParameter("field_film");
        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("DELETE " +
                                        "FROM films " +
                                        "WHERE title=?");
            pst.setString(1, _film_Title);
            int i = pst.executeUpdate();
            if (i > 0) {
                %>
                <br><br><br>
                <div style="color: #32f024" class="form form-submit-details-wrong">
                    <i class="fas fa-check-circle"></i> Film <%=_film_Title%> has been deleted.
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
            <i class="fas fa-times-circle"></i> Film <%=_film_Title%> couldn't be deleted! You need to remove all other film data before deleting it!
        </div>
    </body>
</html>