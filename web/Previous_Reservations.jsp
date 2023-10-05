<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="mainpackage.Members.Users" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:include page="default.jsp"/>

<LINK REL=STYLESHEET
      HREF="CSS/Table.css"
      TYPE="text/css">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Reservations</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        String _username = (String) session.getAttribute("username");
        if (_username == null) {
            %>
            <div class="div-container-black">
                <p>You must be logged-in to view this page!</p>
            </div>
            <%
            return;
        }
        Users users = new Users();
        int _user_id = users.getUserId(_username);
        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT transaction_id, title, PR.start_date, PR.end_date, SC.screen_number, SC.is_3d, reserved_seats, transaction, is_available " +
                                        "FROM transactions TR, films F, provoles PR, screens SC " +
                                        "WHERE TR.user_id=? " +
                                        "AND TR.provoli_id = PR.provoli_id " +
                                        "AND PR.film_id = F.film_id " +
                                        "AND PR.screen_id = SC.screen_number " +
                                        "ORDER BY is_available");
            pst.setInt(1, _user_id);
            rs = pst.executeQuery();
            if (!rs.next()) {
                %>
                <div style="color: white" class="form content-container">
                    <i class="fas fa-clipboard-list"></i> There are no reservations!
                </div>
                <%
                return;
            }
            rs = pst.executeQuery();
            %>
            <table style="width: 75%; margin:1em auto;">
                <tr class="table-header" >
                    <th style="text-align: center;" colspan="9">
                        <i class="fas fa-history"></i> Reservations
                    </th>
                </tr>
                <tr style="color: black; font-size: 22px;">
                    <th><p><i class="fas fa-file-video"></i> Order ID:</p></th>
                    <th><p><i class="fas fa-film"></i> Film:</p></th>
                    <th><p><i class="fas fa-desktop"></i> Screen Number:</p></th>
                    <th><p><i class="fas fa-calendar-alt"></i> Date:</p></th>
                    <th><p><i class="fas fa-clock"></i> Hours:</p></th>
                    <th><p><i class="fas fa-chair"></i> Reserved Seats:</p></th>
                    <th><p><i class="fas fa-vr-cardboard"></i> 3D:</p></th>
                    <th><p><i class="fas fa-money-bill-wave"></i> Price:</p></th>
                    <th><p>Completed:</p></th>
                </tr>
                <%
                DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMMMMMMM-YY");
                DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");
                while (rs.next()) {
                    int transaction_id = rs.getInt("transaction_id");
                    String title = rs.getString("title");
                    int seats = rs.getInt("reserved_seats");
                    double transaction = rs.getDouble("transaction");
                    String provoli_date = dateFormat.format(rs.getDate("start_date")).replace("-", " ");
                    String provoli_start_hour = timeFormat.format(rs.getTime("start_date"));
                    String provoli_end_hour = timeFormat.format(rs.getTime("end_date"));
                    int screen_number = rs.getInt("screen_number");
                    String is3d;
                    if (rs.getBoolean("is_3d")) is3d = "Yes"; else is3d = "No";
                    %>
                    <tr style="color: black; font-size: 20px;">
                        <td><p><%= transaction_id %></p></td>
                        <td><p><%= title %></p></td>
                        <td><p><%= screen_number %></p></td>
                        <td><p><%= provoli_date %></p></td>
                        <td><p><%= provoli_start_hour %> - <%= provoli_end_hour %></p></td>
                        <td><p><%= seats %></p></td>
                        <td><p><%= is3d %></p></td>
                        <td><p>€<%= transaction%></p></td>
                        <%
                        if (rs.getBoolean("is_available")) {
                            %>
                            <td><i class="fas fa-times"></i></td>
                            <%
                        }
                        else {
                            %>
                            <td><i class="fas fa-check"></i></td>
                            <%
                        }
                        %>
                    </tr>
                    <%
                }
                %>
            </table>
            <%
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</html>
