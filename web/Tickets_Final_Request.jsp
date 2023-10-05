<%@ page import ="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Order Completed</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        String _username = (String) session.getAttribute("username");
        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to buy a ticket!
            </div>
            <%
            return;
        }

        String film_Title = request.getParameter("field_hidden_film_title");
        String showtime = request.getParameter("field_showtime");
        int reserved_seats = Integer.parseInt(request.getParameter("field_seats"));
        double transaction = reserved_seats * 08.00;
        int _user_id = 0;
        int _provoli_id = Integer.parseInt(request.getParameter("field_hidden_ids"));

        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst= conn.prepareStatement("SELECT user_id " +
                                       "FROM users " +
                                       "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                _user_id = rs.getInt("user_id");
            }

            pst = conn.prepareStatement("INSERT INTO transactions(user_id, provoli_id, reserved_seats, transaction) " +
                    "VALUES ('"+_user_id+"', '"+_provoli_id+"', '"+reserved_seats+"', '"+transaction+"')");
            int i = pst.executeUpdate();
            if (i > 0) {
                %>
                <div style="color: #32f024" class="form form-submit-details-wrong">
                    <i class="fas fa-check-circle"></i> You have successfully completed your order!
                </div>
                <%
            }
            else {
                %>
                <div style="color: red;" class="form form-submit-details-wrong">ul>
                    <i class="fas fa-times-circle"></i> An error has occurred while completing your order! Please contact an Administrator.
                </div>
                <%
                pst.close();
                }
            }
            catch (Exception e) {
                System.out.println("Something went wrong! (Tickets_Final_Request.jsp)");
                e.printStackTrace();
            }
        %>

    </body>
</html>
