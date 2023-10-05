<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="mainpackage.Administrators.ContentAdmins" %>
<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>Movie Theaters | Create a User</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var film = document.form_ShowtimeInsert.field_film.value;
            var screen = document.form_ShowtimeInsert.field_screen.value;
            var dateStart = document.form_ShowtimeInsert.field_date_start.value;
            var timeStart = document.form_ShowtimeInsert.field_time_start.value;
            var dateEnd = document.form_ShowtimeInsert.field_date_end.value;
            var timeEnd = document.form_ShowtimeInsert.field_time_end.value;

            var errors = [];

            if (film == "" || film == "-") {
                errors.push(" Film can't be empty!");
            }
            if (screen == "" || screen == "-") {
                errors.push(" Screen Number can't be empty!");
            }
            if (screen == "" || screen == "-") {
                errors.push(" Screen Number can't be empty!");
            }
            if (dateEnd < dateStart) {
                errors.push(" Ending date is smaller than starting date");
            }
            var timeLimitStarting = new Date();
            var timeLimitEnding = new Date();
            timeLimitStarting.setHours(5); timeLimitStarting.setMinutes(0);
            timeLimitEnding.setHours(24); timeLimitEnding.setMinutes(0);
            if (new Date(dateStart) == new Date(dateEnd)) {
                if (timeEnd < timeStart) {
                    errors.push(" Ending time is smaller than starting time");
                }
            }
            if (errors.length !== 0) {
                document.getElementById("div_Errors").style.display = "block";
                document.getElementById("div_Errors").style.color = "Red";
                for (i = 0; i < errors.length; i++) {
                    document.getElementById("div_Errors").innerHTML += '<i class="fas fa-times-circle"></i>' + errors[i] + '<br />';
                }
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
        <div style="color: red" class="form content-container">
            <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
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
    ContentAdmins contentAdmins = new ContentAdmins();
    %>

    <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

    <%--Forma gia dimiourgia xristi--%>
    <div style="max-width: 900px; width: 600px" class="form">
        <div class="form-heading"><i class="fas fa-video"></i> Create a showtime</div>
        <form action="Showtime_Insert_Request.jsp" name="form_ShowtimeInsert" method="POST" onsubmit="return formCheck()">
            <label>
                <span style="width: 160px"><i class="fas fa-film"></i> Film <span class="required">*</span></span>
                <select style="width: 60%" class="select-field" name="field_film">
                    <option selected hidden disabled>-</option>
                    <%
                        Connection conn = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        conn = Connect_Database.getConnection();
                        try {
                            pst = conn.prepareStatement("SELECT title " +
                                                        "FROM films");
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                String film = rs.getString("title");
                                %>
                                <option value="<%=film%>" title="<%=film%>"><%=film%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>

            <br>
            <label>
                <span style="width: 160px"><i class="fas fa-tv"></i> Screen Number <span class="required">*</span></span>
                <select style="width: 20%" class="select-field" name="field_screen">
                    <%
                        conn = Connect_Database.getConnection();
                        try {
                            pst = conn.prepareStatement("SELECT screen_number, is_3d " +
                                                        "FROM screens");
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                boolean is3d = rs.getBoolean("is_3d");
                                int screen_number = rs.getInt("screen_number");
                                String screen;
                                if (is3d) {
                                    screen = screen_number + " [3D]";
                                }
                                else {
                                    screen = String.valueOf(screen_number);
                                }
                                %>
                                <option value="<%=screen_number%>"><%=screen%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>

            <br>
            <label>
                <span style="width: 160px"><i class="fas fa-calendar-alt"></i> Start Date/Time <span class="required">*</span></span>
                <input style="width: 30%" type="date" class="input-field" name="field_date_start" required/>
                <input style="width: 22%" type="time" class="input-field" name="field_time_start" required/>
            </label>
            <br>
            <label>
                <span style="width: 160px"><i class="fas fa-calendar-alt"></i> End Date/Time <span class="required">*</span></span>
                <input style="width: 30%" type="date" class="input-field" name="field_date_end" required/>
                <input style="width: 22%" type="time" class="input-field" name="field_time_end" required/>
            </label>

            <br><br>
            <label>
                <span style="width: 160px"><i class="fas fa-calendar-check"></i> Available? <span class="required">*</span></span>
                <select style="width: 15%" class="select-field" name="field_available">
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </label>
            <button style="margin-left: 180px">Create <i class="fas fa-plus"></i></button>
            <br><br>
        </form>
    </div>
</body>
</html>
