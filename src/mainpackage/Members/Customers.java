package mainpackage.Members;

import mainpackage.Utils.Connect_Database;
import mainpackage.Information.Films;
import mainpackage.Information.Provoles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Customers {
    Films films = new Films();
    Provoles provoles = new Provoles();

    public Customers(){ }

    public ArrayList showAvailableFilms(){
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        ArrayList availableFilms = new ArrayList();
        try {
            pst = conn.prepareStatement("SELECT DISTINCT PR.film_id " +
                                            "FROM films F, provoles PR " +
                                            "WHERE PR.film_id = F.film_id " +
                                            "AND is_available=true");
            rs = pst.executeQuery();
            while (rs.next()) {
                availableFilms.add(rs.getInt("PR.film_id"));
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return null;
        }
        return availableFilms;
    }

    public boolean makeReservation(int _user_id, int _provoli_id, int reserved_seats, double transaction) {
        try {
            transaction = reserved_seats * 08.00;
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("INSERT INTO transactions(user_id, provoli_id, reserved_seats, transaction) VALUES ('"+_user_id+"', '"+_provoli_id+"', '"+reserved_seats+"', '"+transaction+"')");
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList viewReservationsOfUser(String _username) {
        ArrayList currentReservations = new ArrayList();
        int _user_id;

        try {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conn = Connect_Database.getConnection();
            pst = conn.prepareStatement("SELECT user_id " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                _user_id = rs.getInt("user_id");
            }
            else {
                pst.close();
                return null;
            }
            pst = conn.prepareStatement("SELECT user_id " +
                                            "FROM transactions " +
                                            "WHERE user_id=?");
            pst.setInt(1, _user_id);
            rs = pst.executeQuery();
            while (rs.next()) {
                currentReservations.add(rs.getInt("user_id"));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return currentReservations;
    }
}
