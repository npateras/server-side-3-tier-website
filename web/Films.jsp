<jsp:include page="default.jsp"/>

<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<LINK REL=STYLESHEET
      HREF="CSS/Table.css"
      TYPE="text/css">

<html>
    <head>
        <title>Movie Theaters | Films</title>
    </head>
    <body>
        <br><br><br><br>
            <%
            try {
                Connection conn = null;
                PreparedStatement pst = null, pst2 = null;
                ResultSet rs = null, rs2 = null;

                conn = Connect_Database.getConnection();
                pst = conn.prepareStatement("SELECT title, categories, description " +
                                            "FROM films");
                rs = pst.executeQuery();
                if (!rs.next()) {
                    %>
                    <div class="div-container-black">
                        <p>There are no films available!</p>
                    </div>
                    <%
                }
                else {
                    %>
                    <div style="margin: auto; max-width: 60%; width: 600px;" class="form">
                        <div class="form-heading"><i class="fas fa-search"></i> Search showtimes between dates:</div>
                        <form action="Films_Specific_Showtimes.jsp" name="formSearchShowtimes" method="POST">
                            <label>
                                <input type="date" class="input-search" name="input_Date_Search1" required/>
                                <input type="date" class="input-search" name="input_Date_Search2" required/>
                                <button class="search-button">Search <i class="fas fa-search"></i></button>
                            </label>
                        </form>
                    </div>
                    <%
                    //Ksana ekteloume to query dioti pio panw allios tha arxize apo tin 2i grammi tou pinaka logo tou .next()
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        String film_Title = rs.getString("title");
                        String film_Categories = rs.getString("categories").replace("|", ", ");
                        String film_Description = rs.getString("description");

                        int provoli_screen_number,
                            screen_Available_Seats,
                            screen_Seats;
                        String provoli_date = null,
                                provoli_start_hour = null,
                                provoli_end_hour = null;


                        DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMMMMMMM-YY");
                        DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");
                        %>
                        <table style="width: 40%; margin:1em auto;">
                           <tr>
                               <th colspan="4">
                                        <p class="film-title"><%= film_Title %></p>
                                        <br>
                                        <p><%= film_Categories %></p>
                                        <br>
                                        <p class="film-desc-title"><i>Description:</i></p>
                                        <p class="film-desc"><%= film_Description %></p>
                                        <br>
                                    </th>
                                </tr>
                                <tr>
                                    <th colspan="4"><p class="film-desc-title"><i>Showtimes:</i></p></th>
                                </tr>
                                <%
                                pst2 = conn.prepareStatement("SELECT PR.film_id, F.title, PR.is_available " +
                                                             "FROM provoles PR, films F " +
                                                             "WHERE PR.film_id = F.film_id " +
                                                             "AND title=? " +
                                                             "AND is_available=true;");
                                pst2.setString(1, film_Title);
                                rs2 = pst2.executeQuery();
                                if (!rs2.next()) {
                                    %>
                                    <tr>
                                        <td><p class="film-desc">There are no showtimes available yet!</p></td>
                                    </tr>
                                    <%
                                }
                                else {
                                    %>

                                    <tr>
                                        <td><p class="film-desc">Screen Number:</p></td>
                                        <td><p class="film-desc">Date:</p></td>
                                        <td><p class="film-desc">Hours:</p></td>
                                        <td><p class="film-desc">Available Seats:</p></td>
                                    </tr>
                                    <%
                                    pst2 = conn.prepareStatement("SELECT PR.film_id, PR.end_date, PR.is_available, " +
                                                                 "PR.start_date, PR.number_of_reservations, F.title, " +
                                                                 "Sc.screen_number, Sc.number_of_seats " +
                                                                 "FROM provoles PR, films F, screens Sc " +
                                                                 "WHERE PR.film_id = F.film_id " +
                                                                 "AND PR.screen_id = Sc.screen_id " +
                                                                 "AND title=? " +
                                                                 "AND is_available=true;");
                                    pst2.setString(1, film_Title);
                                    rs2 = pst2.executeQuery();
                                    while (rs2.next()) {
                                        provoli_screen_number = rs2.getInt("screen_number");
                                        provoli_date = dateFormat.format(rs2.getDate("start_date")).replace("-", " ");
                                        provoli_start_hour = timeFormat.format(rs2.getTime("start_date"));
                                        provoli_end_hour = timeFormat.format(rs2.getTime("end_date"));
                                        screen_Seats = rs2.getInt("number_of_seats");
                                        screen_Available_Seats = screen_Seats - rs2.getInt("number_of_reservations");
                                        %>
                                        <tr>
                                            <td><p class="film-desc"><%= provoli_screen_number %></p></td>
                                            <td><p class="film-desc"><%= provoli_date %></p></td>
                                            <td><p class="film-desc"><%= provoli_start_hour %> - <%= provoli_end_hour %></p></td>
                                            <td><p class="film-desc"><%=screen_Available_Seats%>/<%=screen_Seats%></p></td>
                                        </tr>
                                        <%
                                    }
                                    %>
                            </table>
                            <%
                                }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
    </body>
</html>
