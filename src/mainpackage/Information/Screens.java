package mainpackage.Information;

import mainpackage.Utils.Connect_Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Screens {
    private int screenId;
    private boolean screenIs3D;
    private int screenNumberOfSeats;
    private int screenNumber;

    public Screens(){}

    public Screens(int screenId, boolean screenIs3D, int screenNumberOfSeats, int screenNumber) {
        this.screenId = screenId;
        this.screenIs3D = screenIs3D;
        this.screenNumberOfSeats = screenNumberOfSeats;
        this.screenNumber = screenNumber;
    }

    //  Get/Set for screenId
    public int getScreenId(int screen_number) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT screen_id " +
                                            "FROM screens " +
                                            "WHERE screen_number=?");
            pst.setInt(1, screen_number);
            rs = pst.executeQuery();
            if (rs.next()) {
                screenId = rs.getInt("screen_id");
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return screenId;
    }
    //  Get/Set for screenId
    public int getScreenNumberWithProvoliID(int provoli_id) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT Sc.screen_number " +
                                            "FROM screens Sc, provoles PR " +
                                            "WHERE provoli_id=? " +
                                            "AND PR.screen_id = Sc.screen_id");
            pst.setInt(1, provoli_id);
            rs = pst.executeQuery();
            if (rs.next()) {
                screenNumber = rs.getInt("screen_number");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return screenNumber;
    }

    //  Get/Set for screenIs3D
    public boolean getScreenIs3D(String screen_id) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT is_3d " +
                                            "FROM screens " +
                                            "WHERE screen_id=?");
            pst.setString(1, screen_id);
            rs = pst.executeQuery();
            if (rs.next()) {
                screenIs3D = rs.getBoolean("is_3d");
            }
            else {
                return false;
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return screenIs3D;
    }

    //  Get/Set for screenNumberOfSeats
    public int getScreenNumberOfSeats(String screen_id) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT number_of_seats " +
                                            "FROM screens " +
                                            "WHERE screen_id=?");
            pst.setString(1, screen_id);
            rs = pst.executeQuery();
            if (rs.next()) {
                screenNumberOfSeats = rs.getInt("number_of_seats");
            }
            else {
                pst.close();
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return screenNumberOfSeats;
    }

    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }
    public void setScreenIs3D(boolean screenIs3D) {
        this.screenIs3D = screenIs3D;
    }
    public void setscreenNumberOfSeats(int screenNumberOfSeats) {
        this.screenNumberOfSeats = screenNumberOfSeats;
    }
}
