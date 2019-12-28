/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

/**
 *
 * @author gry
 */
public class data {
    
    private String datetime="";
    private String deviceId="";
    private String deviceName="";
    private String slaveAddr="";
    private String slaveIndex="";
    private String id="";
    private double value=0;

    /**
     * @return the datetime
     */
    public String getDatetime() {
        return datetime;
    }

    /**
     * @param datetime the datetime to set
     */
    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    /**
     * @return the deviceId
     */
    public String getDeviceId() {
        return deviceId;
    }

    /**
     * @param deviceId the deviceId to set
     */
    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    /**
     * @return the deviceName
     */
    public String getDeviceName() {
        return deviceName;
    }

    /**
     * @param deviceName the deviceName to set
     */
    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    /**
     * @return the slaveAddr
     */
    public String getSlaveAddr() {
        return slaveAddr;
    }

    /**
     * @param slaveAddr the slaveAddr to set
     */
    public void setSlaveAddr(String slaveAddr) {
        this.slaveAddr = slaveAddr;
    }

    /**
     * @return the slaveIndex
     */
    public String getSlaveIndex() {
        return slaveIndex;
    }

    /**
     * @param slaveIndex the slaveIndex to set
     */
    public void setSlaveIndex(String slaveIndex) {
        this.slaveIndex = slaveIndex;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the value
     */
    public double getValue() {
        return value;
    }

    /**
     * @param value the value to set
     */
    public void setValue(double value) {
        this.value = value;
    }
    
    
    
}
