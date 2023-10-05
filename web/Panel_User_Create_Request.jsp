<%@ page import ="mainpackage.Administrators.Admins" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Create a User</title>
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
        Admins adminsClass = new Admins();
        String full_name_Form = request.getParameter("field_first_name")
                                + " "
                                + request.getParameter("field_last_name");
        String username_Form = request.getParameter("field_username");
        String email_Form = request.getParameter("field_email");
        String telephone_Form = request.getParameter("field_telephone");
        String pass_Form = request.getParameter("field_password");
        String usertype_Form = request.getParameter("field_usertype");

        ArrayList errors = new ArrayList();

        if (username_Form == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (adminsClass.searchUsername(username_Form)) {
            errors.add(" Username already exists!");
        }
        if (adminsClass.searchEmail(email_Form)) {
            errors.add(" Email already exists!");
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
        boolean r = adminsClass.createUser(username_Form, pass_Form, full_name_Form, email_Form, telephone_Form, usertype_Form);
        if (r) {
            %>
            <div style="color: #32f024" class="form content-container">
                <i class="fas fa-check-circle"></i> User <%=username_Form%> successfully added!
            </div>
            <%
        }
        else {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> User <%=username_Form%> could not be added!
            </div>
            <%
        }
        %>

    </body>
</html>
