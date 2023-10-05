package mainpackage.Utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class Connect_Database {
    static Connection con = null;
    public static Connection getConnection()
    {
        if (con != null) return con;
        return getConnection("ergasia-movie-theaters", "postgres", "");
    }
    private static Connection getConnection(String db_name,String user_name,String password)
    {
        try
        {
            Class.forName("org.postgresql.Driver");
            con= DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+db_name+"?user="+user_name+"&password="+password);
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL driver is not in classpath");
        }
        catch (Exception e) {
            e.printStackTrace();
            System.out.println("Cannot connect to database!");
        }

        return con;
    }
}
