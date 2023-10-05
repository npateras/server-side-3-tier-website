<%@ page import="mainpackage.Members.Users" %>
<%@ page import="mainpackage.Information.Films" %>
<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>Movie Theaters | Modify a Film</title>
    <script type="text/javascript">
        function formCheck() {
            document.getElementById("div_Errors").innerHTML = "";
            document.getElementById("div_Errors").style.display = "none";

            var title = document.form_ModifyFilm2.field_title.value;
            var description = document.form_ModifyFilm2.field_description.value;
            var categories = document.form_ModifyFilm2.field_categories.value;

            var errors = [];

            var reCategories = /^[,A-Za-z]+$/;
            if (title == "") {
                errors.push(" You must enter a film title!");
            }

            if (categories == "") {
                errors.push(" You must enter film categories!");
            }
            else {
                if (!reCategories.test(categories)) {
                    errors.push(" Special characters and digits are not allowed in film categories! Separate categories with a comma.");
                }
            }
            if (description == "") {
                errors.push(" You must enter film description!");
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
    else if (!usertype_Session.equalsIgnoreCase("Administrator")) {
        %>
        <div style="color: red" class="form content-container">
            <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
        </div>
        <%
        return;
    }
    Films films = new Films();
    String film_title_Form = request.getParameter("field_title");
    String film_categories = films.getFilmCategories(film_title_Form).replace("|", ",");
    String film_description = films.getFilmDescription(film_title_Form);
    %>

    <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

    <%--Forma gia dimiourgia xristi--%>
    <div class="form">
        <div class="form-heading"><i class="fas fa-edit"></i> Modify Film</div>
        <form action="Panel_Film_Update_Request.jsp" name="form_ModifyFilm2" method="POST" onsubmit="return formCheck()">
            <label>
                <span style="width: 150px"><i class="fas fa-film"></i> Title </span>
                <input type="text" class="input-field" name="field_title" placeholder="Enter a film title" value="<%=film_title_Form%>">
            </label>

            <br>
            <label>
                <span style="width: 150px"><i class="fas fa-align-left"></i> Categories (Separate with comma)</span>
                <input type="text" class="input-field" name="field_categories" placeholder="Enter category types for film" value="<%=film_categories%>">
            </label>

            <br><br>
            <label>
                <span style="width: 150px"><i class="fas fa-comment-dots"></i> Description </span>
                <textarea style="margin-top: 10px" name="field_description" class="textarea-field" rows="" cols="" placeholder="Enter film description"><%=film_description%></textarea>
            </label>

            <button style="margin-left: 170px">Modify <i class="fas fa-pencil-alt"></i></button>

            <input type="hidden" value="<%=film_title_Form%>" name="input_hidden_film" id="input_hidden_film"/>
            <br><br>
        </form>
    </div>
</body>
</html>
