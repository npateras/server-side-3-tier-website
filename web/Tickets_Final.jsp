<jsp:include page="default.jsp"/>
<%
int reservations = Integer.parseInt(request.getParameter("field_hidden_reservations"));
int seats = Integer.parseInt(request.getParameter("field_hidden_seats"));
%>

<LINK REL=STYLESHEET
      HREF="CSS/Forms.css"
      TYPE="text/css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Tickets</title>
        <script type="text/javascript">
            function changePrice() {

            }

            function formCheck() {
                document.getElementById("div_Errors").innerHTML = "";
                document.getElementById("div_Errors").style.display = "none";

                var film = document.form_Tickets_Final.field_film.value;
                var showtime = document.form_Tickets_Final.field_showtime.value;
                var seats = document.form_Tickets_Final.field_seats.value;
                var maxSeats = <%= seats %>;
                var reservations = <%= reservations %>;
                var freeSeats = maxSeats - reservations;

                var errors = [];

                if (film == null || film == "" || film == "-" || showtime == null || showtime == "" || showtime == "-") {
                    window.location.href = 'Tickets.jsp';
                    return false;
                }
                if (seats == 0) {
                    errors.push(" You must choose seats amount!")
                }
                if (seats > <%= seats %>) {
                    errors.push(" You have selected an invalid seats amount!")
                }
                if (seats > <%= seats %> - <%= reservations %>) {
                    errors.push(" The requested seats amount is not available for reservation! Please select less seats. (Available: " + freeSeats + ")")
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
        String _username = (String) session.getAttribute("username");
        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to buy a ticket!
            </div>
            <%
            return;
        }

        String film_Title = request.getParameter("field_hidden_film_title");
        String showtime = request.getParameter("field_showtime");
        String[] temp1 = showtime.split(" ");
        String showtime_for_input = "Screen: " + temp1[0]
                                    + " Date: " + temp1[1] + " " + temp1[2] +  " " + temp1[3]
                                    + " Hours: " + temp1[4] + " " + temp1[5] + " - " + temp1[6] + " " + temp1[7]
                                    + " Reservations: " + temp1[8] + "/" + temp1[9];
        %>

        <div id="div_Errors" style="display: none; max-width: 1000px; width: 800px" class="form form-submit-details-wrong"></div>

        <%--Forma gia tickets--%>
        <div style="max-width: 1000px; width: 800px" class="form">
            <div class="form-heading"><i class="fas fa-ticket-alt"></i> Complete your order</div>
            <form action="Tickets_Final_Request.jsp" name="form_Tickets_Final" method="POST" onsubmit="return formCheck();">
                <label>
                    <span>Film </span>
                    <input style="background: #aaaaaa;" type="text" class="input-field" name="field_film" value="<%= film_Title %>" disabled/>
                </label>

                <label>
                    <span>Showtime </span>
                    <input style="background: #aaaaaa; width: 600px;" type="text" class="input-field" name="field_showtime" value="<%= showtime_for_input %>" disabled/>
                </label>

                <label>
                    <span>Seats <span class="required">*</span></span>
                    <input onchange="changePrice(this);" style="width: 62px" type="number" class="input-field" name="field_seats" min="0" value="0" required/>
                </label>

                <input type="hidden" name="field_hidden_ids" id="field_hidden_ids" value="<%= temp1[10] %>">

                <div>
                    <button onclick="window.location.href = 'Tickets.jsp'; return false;" style=" width: 95px; display: inline; "><i class="fas fa-arrow-circle-left"></i> Back</button>
                    <button style="width: 150px; display: inline; margin-left: 335px;">Complete Order <i class="fas fa-check"></i></button>
                </div>

                <br><br>
            </form>
        </div>

        <div id="div_notes" style="max-width: 800px; width: 600px" class="form form-submit-details-wrong">
            <i class="far fa-money-bill-alt"></i> Ticket Price: 08.00 EUR. PER Seat!
        </div>
    </body>
</html>
