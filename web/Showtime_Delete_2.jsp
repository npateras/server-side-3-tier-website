<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <title>Movie Theaters | Delete a Showtime</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var film = document.form_DeleteShowtime.field_film_title.value;
            var showtime = document.form_DeleteShowtime.field_showtimes.value;

            var errors = [];

            if (film == null || film == "" || film == "-") {
                errors.push(" You must select a film before processing!");
            }
            if (showtime == null || showtime == "" || showtime == "-") {
                errors.push(" You must select a showtime before processing!");
            }
            if (errors.length !== 0) {
                document.getElementById("div_Errors").style.display = "block";
                document.getElementById("div_Errors").style.color = "Red";
                for (var i = 0; i < errors.length; i++) {
                    document.getElementById("div_Errors").innerHTML += '<i class="fas fa-times-circle"></i>' + errors[i] + '<br />';
                }
                return false;
            }
            var r = confirm("Are you sure you want to delete this showtime?");
            if (!r) {
                return false;
            }
        }
    </script>
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
        else if (usertype_Session.equalsIgnoreCase("User")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        String film_Title_Form = request.getParameter("field_film_title");
        if (film_Title_Form == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <div style="max-width: 1000px; width: 800px" class="form">
            <div class="form-heading"><i class="fas fa-video"></i> Delete a Showtime</div>
            <form action="Showtime_Delete_Request.jsp" name="form_DeleteShowtime" method="POST" onsubmit="return formCheck();">
            <label>
                <span><i class="fas fa-calendar-alt"></i> Film</span>
                <input type="text" class="not-allowed-input-field" name="field_film_title" readonly value="<%=film_Title_Form%>"/>
                </label>
            <br>
            <label>
                <span><i class="fas fa-film"></i> Showtime </span>
                <select style="width: 600px;" name="field_showtimes" class="select-field">
                    <option selected hidden disabled>-</option>
                    <%
                        try {
                            Connection conn = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;

                            conn = Connect_Database.getConnection();
                            pst = conn.prepareStatement("SELECT PR.*, F.*, Sc.* " +
                                                        "FROM provoles PR, films F, screens Sc " +
                                                        "WHERE PR.film_id = F.film_id " +
                                                        "AND PR.screen_id = Sc.screen_id " +
                                                        "AND title=? " +
                                                        "ORDER BY start_date, screen_number;");
                            pst.setString(1, film_Title_Form);
                            rs = pst.executeQuery();
                            DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMMMMMMM-YY");
                            DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");
                            while (rs.next()) {
                                int provoli_screen_number = rs.getInt("screen_number");
                                String provoli_date = dateFormat.format(rs.getDate("start_date")).replace("-", " ");
                                String provoli_start_hour = timeFormat.format(rs.getTime("start_date"));
                                String provoli_end_hour = timeFormat.format(rs.getTime("end_date"));

                                int seats = rs.getInt("number_of_seats");
                                int reservations = rs.getInt("number_of_reservations");
                                int _provoli_id = rs.getInt("provoli_id");

                                String provoli = "Screen: " + provoli_screen_number
                                        + " Date: " + provoli_date
                                        + " Hours: " + provoli_start_hour + " - " + provoli_end_hour
                                        + " Reservations: " + reservations + "/" + seats;
                                %>
                                <option value="<%=_provoli_id%>"><%=provoli%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>

            <div>
                <button onclick="window.location.href = 'Showtime_Delete.jsp'; return false;" style=" width: 95px; display: inline; "><i class="fas fa-arrow-circle-left"></i> Back</button>
                <button style="width: 100px; display: inline; margin-left: 386px;">Delete <i class="fas fa-times"></i></button>
            </div>
            <br><br>
        </form>
    </div>
</body>
</html>
