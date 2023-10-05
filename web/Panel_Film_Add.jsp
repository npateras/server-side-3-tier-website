<jsp:include page="default.jsp"/>

<html>
    <head>
        <title>Movie Theaters | Add a new film</title>
        <script type="text/javascript">
            //Prosthetoume tin timi tou clicked checkbox
            function checkboxValueCount(input){
                var inpHiddenCategories = document.getElementById("hidden_categories_result");

                if (input.checked == true) {
                    if (inpHiddenCategories.value == "") {
                        inpHiddenCategories.value = input.value;
                    } else {
                        inpHiddenCategories.value += "|" + input.value;
                    }
                }
                else {
                    if (!inpHiddenCategories.value.includes("|") || inpHiddenCategories.value == "NaN") {
                        inpHiddenCategories.value = "";
                    }
                    if (!inpHiddenCategories.value.startsWith("|")) {
                        inpHiddenCategories.value = inpHiddenCategories.value.replace(input.value + '|', '');
                    }
                    if (inpHiddenCategories.value != "") {
                        inpHiddenCategories.value = inpHiddenCategories.value.replace('|' + input.value,  '');
                    }
                }
            }

            //Function gia na metrisoume posa checkboxes einai checked
            function checkboxCount() {
                var inputElems = document.getElementsByTagName("input"), categoryCount = 0;

                for (var i = 0; i < inputElems.length; i++) {
                    if (inputElems[i].type == "checkbox" && inputElems[i].checked == true){
                        categoryCount++;
                    }
                }
                return categoryCount;
            }

            function formCheck(_categoryCount) {
                document.getElementById("div_Errors").innerHTML = "";
                document.getElementById("div_Errors").style.display = "none";

                var title = document.form_Film_Add.field_Title.value;
                var description = document.form_Film_Add.field_Desc.value;

                var errors = [];

                if (title == null || title === "") {
                    errors.push(" You must enter a film title!");
                }
                if (_categoryCount < 1) {
                    errors.push(" You need to add at least 1 category!");
                }
                if (_categoryCount > 3) {
                    errors.push(" You can't choose more than 3 categories!");
                }
                if (description == null || description === "") {
                    errors.push(" You must enter a film description!");
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
        String _usertype = (String) session.getAttribute("user_type");

        if (_username == null) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be logged-in to view this page!
            </div>
            <%
            return;
        }
        else if (_usertype.equalsIgnoreCase("User")) {
            %>
            <div style="color: red" class="div-container-black">
                <i class="fas fa-times-circle"></i> You must be a staff member to view this page!
            </div>
            <%
            return;
        }
        else {
            %>
            <div id="div_Errors" style="display: none;" class="form form-submit-details-wrong"></div>

            <div class="form">
                <div class="form-heading">Add New Film <i class="fas fa-film"></i></div>
                <form action="Panel_Film_Add_Servlet" name="form_Film_Add" method="POST" onsubmit="return formCheck(checkboxCount())">
                    <label>
                        <span>Title <span class="required">*</span></span>
                        <input type="text" class="input-field" name="field_Title" placeholder="Enter film title"/>
                    </label>

                    <br>
                    <label>
                        <span>Categories <span class="required">*</span></span>
                        <ul class="checkbox-grid">
                            <li><input onClick="checkboxCount(); checkboxValueCount(this);" type="checkbox" name="checkbox-category" id="checkbox-Action" value="Action" /><label for="checkbox-Action">Action</label></li>

                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Adventure" value="Adventure" /><label for="checkbox-Adventure">Adventure</label></li>

                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Animation" value="Animation" /><label for="checkbox-Animation">Animation</label></li>
                        </ul>

                        <span></span>
                        <ul class="checkbox-grid">
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Children" value="Children" /><label for="checkbox-Children">Children</label></li>

                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Comedy" value="Comedy" /><label for="checkbox-Comedy">Comedy</label></li>

                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Crime" value="Crime" /><label for="checkbox-Crime">Crime</label></li>
                        </ul>

                        <span></span>
                        <ul class="checkbox-grid">
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Drama" value="Drama" /><label for="checkbox-Drama">Drama</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Documentary" value="Documentary" /><label for="checkbox-Documentary">Documentary</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Horror" value="Horror" /><label for="checkbox-Horror">Horror</label></li>
                        </ul>

                        <span></span>
                        <ul class="checkbox-grid">
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Thriller" value="Thriller" /><label for="checkbox-Thriller">Thriller</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Romance" value="Romance" /><label for="checkbox-Romance">Romance</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Mystery" value="Mystery" /><label for="checkbox-Mystery">Mystery</label></li>
                        </ul>

                        <span></span>
                        <ul class="checkbox-grid">
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Musical" value="Musical" /><label for="checkbox-Musical">Musical</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Sci-Fi" value="Sci-Fi" /><label for="checkbox-Sci-Fi">Sci-Fi</label></li>
                            <li><input onClick="checkboxCount(); checkboxValueCount(this)" type="checkbox" name="checkbox-category" id="checkbox-Western" value="Western" /><label for="checkbox-Western">Western</label></li>
                        </ul>
                    </label>

                    <br>
                    <label>
                        <span>Description <span class="required">*</span></span>
                        <textarea style="margin-top: 10px" name="field_Desc" class="textarea-field" rows="" cols="" placeholder="Enter film description"></textarea>
                    </label>
                    <input type="submit" value="Add Film"/>

                    <input type="hidden" name="hidden_categories_result" id="hidden_categories_result"/>
                    <br><br>
                </form>
            </div>
            <%
            }
        %>
    </body>
</html>
