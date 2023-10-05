package mainpackage.Information;

import mainpackage.Utils.Connect_Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Provoles {
    private int provoliID;
    private String provoliFilm;
    private int provoliCinema;
    private String provoliStartDate;
    private String provoliEndDate;
    private int provoliNumberOfReservations;
    private boolean provoliIsAvailable;

    public Provoles(){}

    public Provoles(int provoliID, String provoliFilm, int provoliCinema, String provoliStartDate, String provoliEndDate, int provoliNumberOfReservations, boolean provoliIsAvailable) {
        this.provoliID = provoliID;
        this.provoliFilm = provoliFilm;
        this.provoliCinema = provoliCinema;
        this.provoliStartDate = provoliStartDate;
        this.provoliEndDate = provoliEndDate;
        this.provoliNumberOfReservations = provoliNumberOfReservations;
        this.provoliIsAvailable = provoliIsAvailable;
    }

    //  Get for provoliID
    public int getProvoliID(String film_Title) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT PR.provoli_id " +
                    "FROM provoles PR, films F " +
                    "WHERE PR.provoli_id = F.film_id " +
                    "AND title=?");
            pst.setString(1, film_Title);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliID = rs.getInt("provoli_id");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return 0;
        }
        return provoliID;
    }
    public void setProvoliID(int provoliID) {
        this.provoliID = provoliID;
    }

    //  Get for provoliFilm
    public String getProvoliFilm(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT F.title " +
                                            "FROM provoles PR, films F " +
                                            "WHERE PR.provoli_id = F.film_id " +
                                            "AND provoli_id=?");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliFilm = rs.getString("title");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return null;
        }
        return provoliFilm;
    }
    public void setProvoliFilm(String provoliFilm) {
        this.provoliFilm = provoliFilm;
    }

    //  Get for provoliCinema
    public int getProvoliCinema(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT SC.screen_number " +
                                            "FROM provoles PR, screens SC " +
                                            "WHERE PR.screen_id = SC.screen_id " +
                                            "AND provoli_id=?");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliCinema = rs.getInt("screen_number");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
            return -1;
        }
        return provoliCinema;
    }
    public void setProvoliCinema(int provoliCinema) {
        this.provoliCinema = provoliCinema;
    }

    //  Get for provoliStartDate
    public String getProvoliStartDate(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT start_date " +
                                            "FROM provoles " +
                                            "WHERE provoli_id=?");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliStartDate = rs.getString("start_date");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return provoliStartDate;
    }
    public void setProvoliStartDate(String provoliStartDate) {
        this.provoliStartDate = provoliStartDate;
    }

    //  Get/Set for provoliEndDate
    public String getProvoliEndDate(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT end_date " +
                    "FROM provoles " +
                    "WHERE provoli_id=?");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliEndDate = rs.getString("end_date");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return provoliEndDate;
    }
    public void setProvoliEndDate(String provoliEndDate) {
        this.provoliEndDate = provoliEndDate;
    }

    //  Get/Set for provoliNumberOfReservations
    public int getProvoliNumberOfReservations(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT number_of_reservations " +
                    "FROM provoles " +
                    "WHERE provoli_id=?");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                provoliNumberOfReservations = rs.getInt("number_of_reservations");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
        return provoliNumberOfReservations;
    }
    public void setProvoliNumberOfReservations(int provoliNumberOfReservations) {
        this.provoliNumberOfReservations = provoliNumberOfReservations;
    }

    //  Get/Set for provoliIsAvailable
    public boolean getProvoliIsAvailable(int _provoliID) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT number_of_reservations " +
                    "FROM provoles " +
                    "WHERE provoli_id=? AND is_available=true");
            pst.setInt(1, _provoliID);
            rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
            else return false;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void setProvoliIsAvailable(boolean provoliIsAvailable) {
        this.provoliIsAvailable = provoliIsAvailable;
    }
}
