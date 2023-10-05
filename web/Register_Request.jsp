<%@ page import="mainpackage.Administrators.Admins" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="default.jsp"/>

<html>
    <head>
        <title>Movie Theaters | Register Confirmation</title>
    </head>
    <body>
        <br><br><br><br>
        <%
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
                <i class="fas fa-check-circle"></i> You have successfully registered your account!
            </div>
            <%
        }
        else {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> There was an error while registering your account!
            </div>
            <%
        }
        %>
    </body>
</html>