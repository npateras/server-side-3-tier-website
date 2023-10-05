<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:include page="default.jsp"/>

<LINK REL=STYLESHEET
      HREF="CSS/Table.css"
      TYPE="text/css">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | View All Users</title>
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
        else if (!usertype_Session.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT * " +
                                        "FROM users " +
                                        "ORDER BY usertype, is_online DESC");
            rs = pst.executeQuery();
            %>
            <table style="width: 85%; margin:1em auto;">
                <tr class="table-header" >
                    <th style="text-align: center;" colspan="7">
                        <i class="fas fa-users"></i> Users
                    </th>
                </tr>
                <tr style="color: black; font-size: 22px;">
                    <th><p><i class="fas fa-id-badge"></i> User ID:</p></th>
                    <th><p><i class="fas fa-user-circle"></i> Username:</p></th>
                    <th><p><i class="far fa-id-card"></i> Full Name:</p></th>
                    <th><p><i class="fas fa-envelope"></i> Email:</p></th>
                    <th><p><i class="fas fa-phone"></i> Phone Number:</p></th>
                    <th><p><i class="fas fa-signal"></i> Online Status:</p></th>
                    <th><p><i class="fas fa-user-shield"></i> Usertype:</p></th>
                </tr>
                <%
                while (rs.next()) {
                    int user_id_db = rs.getInt("user_id");
                    String username_db = rs.getString("username");
                    String email_db = rs.getString("email");
                    String fullname_db = rs.getString("full_name");
                    String telephone_db = rs.getString("telephone");
                    String usertype_db = rs.getString("usertype");
                    String isonline;
                    if (telephone_db == null) telephone_db = "Not Specified";
                    if (rs.getBoolean("is_online")) isonline = "Online"; else isonline = "Offline";
                    %>
                    <tr style="color: black; font-size: 20px;">
                        <td><p><%= user_id_db %></p></td>
                        <td><p><%= username_db %></p></td>
                        <td><p><%= fullname_db %></p></td>
                        <td><p><%= email_db %></p></td>
                        <td><p><%= telephone_db %></p></td>
                        <%
                        if (isonline.equalsIgnoreCase("Online")) {
                            %>
                            <td><p><i style="color: #10AB00" class="fas fa-circle"></i> <%= isonline %></p></td>
                            <%
                        }
                        else {
                            %>
                            <td><p><i style="color: #252323" class="fas fa-circle"></i> <%= isonline %></p></td>
                            <%
                        }
                        %>
                        <td><p><%= usertype_db %></p></td>
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
