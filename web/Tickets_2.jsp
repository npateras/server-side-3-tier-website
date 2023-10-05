<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="default.jsp"/>

<LINK REL=STYLESHEET
      HREF="CSS/Forms.css"
      TYPE="text/css">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Tickets</title>
        <script type="text/javascript">
            function changeHidden(input){
                var inpHiddenRes = document.getElementById("field_hidden_reservations");
                var inpHiddenSeats = document.getElementById("field_hidden_seats");

                var tempInput = [];
                tempInput = input.value.split(" ");
                inpHiddenRes.value = tempInput[8];
                inpHiddenSeats.value = tempInput[9];
            }

            function formCheck() {
                document.getElementById("div_Errors").innerHTML = "";
                document.getElementById("div_Errors").style.display = "none";

                var film = document.form_Tickets_2.field_film.value;
                var showtime = document.form_Tickets_2.field_showtime.value;
                var errors = [];

                if (film == null || film === "" || film === "-") {
                    window.location.href = 'Tickets.jsp';
                    return false;
                }
                if (showtime == null || showtime === "" || showtime === "-") {
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
        String _username = (String) session.getAttribute("username");
        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to buy a ticket!
            </div>
            <%
            return;
        }

        String film_Title = request.getParameter("field_film");
        int provoli_screen_number = 0, seats = 0, reservations = 0;
        String provoli = null, provoli_date = null, provoli_start_hour = null, provoli_end_hour = null;
        int _provoli_id;

        DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMMMMMMM-YY");
        DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <%--Forma gia tickets--%>
        <div style="max-width: 1000px; width: 800px" class="form">
            <div class="form-heading"><i class="far fa-eye"></i> Select a showtime</div>
            <form action="Tickets_Final.jsp" name="form_Tickets_2" method="POST" onsubmit="return formCheck();">
                <label>
                    <span>Film </span>
                    <select style="background: #aaaaaa" class="select-field" name="field_film" id="field_film" disabled>
                        <option selected value="<%= film_Title %>"><%= film_Title %></option>
                    </select>
                </label>

                <label>
                <span>Showtime <span class="required">*</span></span>
                <select onchange="changeHidden(this);" style="width: 600px;" name="field_showtime" class="select-field" required>
                    <option selected hidden disabled>-</option>
                        <%
                        try {
                            Connection conn = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;

                            conn = Connect_Database.getConnection();
                            pst = conn.prepareStatement("SELECT PR.provoli_id, PR.film_id," +
                                    " F.title, Sc.screen_number, Sc.screen_id, PR.start_date, PR.end_date, " +
                                    "PR.is_available, PR.number_of_reservations, Sc.number_of_seats " +
                                "FROM provoles PR, films F, screens Sc " +
                                "WHERE PR.film_id = F.film_id " +
                                "AND PR.screen_id = Sc.screen_id " +
                                "AND title=? " +
                                "AND is_available=true;");
                            pst.setString(1, film_Title);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                provoli_screen_number = rs.getInt("screen_number");
                                provoli_date = dateFormat.format(rs.getDate("start_date")).replace("-", " ");
                                provoli_start_hour = timeFormat.format(rs.getTime("start_date"));
                                provoli_end_hour = timeFormat.format(rs.getTime("end_date"));

                                seats = rs.getInt("number_of_seats");
                                reservations = rs.getInt("number_of_reservations");
                                _provoli_id = rs.getInt("provoli_id");

                                provoli = "Screen: " + provoli_screen_number
                                        + " Date: " + provoli_date
                                        + " Hours: " + provoli_start_hour + " - " + provoli_end_hour
                                        + " Reservations: " + reservations + "/" + seats;

                                String tempParam = provoli_screen_number + " "
                                                + provoli_date + " "
                                                + provoli_start_hour + " "
                                                + provoli_end_hour + " "
                                                + reservations + " "
                                                + seats + " "
                                                + _provoli_id;
                                /*String tempParam2 = ;*/
                                %>
                                <option value="<%=tempParam%>"><%=provoli%></option>
                                <%
                            }
                        } catch (Exception e) {
                            System.out.println("Something went wrong! (Tickets_2.jsp)");
                            e.printStackTrace();
                        }
                        %>
                    </select>
                </label>

                <input type="hidden" name="field_hidden_film_title" id="field_hidden_film_title" value="<%= film_Title %>">
                <input type="hidden" name="field_hidden_reservations" id="field_hidden_reservations" value="<%= reservations %>">
                <input type="hidden" name="field_hidden_seats" id="field_hidden_seats" value="<%= seats %>">
                <div>
                    <button onclick="window.location.href = 'Tickets.jsp'; return false;" style=" width: 95px; display: inline; "><i class="fas fa-arrow-circle-left"></i> Back</button>
                    <button style="width: 95px; display: inline; margin-left: 390px;">Next <i class="fas fa-chevron-circle-right"></i></button>
                </div>

                <br><br>
            </form>
        </div>
    </body>
</html>
