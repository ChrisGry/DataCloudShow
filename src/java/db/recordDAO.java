/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import com.mysql.jdbc.*;
import java.sql.*;
import java.util.*;

/**
 *
 * @author gry
 */
public class recordDAO {
    
    public static void insertRecord(record r) throws SQLException
    {
        Connection conn=dbUtil.getConnection();
        
        String sql="INSERT INTO record(rdatetime,rdata,rdatatype,rdeviceid) VALUES(now(),?,?,?);";
//        System.out.println("Connection: "+conn);
        PreparedStatement ps=(PreparedStatement) conn.prepareStatement(sql);
        ps.setString(1,r.getData());
        ps.setInt(2,r.getDataType());
        ps.setString(3,r.getDeviceId());
        ps.execute();
        
    }
    
    public static List<record> selectAll() throws SQLException
    {
        List<record> resultList=new ArrayList<record>();
        
        Connection conn=dbUtil.getConnection();
	String sql=" SELECT * FROM record WHERE rdatatype!=0 ORDER BY rdatetime DESC;";
	Statement sm=(Statement) conn.createStatement();
	ResultSet rs=sm.executeQuery(sql);
        
	while(rs.next())
	{
            record r=new record();
            r.setDatetime(rs.getString("rdatetime"));
            r.setData(rs.getString("rdata"));
            r.setDataType(rs.getInt("rdatatype"));
            r.setDeviceId(rs.getString("rdeviceid"));
            resultList.add(r);
	}
        
	return resultList;
        
    }
        
}
