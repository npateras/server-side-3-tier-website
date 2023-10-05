package mainpackage.Servlets;

import mainpackage.Utils.Connect_Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet("/Panel_Film_Add_Servlet")
public class Panel_Film_Add_Servlet extends HttpServlet {

    public Panel_Film_Add_Servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("default.jsp").include(request, response);
        PrintWriter out = response.getWriter();
        out.println(
                "<html>" +
                        "<title>Movie Theaters | Add a new film</title>" +
                        "<head>" +
                        "</head>" +
                        "<body>" +
                        "<br><br><br><br>");
        HttpSession session = request.getSession();
        String _username = (String) session.getAttribute("username");
        String _usertype = (String) session.getAttribute("user_type");

        String film_Title = request.getParameter("field_Title");
        String film_Categories = request.getParameter("hidden_categories_result");
        String film_Desc = request.getParameter("field_Desc");
        ArrayList<String> errorMsg = new ArrayList<>();

        if (_username == null) {
            out.println(
                    "<div style='color: red' class='div-container-black'>" +
                            "<i class='fas fa-times-circle'></i> You must be logged-in to view this page!" +
                            "</div>"
            );
            return;
        }
        else if (_usertype.equalsIgnoreCase("User")) {
            out.println(
                    "<div style='color: red' class='div-container-black'>" +
                            "<i class='fas fa-times-circle'></i> You must be a staff member to view this page!" +
                            "</div>"
            );
            return;
        }
        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT title " +
                                            "FROM films " +
                                            "WHERE title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) {
                errorMsg.add("Film already exists!");
            }
            if (!errorMsg.isEmpty()) {
                out.println("<div style='color: red' class='div-container-black'>");
                for (String msg : errorMsg) {
                    out.println("<i class='fas fa-times-circle'></i>" + " " + msg);
                }
                out.println("</div>");
            errorMsg.clear();
            return;
            }
            pst = conn.prepareStatement("SELECT setval('films_film_id_seq', max(film_id)) " +
                                            "FROM films;");
            pst.executeQuery();
            pst = conn.prepareStatement("INSERT INTO films(title, categories, description) " +
                                            "VALUES ('"+film_Title+"', '"+film_Categories+"', '"+film_Desc+"')");
            int i = pst.executeUpdate();
            if (i > 0) {
                out.println(
                        "<div style='color: #32f024' class='form form-submit-details-wrong'>" +
                            "<i class='fas fa-check-circle'></i> You have successfully added a new film!" +                            "</div>"
                );
            }
            else {
                out.println(
                        "<div style='color: red;' class='form form-submit-details-wrong'>" +
                            "<i class='fas fa-times-circle'></i> An error has occurred while adding a new film!" +
                        "</div>");
                pst.close();
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong! (Panel_Film_Add_Request.jsp)");
            e.printStackTrace();
        }
        out.println(
                "</body>" +
                        "</html>");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
