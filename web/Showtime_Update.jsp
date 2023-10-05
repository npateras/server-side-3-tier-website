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
    <title>Movie Theaters | Modify a Showtime</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var showtime = document.form_ModifyShowtime.field_showtime.value;
            var errors = [];

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
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <div style="max-width: 1000px; width: 900px" class="form">
            <div class="form-heading"><i class="fas fa-edit"></i> Modify a Showtime</div>
            <form action="Showtime_Update_2.jsp" name="form_ModifyShowtime" method="POST" onsubmit="return formCheck();">
            <label>
                <span><i class="fas fa-film"></i> Showtime </span>
                <select style="width: 700px;" name="field_showtime" class="select-field" required>
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
                                    "ORDER BY start_date, title, screen_number;");
                            rs = pst.executeQuery();
                            DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMMMMMMM-YY");
                            DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");
                            while (rs.next()) {
                                String film_title = rs.getString("title");
                                int provoli_screen_number = rs.getInt("screen_number");
                                String provoli_date = dateFormat.format(rs.getDate("start_date")).replace("-", " ");
                                String provoli_start_hour = timeFormat.format(rs.getTime("start_date"));
                                String provoli_end_hour = timeFormat.format(rs.getTime("end_date"));

                                int seats = rs.getInt("number_of_seats");
                                int reservations = rs.getInt("number_of_reservations");
                                int _provoli_id = rs.getInt("provoli_id");

                                String provoli =
                                          " Film: " + film_title
                                        + " Screen: " + provoli_screen_number
                                        + " Date: " + provoli_date
                                        + " Hours: " + provoli_start_hour + " - " + provoli_end_hour
                                        + " Reservations: " + reservations + "/" + seats;
                                %>
                                <option value="<%=_provoli_id%>" title="<%=provoli%>"><%=provoli%></option>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </label>
                <button style="width: 100px; margin-left: 720px">Next <i class="fas fa-chevron-circle-right"></i></button>
                <br><br>
        </form>
    </div>
</body>
</html>
