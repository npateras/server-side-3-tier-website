<%@ page import="mainpackage.Utils.Connect_Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Movie Theaters | Delete a film</title>
        <script type="text/javascript">
            function formCheck() {
                document.getElementById("div_Errors").innerHTML = "";
                document.getElementById("div_Errors").style.display = "none";

                var user = document.form_DeleteFilm.field_film.value;
                var errors = [];

                if (user == null || user === "" || user === "-") {
                    errors.push(" You must select a film before processing!");
                }
                if (errors.length !== 0) {
                    document.getElementById("div_Errors").style.display = "block";
                    document.getElementById("div_Errors").style.color = "Red";
                    for (var i = 0; i < errors.length; i++) {
                        document.getElementById("div_Errors").innerHTML += '<i class="fas fa-times-circle"></i>' + errors[i] + '<br />';
                    }
                    return false;
                }
                var r = confirm("Are you sure you want to remove this film?");
                if (!r) {
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <br><br><br><br>
        <%
        String _username = (String) session.getAttribute("username");
        String _usertype = (String) session.getAttribute("user_type");
        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
            </div>
            <%
            return;
        }
        else if (!_usertype.equalsIgnoreCase("Administrator")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        %>

        <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

        <div class="form">
            <div class="form-heading"><i class="fas fa-times"></i> Remove a Film</div>
            <form action="Panel_Film_Delete_Request.jsp" name="form_DeleteFilm" method="POST" onsubmit="return formCheck();">
                <label>
                    <span>Film </span>
                    <select name="field_film" class="select-field" required>
                        <option selected hidden disabled>-</option>
                        <%
                            try {
                                Connection conn = null;
                                PreparedStatement pst = null;
                                ResultSet rs = null;

                                conn = Connect_Database.getConnection();
                                pst = conn.prepareStatement("SELECT title " +
                                                            "FROM films");
                                rs = pst.executeQuery();
                                while (rs.next()) {
                                    String film_Title = rs.getString("title");
                                    %>
                                    <option value="<%=film_Title%>"><%=film_Title%></option>
                                    <%
                                }
                            }
                            catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </label>
                <button style="margin-left: 119px">Remove <i class="fas fa-times"></i></button>
                <br><br>
                Note: Showtimes for this film will also be deleted.
            </form>
        </div>
    </body>
</html>
