package mainpackage.Members;

import mainpackage.Utils.Connect_Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Users {
    private int userId;
    private String full_name;
    private String username;
    private String email;
    private String telephone;
    private String password;
    private boolean is_online;
    private String usertype;

    public Users(){}

    public Users(int userId, String full_name, String username, String email, String telephone, String password, boolean is_online, String usertype) {
        this.userId = userId;
        this.full_name = full_name;
        this.username = username;
        this.email = email;
        this.telephone = telephone;
        this.password = password;
        this.is_online = is_online;
        this.usertype = usertype;
    }

    public int getUserId(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT user_id " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("user_id");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    //  Get gia full name xristi
    public String getFullName(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT full_name " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                full_name = rs.getString("full_name");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return full_name;
    }

    //  Get for full name xristi
    public String getEmail(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT email " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return email;
    }

    //  Get for username
    public String getUsername(int _user_id) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT username " +
                                            "FROM users " +
                                            "WHERE user_id=?");
            pst.setInt(1, _user_id);
            rs = pst.executeQuery();
            if (rs.next()) {
                username = rs.getString("username");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return username;
    }

    //  Get for password
    public String getPassword(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT password " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                password = rs.getString("password");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return password;
    }

    //  Get for online status
    public boolean getOnlineStatus(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT is_online " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                is_online = rs.getBoolean("is_online");
            }
            else return false;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return is_online;
    }

    //  Get for telephone
    public String getTelephone(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT telephone " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                telephone = rs.getString("telephone");
                if (telephone == null) {
                    telephone = "";
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return telephone;
    }

    //  Get for telephone
    public String getUsertype(String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT usertype " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, _username);
            rs = pst.executeQuery();
            if (rs.next()) {
                usertype = rs.getString("usertype");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return usertype;
    }

    // Set gia full name xristi
    public void setFullName(int _userId, String _full_name) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET full_name=? " +
                                            "WHERE user_id=?");
            pst.setString(1, _full_name);
            pst.setInt(2, _userId);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.full_name = _full_name;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setUsername(int _userId, String _username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET username=? " +
                                            "WHERE user_id=?");
            pst.setString(1, _username);
            pst.setInt(2, _userId);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.username = _username;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Set gia email xristi
    public void setEmail(int _userId, String _email) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET email=? " +
                                            "WHERE user_id=?");
            pst.setString(1, _email);
            pst.setInt(2, _userId);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.email = _email;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Set gia tilefono xristi
    public void setTelephone(int _userId, String _telephone) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET telephone=? " +
                                            "WHERE user_id=?");
            pst.setString(1, _telephone);
            pst.setInt(2, _userId);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.telephone = _telephone;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPassword(int _user_id, String _newPassword) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();

        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET password=? " +
                                            "WHERE user_id=?");
            pst.setString(1, _newPassword);
            pst.setInt(2, _user_id);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.userId = _user_id;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean setOnlineStatus(String _username, boolean status) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("UPDATE users " +
                                            "SET is_online=? " +
                                            "WHERE username=?");
            pst.setBoolean(1, status);
            pst.setString(2, _username);
            int i = pst.executeUpdate();
            if (i > 0) {
                this.is_online = status;
                return true;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
