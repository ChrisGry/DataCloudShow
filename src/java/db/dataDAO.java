/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author gry
 */
public class dataDAO {
    
    public static void insertData(data d) throws SQLException
    {
        Connection conn=dbUtil.getConnection();
        
        String sql="INSERT INTO data(datetime,deviceid,devicename,slaveaddr,slaveindex,id,value) VALUES(now(),?,?,?,?,?,?);";
//        System.out.println("Connection: "+conn);
        PreparedStatement ps=(PreparedStatement) conn.prepareStatement(sql);
        ps.setString(1,d.getDeviceId());
        ps.setString(2,d.getDeviceName());
        ps.setString(3,d.getSlaveAddr());
        ps.setString(4,d.getSlaveIndex());
        ps.setString(5,d.getId());
        ps.setDouble(6,d.getValue());
        ps.execute();
        
    }
    
     public static List<data> selectAll() throws SQLException
    {
        List<data> resultList=new ArrayList<data>();
        
        Connection conn=dbUtil.getConnection();
	String sql=" SELECT * FROM data ORDER BY datetime DESC;";
	Statement sm=(Statement) conn.createStatement();
	ResultSet rs=sm.executeQuery(sql);
        
	while(rs.next())
	{
            data d=new data();
            d.setDatetime(rs.getString("datetime"));
            d.setDeviceId(rs.getString("deviceid"));
            d.setDeviceName(rs.getString("devicename"));
            d.setSlaveAddr(rs.getString("slaveaddr"));
            d.setSlaveIndex(rs.getString("slaveindex"));
            d.setId(rs.getString("id"));
            d.setValue(rs.getDouble("value"));
            resultList.add(d);
	}
        
	return resultList;
        
    }
     
      public static List<data> selectAll2() throws SQLException
    {
        List<data> resultList=new ArrayList<data>();
        
        Connection conn=dbUtil.getConnection();
	String sql=" SELECT * FROM data ORDER BY datetime ASC;";
	Statement sm=(Statement) conn.createStatement();
	ResultSet rs=sm.executeQuery(sql);
        
	while(rs.next())
	{
            data d=new data();
            d.setDatetime(rs.getString("datetime"));
            d.setDeviceId(rs.getString("deviceid"));
            d.setDeviceName(rs.getString("devicename"));
            d.setSlaveAddr(rs.getString("slaveaddr"));
            d.setSlaveIndex(rs.getString("slaveindex"));
            d.setId(rs.getString("id"));
            d.setValue(rs.getDouble("value"));
            resultList.add(d);
	}
        
	return resultList;
        
    }
      
     public static List<data> select1000() throws SQLException
    {
        List<data> resultList=new ArrayList<data>();
        
        Connection conn=dbUtil.getConnection();
	String sql=" SELECT * FROM data ORDER BY datetime DESC;";
	Statement sm=(Statement) conn.createStatement();
	ResultSet rs=sm.executeQuery(sql);
        
        int count=0;
        
	while(rs.next()&&count<1000)
	{
            data d=new data();
            d.setDatetime(rs.getString("datetime"));
            d.setDeviceId(rs.getString("deviceid"));
            d.setDeviceName(rs.getString("devicename"));
            d.setSlaveAddr(rs.getString("slaveaddr"));
            d.setSlaveIndex(rs.getString("slaveindex"));
            d.setId(rs.getString("id"));
            d.setValue(rs.getDouble("value"));
            resultList.add(d);
            count++;
	}
        
	return resultList;
        
    }
     
      public static data selectLast1() throws SQLException
    {
        data d=new data();
        
        Connection conn=dbUtil.getConnection();
	String sql=" SELECT * FROM data ORDER BY datetime DESC;";
	Statement sm=(Statement) conn.createStatement();
	ResultSet rs=sm.executeQuery(sql);
       
	if(rs.next())
        {
            d.setDatetime(rs.getString("datetime"));
            d.setDeviceId(rs.getString("deviceid"));
            d.setDeviceName(rs.getString("devicename"));
            d.setSlaveAddr(rs.getString("slaveaddr"));
            d.setSlaveIndex(rs.getString("slaveindex"));
            d.setId(rs.getString("id"));
            d.setValue(rs.getDouble("value"));
	}
        
	return d;
        
    }
    
}
