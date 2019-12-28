package db;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.mysql.jdbc.*;
import java.sql.Connection;
 

public class dbUtil {

    private static final String URL="jdbc:mysql://localhost:3306/datacloudtest?serverTimezone=GMT";
    private static final String USER="root";
    private static final String PASSWORD="";
    private static Connection conn=null;
	static
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=(Connection)DriverManager.getConnection(URL,USER,PASSWORD);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public static Connection getConnection()
	{
		return conn;
	}
}
