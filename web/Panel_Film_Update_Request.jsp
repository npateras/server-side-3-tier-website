<%@ page import ="mainpackage.Administrators.Admins" %>
<%@ page import="mainpackage.Utils.Encryption" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mainpackage.Members.Users" %>
<%@ page import="mainpackage.Administrators.ContentAdmins" %>
<%@ page import="mainpackage.Information.Films" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Updating Film...</title>
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
        ContentAdmins contentAdmins = new ContentAdmins();
        String film_title_Form = request.getParameter("field_title");
        String film_categories_Form = request.getParameter("field_categories");
        String film_description_Form = request.getParameter("field_description");
        String selected_film = request.getParameter("input_hidden_film");
        int film_id = new Films().getFilmId(selected_film);

        if (selected_film == null || film_title_Form == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ArrayList errors = new ArrayList();
        if (!selected_film.equals(film_title_Form)) {
            if (contentAdmins.searchFilm(film_title_Form)) {
                errors.add(" Film already exists!");
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
        boolean r = contentAdmins.updateFilm(film_id, film_title_Form, film_categories_Form, film_description_Form);
        if (r) {
            %>
            <div style="color: #32f024" class="form content-container">
                <i class="fas fa-check-circle"></i> Film <%=selected_film%> successfully modified!
            </div>
            <%
        }
        else {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> Film <%=selected_film%> could not be modified!
            </div>
            <%
        }
        %>

    </body>
</html>
