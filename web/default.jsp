<html>
    <head>
        <link href="Resources/favicon.ico"
              rel="icon"
              type="image/x-icon"/>

        <LINK REL=STYLESHEET
              HREF="CSS/Menu.css"
              TYPE="text/css">

        <LINK REL=STYLESHEET
              HREF="CSS/Basics.css"
              TYPE="text/css">

        <LINK REL=STYLESHEET
              HREF="CSS/Forms.css"
              TYPE="text/css">

        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <style>
            * {
                border: 0;
                margin: 0;
                padding: 0;
                outline: 0;
            }
            BODY {

                background: url("Resources/Background-1.jpg") no-repeat fixed;
                background-size: 100%;
                font-family: "Gill Sans MT", serif;
                font-size: 18px;
                font-weight: bold;
                color: white;
            }
        </style>
        <title></title>

        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    </head>
    <%--To Menu gia oles tis selides--%>
        <div class="nav">
            <a href = "index.jsp"><i class="fa fa-home"></i> Home</a>
            <a href = "Films.jsp"><i class="fa fa-film"></i> Films</a>
            <a href = "Tickets.jsp"><i class="fas fa-ticket-alt"></i> Tickets</a>
            <%
            HttpSession sess = request.getSession(true);
            String _username= (String) sess.getAttribute("username");
            String _usertype = (String) sess.getAttribute("user_type");
            //Ean o xristis den einai sindedemenos, tote emfanizoume ta antistixa koumpia diladi login/register
            if (_username == null) {
                %>
                <a style="float: right;" href = "Login.jsp"><i class="fas fa-user-lock"></i> Login</a>
                <a style="float: right;" href = "Register.jsp"><i class="fas fa-user-plus"></i> Register</a>
                <%
            }
            //Ean o xristis einai sindedemenos kai exei to antistixo tipo xristi tote tha emfanistoun ta katallila koumpia
            else {
            %>
            <div class="dropdown">
                <button class="dropbtn"><i class="fas fa-user"></i> <%=_username%>
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="Previous_Reservations.jsp"><i class="fas fa-history"></i> Reservations</a>
                    <a href="Profile.jsp"><i class="far fa-address-card"></i> Profile</a>
                    <a href="Logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
            <%
            if (_usertype.equalsIgnoreCase("Content Administrator")) {
            %>
            <div class="dropdown">
                <button class="dropbtn"><i class="fas fa-toolbox"></i>
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="Panel_Film_Add.jsp"><i class="fas fa-plus"></i> Insert Film</a>
                    <a href="Panel_Film_Update.jsp"><i class="fas fa-edit"></i> Update Film</a>
                    <a href="Panel_Film_Delete.jsp"><i class="fas fa-trash-alt"></i> Delete Film</a>
                    <a href="Showtime_Insert.jsp"><i class="fas fa-plus"></i> Insert Showtime</a>
                    <a href="Showtime_Update.jsp"><i class="fas fa-edit"></i> Update Showtime</a>
                    <a href="Showtime_Delete.jsp"><i class="fas fa-trash-alt"></i> Delete Showtime</a>
                </div>
            </div>
            <%
            }
            else if (_usertype.equalsIgnoreCase("Administrator")) {
            %>
            <%--Dropdown button gia films management--%>
            <div class="dropdown">
                <button class="dropbtn"><i class="fas fa-toolbox"></i>
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="Panel_Film_Add.jsp"><i class="fas fa-plus"></i> Insert Film</a>
                    <a href="Panel_Film_Update.jsp"><i class="fas fa-edit"></i> Update Film</a>
                    <a href="Panel_Film_Delete.jsp"><i class="fas fa-trash-alt"></i> Delete Film</a>
                    <a href="Showtime_Insert.jsp"><i class="fas fa-plus"></i> Insert Showtime</a>
                    <a href="Showtime_Update.jsp"><i class="fas fa-edit"></i> Update Showtime</a>
                    <a href="Showtime_Delete.jsp"><i class="fas fa-trash-alt"></i> Delete Showtime</a>
                </div>
            </div>
            <%--Dropdown button gia user management--%>
            <div class="dropdown">
                <button class="dropbtn"><i class="fas fa-users-cog"></i>
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="Panel_Users_View.jsp"><i class="fas fa-user-plus"></i> View All Users</a>
                    <a href="Panel_User_Create.jsp"><i class="fas fa-user-plus"></i> Create User</a>
                    <a href="Panel_User_Modify.jsp"><i class="fas fa-user-edit"></i> Modify User</a>
                    <a href="Panel_User_Delete.jsp"><i class="fas fa-user-times"></i> Delete User</a>
                    <a href="Panel_User_Promote.jsp"><i class="fas fa-arrow-alt-circle-up"></i> Promote User</a>
                    <a href="Panel_ContentAdmin_Demote.jsp"><i class="fas fa-user-minus"></i> Remove Content Admin</a>
                </div>
            </div>
            <%
            }
        } %>
        </div>
    <body>

    </body>
</html>
