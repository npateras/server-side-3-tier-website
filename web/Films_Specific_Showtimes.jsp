<jsp:include page="default.jsp"/>

<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>

<LINK REL=STYLESHEET
      HREF="CSS/Table.css"
      TYPE="text/css">

<html>
    <head>
        <title>Movie Theaters | Specific Showtimes</title>
    </head>
    <body>
        <br><br><br><br>
        <%
            String date1 = request.getParameter("input_Date_Search1").replace("T"," ");
            String date2 = request.getParameter("input_Date_Search2").replace("T"," ");
            //Se periptosi pou ta strings einai kena tote epistrefoume stin arxiki
            if ((date1 == null) || (date2 == null)) {
                response.sendRedirect("index.jsp");
                return;
            }

            Date dateFinal1 = null, dateFinal2 = null;
            java.sql.Date dateSQL1 = null, dateSQL2 = null;
            try {
                dateFinal1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
                dateFinal2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
                dateSQL1 = new java.sql.Date(dateFinal1.getTime());
                dateSQL2 = new java.sql.Date(dateFinal2.getTime());
            } catch (ParseException e) {
                e.printStackTrace();
            }

            DateFormat dateFormat = new SimpleDateFormat("dd-MMMMMMMMM-YY");
            DateFormat timeFormat = new SimpleDateFormat("hh:mm aaa");

            Connection conn = null;
            PreparedStatement pst = null, pst2 = null;
            ResultSet rs = null, rs2 = null;
            conn = Connect_Database.getConnection();
            try {
                pst = conn.prepareStatement("SELECT F.*, PR.film_id, count(PR.film_id) AS c " +
                                                "FROM films F, provoles PR " +
                                                "WHERE F.film_id = PR.film_id " +
                                                "AND start_date::date BETWEEN ? AND ? " +
                                                "GROUP BY F.film_id, PR.film_id " +
                                                "HAVING count(PR.film_id) > 0;");
                pst.setDate(1, dateSQL1);
                pst.setDate(2, dateSQL2);
                rs = pst.executeQuery();
                if (!rs.next()) {
                    %>
                    <div class="form content-container">
                        <i class="fas fa-heart-broken"></i> There are no showtimes available for the given dates!
                    </div>
                    <%
                    return;
                }
                %>
                <div style="margin: auto; max-width: 60%; width: 600px;" class="form">
                    <div class="form-heading"><i class="fas fa-search"></i> Search showtimes between dates:</div>
                    <form action="Films_Specific_Showtimes.jsp" name="formSearchShowtimes" method="POST">
                        <label>
                            <input type="date" class="input-search" name="input_Date_Search1" value="<%=date1%>" required/>
                            <input type="date" class="input-search" name="input_Date_Search2" value="<%=date2%>" required/>
                            <button class="search-button">Search <i class="fas fa-search"></i></button>
                        </label>
                    </form>
                </div>
                <br><br>
                <div style="font-size: 25px; max-width: 50%; width: 40%" class="form content-container">Showing selected showtimes:</div>
                <%
                rs = pst.executeQuery();
                while (rs.next()) {
                    String film_Title = rs.getString("title");
                    pst = conn.prepareStatement("SELECT * " +
                                                "FROM films F, provoles PR, screens Sc " +
                                                "WHERE F.film_id = PR.film_id " +
                                                "AND PR.screen_id = Sc.screen_id " +
                                                "AND start_date::date BETWEEN ? AND ? " +
                                                "AND title=?" +
                                                "AND is_available=true;");
                    pst.setDate(1, dateSQL1);
                    pst.setDate(2, dateSQL2);
                    pst.setString(3, film_Title);
                    rs2 = pst.executeQuery();
                    String film_Categories = rs.getString("categories").replace("|", ", ");
                    String film_Description = rs.getString("description");
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
                        <tr>
                            <td><p class="film-desc">Screen Number:</p></td>
                            <td><p class="film-desc">Date:</p></td>
                            <td><p class="film-desc">Hours:</p></td>
                            <td><p class="film-desc">Available Seats:</p></td>
                        </tr>
                        <%

                        while (rs2.next()) {
                            int provoli_screen_number = rs2.getInt("screen_number");
                            String provoli_date = dateFormat.format(rs2.getDate("start_date")).replace("-", " ");
                            String provoli_start_hour = timeFormat.format(rs2.getTime("start_date"));
                            String provoli_end_hour = timeFormat.format(rs2.getTime("end_date"));
                            int screen_Seats = rs2.getInt("number_of_seats");
                            int screen_Available_Seats = screen_Seats - rs2.getInt("number_of_reservations");
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
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
    </body>
</html>
