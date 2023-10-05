package mainpackage.Administrators;

import mainpackage.Utils.Connect_Database;

import java.sql.*;

public class ContentAdmins {
    public boolean insertFilm(String film_Title, String film_Categories, String film_Desc) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("INSERT INTO films(title, categories, description) " +
                    "VALUES ('" + film_Title + "', '" + film_Categories + "', '" + film_Desc + "')");
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean deleteFilm(String film_Title){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("DELETE " +
                    "FROM films " +
                    "WHERE title=?");
            pst.setString(1, film_Title);
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateFilm(int film_id, String film_Title, String film_Categories, String film_Description){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE films " +
                                            "SET title=?, categories=?, description=? " +
                                            "WHERE film_id=?");
            pst.setString(1, film_Title);
            pst.setString(2, film_Categories);
            pst.setString(3, film_Description);
            pst.setInt(4, film_id);
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean searchFilm(String film_Title){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT title " +
                                            "FROM films " +
                                            "WHERE title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) return true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean checkIfScreenNumberHasSpace(String dateStart, String dateEnd, String film_Title, int screen) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT screen_number, F.film_id, title, PR.film_id, PR.screen_id, Sc.screen_id " +
                    "FROM films F, provoles PR, screens Sc " +
                    "WHERE F.film_id = PR.film_id " +
                    "AND PR.screen_id = Sc.screen_id " +
                    "AND start_date BETWEEN ?::timestamp AND ?::date " +
                    "AND end_date BETWEEN ?::timestamp AND ?::date " +
                    "AND title=? " +
                    "AND screen_number=?;");
            pst.setString(1, dateStart);
            pst.setString(2, dateStart);
            pst.setString(3, dateEnd);
            pst.setString(4, dateEnd);
            pst.setString(5, film_Title);
            pst.setInt(6, screen);
            rs = pst.executeQuery();
            if (rs.next()) return true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkIfScreenNumberHasSpaceForAll(String dateStart, String dateEnd, int screen) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT screen_number, F.film_id, title, PR.film_id, PR.screen_id, Sc.screen_id " +
                                            "FROM films F, provoles PR, screens Sc " +
                                            "WHERE F.film_id = PR.film_id " +
                                            "AND PR.screen_id = Sc.screen_id " +
                                            "AND start_date BETWEEN ?::timestamp AND ?::date " +
                                            "AND end_date BETWEEN ?::timestamp AND ?::date " +
                                            "AND screen_number=?;");
            pst.setString(1, dateStart);
            pst.setString(2, dateStart);
            pst.setString(3, dateEnd);
            pst.setString(4, dateEnd);
            pst.setInt(5, screen);
            rs = pst.executeQuery();
            if (rs.next()) return true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean searchShowtime(String dateStart, String dateEnd, String film_Title, int screen){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT * " +
                                            "FROM films F, provoles PR, screens Sc " +
                                            "WHERE F.film_id = PR.film_id " +
                                            "AND PR.screen_id = Sc.screen_id " +
                                            "AND start_date::timestamp = ? " +
                                            "AND end_date::timestamp = ? " +
                                            "AND title=?" +
                                            "AND screen_number=?;");
            pst.setString(1, dateStart);
            pst.setString(2, dateEnd);
            pst.setString(3, film_Title);
            pst.setInt(4, screen);
            rs = pst.executeQuery();
            if (rs.next()) return true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public int countShowtimesOfFilm(String film_Title){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        int counter = 0;
        try {
            pst = conn.prepareStatement("SELECT F.*, COUNT(PR.provoli_id) " +
                                            "FROM films F, provoles PR " +
                                            "WHERE F.film_id = PR.film_id " +
                                            "AND title=? " +
                                            "GROUP BY F.film_id;");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            while (rs.next()) {
                counter++;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return counter;
    }

    public boolean insertShowtime(int filmid, int screenid, String startdate, String enddate, String available) {
        int reservations = 0;
        boolean isavailable;
        if (available.equalsIgnoreCase("Yes")) {
            isavailable = true;
        }
        else isavailable = false;

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT setval('provoles_provoli_id_seq', max(provoli_id)) " +
                    "FROM provoles;");
            pst.executeQuery();
            pst = conn.prepareStatement("INSERT INTO provoles(film_id, screen_id, start_date, end_date, number_of_reservations, is_available) " +
            "VALUES ('" + filmid + "', '" + screenid + "', '" + startdate + "', '" + enddate + "', '" + reservations + "', '" + available + "')");
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateShowtime(int provoli_id, int filmid, int screenid, String startdate, String enddate, String available) {
        int reservations = 0;
        boolean isavailable;
        if (available.equalsIgnoreCase("Yes")) {
            isavailable = true;
        }
        else isavailable = false;

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT setval('provoles_provoli_id_seq', max(provoli_id)) " +
                                            "FROM provoles;");
            pst.executeQuery();
            pst = conn.prepareStatement("UPDATE provoles " +
                                            "SET film_id=?, screen_id=?, start_date='"+startdate+"', end_date='"+enddate+"', number_of_reservations=?, is_available=? " +
                                            "WHERE provoli_id=?");
            pst.setInt(1, filmid);
            pst.setInt(2, screenid);
            pst.setInt(3, 0);
            pst.setBoolean(4, isavailable);
            pst.setInt(5, provoli_id);

            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
