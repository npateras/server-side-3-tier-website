package mainpackage.Information;

import mainpackage.Utils.Connect_Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Films {
    private int filmId;
    private String filmTitle;
    private String filmCategories;
    private String filmDescription;

    public Films(){}

    public Films(int filmId, String filmTitle, String filmCategories, String filmDescription) {
        this.filmId = filmId;
        this.filmTitle = filmTitle;
        this.filmCategories = filmCategories;
        this.filmDescription = filmDescription;
    }

    //  Get/Set for filmId
    public int getFilmId(String film_Title) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT film_id " +
                    "FROM films " +
                    "WHERE title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) {
                filmId = rs.getInt("film_id");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return filmId = 0;
        }
        return filmId;
    }

    //  Get/Set for filmTitle
    public String getFilmTitle(int provoli_id) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT title " +
                                            "FROM films F, provoles PR " +
                                            "WHERE provoli_id=? " +
                                            "AND F.film_id = PR.film_id");
            pst.setInt(1, provoli_id);
            rs = pst.executeQuery();
            if (rs.next()) {
                filmTitle = rs.getString("title");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return null;
        }
        return filmTitle;
    }

    //  Get/Set for filmCategories
    public String getFilmCategories(String film_Title) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT categories " +
                    "FROM films " +
                    "WHERE title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) {
                filmCategories = rs.getString("categories");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return null;
        }
        return filmCategories;
    }

    //  Get/Set for filmDescription
    public String getFilmDescription(String film_Title) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT description " +
                                            "FROM films " +
                                            "WHERE title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) {
                filmDescription = rs.getString("description");
            }
        }
        catch (Exception e) {
                System.out.println("Something went wrong!");
                e.printStackTrace();
                return null;
        }
        return filmDescription;
    }

    public void setFilmId(int filmId) {
        this.filmId = filmId;
    }

    public void setFilmCategories(String filmCategories) {
        this.filmCategories = filmCategories;
    }

    public void setFilmTitle(String filmTitle) {
        this.filmTitle = filmTitle;
    }

    public void setFilmDescription(String filmDescription) {
        this.filmDescription = filmDescription;
    }
}
