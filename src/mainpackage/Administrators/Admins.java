package mainpackage.Administrators;

import mainpackage.Utils.Connect_Database;
import mainpackage.Utils.Encryption;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Admins  {
    public boolean createUser(String username, String password, String full_name, String email, String telephone, String usertype) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        if (telephone == "" || telephone == null) {
            try {
                pst = conn.prepareStatement("SELECT setval('users_user_id_seq', max(user_id)) " +
                                                "FROM users;");
                pst.executeQuery();
                pst = conn.prepareStatement("INSERT INTO users(username, password, full_name, email, is_online, usertype) VALUES ('"+username+"', '"+Encryption.hashPassword(password)+"', '"+full_name+"', '"+email+"', '"+false+"', '"+usertype+"')");
                int i = pst.executeUpdate();
                return i > 0;
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
        else {
            try {
                pst = conn.prepareStatement("SELECT setval('users_user_id_seq', max(user_id)) " +
                                                "FROM users;");
                pst.executeQuery();
                pst = conn.prepareStatement("INSERT INTO users(username, password, full_name, email,  telephone, is_online, usertype) VALUES ('"+username+"', '"+Encryption.hashPassword(password)+"', '"+full_name+"', '"+email+"', '"+telephone+"', '"+false+"', '"+usertype+"')");
                int i = pst.executeUpdate();
                return i > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean updateUser(String username, String password, String full_name, String email, String telephone, String usertype) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            if (password == ""){
                pst = conn.prepareStatement("UPDATE users " +
                                "SET username=?, full_name=?, email=?, telephone=?, usertype=? " +
                                "WHERE username=?");
                pst.setString(1, username);
                pst.setString(2, full_name);
                pst.setString(3, email);
                pst.setString(4, telephone);
                pst.setString(5, usertype);

                pst.setString(6, username);
            }
            else {
                pst = conn.prepareStatement("UPDATE users " +
                                "SET username=?, password=?, full_name=?, email=?, telephone=?, usertype=? " +
                                "WHERE username=?");
                pst.setString(1, username);
                pst.setString(2, password);
                pst.setString(3, full_name);
                pst.setString(4, email);
                pst.setString(5, telephone);
                pst.setString(6, usertype);
                pst.setString(7, username);
            }
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(String username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("DELETE " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, username);
            int i = pst.executeUpdate();
            return i > 0;
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList getUserInfo(String username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ArrayList userInfo = new ArrayList();
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT full_name " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, username);
            rs = pst.executeQuery();
            if (rs.next()) {
                userInfo.add(username);
                userInfo.add(rs.getString("full_name"));
                userInfo.add(rs.getInt("email"));
                userInfo.add(rs.getInt("telephone"));
                userInfo.add(rs.getInt("usertype"));
                return userInfo;
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return null;
    }

    //Anazitisi an yparxei to username
    public boolean searchUsername(String username) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT username " +
                                            "FROM users " +
                                            "WHERE username=?");
            pst.setString(1, username);
            rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //Anazitisi an yparxei to email
    public boolean searchEmail(String _email) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        try {
            pst = conn.prepareStatement("SELECT email " +
                                            "FROM users " +
                                            "WHERE email=?");
            pst.setString(1, _email);
            rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList viewAllUsers() {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        ArrayList allUsers = new ArrayList();
        try {
            pst = conn.prepareStatement("SELECT username " +
                                            "FROM users ");
            rs = pst.executeQuery();
            while (rs.next()) {
                allUsers.add(rs.getString("username"));
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return allUsers;
    }

    public ArrayList viewUsers() {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        ArrayList users = new ArrayList();
        try {
            pst = conn.prepareStatement("SELECT username " +
                                            "FROM users " +
                                            "WHERE usertype='User'");
            rs = pst.executeQuery();
            while (rs.next()) {
                users.add(rs.getString("username"));
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return users;
    }
    public ArrayList viewContentAdmins() {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        conn = Connect_Database.getConnection();
        ArrayList contentAdmins = new ArrayList();
        try {
            pst = conn.prepareStatement("SELECT username " +
                                            "FROM users " +
                                            "WHERE usertype='Content Administrator'");
            rs = pst.executeQuery();
            while (rs.next()) {
                contentAdmins.add(rs.getString("username"));
            }
        }
        catch (Exception e) {
            System.out.println("Something went wrong!");
            e.printStackTrace();
        }
        return contentAdmins;
    }
}
