<%@ page import ="mainpackage.Administrators.Admins" %>
<%@ page import="mainpackage.Utils.Encryption" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mainpackage.Members.Users" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Modifying User...</title>
    </head>
    <body>
        <br><br><br><br>
        <%
        /* Plirofories tou session*/
        String username_Session = (String) session.getAttribute("username");
        String usertype_Session = (String) session.getAttribute("user_type");
        if (username_Session == null) {
            %>
            <div style="color: red" class="form content-container">
                <p>You must be logged-in to view this page!</p>
            </div>
            <%
            return;
        }
        else if (!usertype_Session.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        Admins adminsClass = new Admins();
        Users users = new Users();
        String full_name_Form = request.getParameter("field_first_name")
                                + " "
                                + request.getParameter("field_last_name");
        String username_Form = request.getParameter("field_username");

        String selected_user = request.getParameter("input_hidden_username");
        int user_id_db = users.getUserId(selected_user);
        String username_db = users.getUsername(user_id_db);

        String email_Form = request.getParameter("field_email");
        String email_db = users.getEmail(selected_user);

        String telephone_Form = request.getParameter("field_telephone");
        String password_Form = request.getParameter("field_password");
        if (password_Form != "") {
            password_Form = Encryption.hashPassword(password_Form);
        }
        String usertype_Form = request.getParameter("field_usertype");

        if (selected_user == null || username_Form == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ArrayList errors = new ArrayList();
        if (!selected_user.equals(username_Form)) {
            if (adminsClass.searchUsername(username_Form)) {
                errors.add(" Username already exists!");
            }
        }
        if (!email_Form.equals(email_db)) {
            if (adminsClass.searchEmail(email_Form)) {
                errors.add(" Email already exists!");
            }
        }
        if (!errors.isEmpty()) {
            %>
            <div style="color: red;" class="form content-container">
                <%
                    for (int i = 0; i < errors.size(); i++) {
                        %><i class="fas fa-times-circle"></i><%
                        out.println(errors.get(i));
                        %><br><%
                    }
                %>
            </div>
            <%
            return;
        }
        boolean r = adminsClass.updateUser(username_Form, password_Form, full_name_Form, email_Form, telephone_Form, usertype_Form);
        if (r) {
            %>
            <div style="color: #32f024" class="form content-container">
                <i class="fas fa-check-circle"></i> User <%=username_Form%> successfully modified!
            </div>
            <%
        }
        else {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> User <%=username_Form%> could not be modified!
            </div>
            <%
        }
        %>

    </body>
</html>
