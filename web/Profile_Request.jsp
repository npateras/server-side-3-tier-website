<%@ page import ="mainpackage.Utils.Connect_Database" %>
<%@ page import="mainpackage.Members.Users" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="mainpackage.Utils.Encryption" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Profile</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        /* Plirofories tou session*/
        String username_Session = (String) session.getAttribute("username");
        if (username_Session == null) {
            %>
            <div class="div-container-black">
                <p>You must be logged-in to view this page!</p>
            </div>
            <%
            return;
        }
        Users users = new Users();
        String full_name_Form = request.getParameter("field_first_name")
                                + " "
                                + request.getParameter("field_last_name");
        String username_Form = request.getParameter("field_hidden_username");
        String email_Form = request.getParameter("field_email");
        String telephone_Form = request.getParameter("field_telephone");
        String newPass = Encryption.hashPassword(request.getParameter("field_new_password"));
        String currentPass = Encryption.hashPassword(request.getParameter("field_current_password"));

        int user_id_db = users.getUserId(username_Session);
        String password_db = users.getPassword(username_Session);
        String email_db = users.getEmail(username_Session);

        if (username_Form == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        //Se periptosi pou to email pou einai stin forma den einai to idio me to trexon email tou xristi
        if (!email_Form.equals(email_db)) {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conn = Connect_Database.getConnection();
            try {
                pst = conn.prepareStatement("SELECT email " +
                                            "FROM users " +
                                            "WHERE email=?");
                pst.setString(1, email_Form);
                rs = pst.executeQuery();

                if (rs.next()) {
                    %>
                    <div style="color: red" class="div-container-black">
                        <i class="fas fa-times-circle"></i> Email already exists!
                    </div>
                    <%
                    return;
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        //Se periptosi pou o kainourgios kwdikos den einai idios me ton trexon
        if (!newPass.equals(currentPass)) {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conn = Connect_Database.getConnection();
            try {
                pst = conn.prepareStatement("SELECT password " +
                                            "FROM users " +
                                            "WHERE username=?");
                pst.setString(1, username_Form);
                rs = pst.executeQuery();
                if (rs.next()) {
                    if (!currentPass.equals(password_db)) {
                        %>
                        <div style="color: red" class="div-container-black">
                            <i class="fas fa-times-circle"></i> Your current password was incorrect!
                        </div>
                        <%
                        return;
                    }
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }

        users.setEmail(user_id_db, email_Form);
        users.setFullName(user_id_db, full_name_Form);
        if (!telephone_Form.isEmpty()) users.setTelephone(user_id_db, telephone_Form);
        if (!newPass.isEmpty()) users.setPassword(user_id_db, newPass);
        %>
        <div style="color: #32f024" class="form content-container">
            <i class="fas fa-check-circle"></i> You have successfully updated your profile!
        </div>
    </body>
</html>
