<%@ page import="java.util.ArrayList" %>
<%@ page import="mainpackage.Administrators.ContentAdmins" %>
<%@ page import="mainpackage.Information.Films" %>
<%@ page import="mainpackage.Information.Screens" %>

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
        String usertype_Session = (String) session.getAttribute("user_type");
        if (username_Session == null) {
            %>
            <div class="div-container-black">
                <p>You must be logged-in to view this page!</p>
            </div>
            <%
            return;
        }
        else if (usertype_Session.equalsIgnoreCase("User")) {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        int provoli_id = Integer.parseInt(request.getParameter("hidden_provoli_id"));
        if (provoli_id <= 0) {
            response.sendRedirect("index.jsp");
            return;
        }

        ContentAdmins contentAdmins = new ContentAdmins();
        String film_title = request.getParameter("field_film");
        int screen_number = Integer.parseInt(request.getParameter("field_screen"));
        String dateStart = request.getParameter("field_date_start");
        String timeStart = request.getParameter("field_time_start");
        String dateEnd = request.getParameter("field_date_end");
        String timeEnd = request.getParameter("field_time_end");
        String isavailable = request.getParameter("field_available");
        String dateStartCompleted = dateStart + " " + timeStart;
        String dateEndCompleted = dateEnd + " " + timeEnd;

        ArrayList errors = new ArrayList();

        if (contentAdmins.checkIfScreenNumberHasSpaceForAll(dateStartCompleted, dateEndCompleted, screen_number)) {
            errors.add(" Screen Number is full of showtimes between those dates and hours!");
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
        Films films = new Films();
        Screens screens = new Screens();
        int filmid = films.getFilmId(film_title);
        int screenid = screens.getScreenId(screen_number);
        boolean r = contentAdmins.updateShowtime(provoli_id, filmid, screenid, dateStartCompleted, dateEndCompleted, isavailable);
        if (r) {
            %>
            <div style="color: #32f024" class="form content-container">
                <i class="fas fa-check-circle"></i> Showtime for film <%=film_title%> successfully added!
            </div>
            <%
        }
        else {
            %>
            <div style="color: red" class="form content-container">
                <i class="fas fa-times-circle"></i> Showtime for film <%=film_title%> could not be added!
            </div>
            <%
        }
        %>

    </body>
</html>
