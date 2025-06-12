/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class Services {
    private int ServiceId;
    private String ServiceName;
    private String Description;
    private BigDecimal TotalPrice;
    private Timestamp StartTime;
    private Timestamp EndTime;
    private Timestamp CreatedAt;
    private String Status;

    private ServiceOptions serviceOptions;
    
    public Services() {
    }

    public Services(int ServiceId, String ServiceName, String Description, BigDecimal TotalPrice, Timestamp StartTime, Timestamp EndTime, Timestamp CreatedAt, String Status, ServiceOptions serviceOptions) {
        this.ServiceId = ServiceId;
        this.ServiceName = ServiceName;
        this.Description = Description;
        this.TotalPrice = TotalPrice;
        this.StartTime = StartTime;
        this.EndTime = EndTime;
        this.CreatedAt = CreatedAt;
        this.Status = Status;
        this.serviceOptions = serviceOptions;
    }

    public ServiceOptions getServiceOptions() {
        return serviceOptions;
    }

    public void setServiceOptions(ServiceOptions serviceOptions) {
        this.serviceOptions = serviceOptions;
    }
    
    public int getServiceId() {
        return ServiceId;
    }

    public void setServiceId(int ServiceId) {
        this.ServiceId = ServiceId;
    }

    public String getServiceName() {
        return ServiceName;
    }

    public void setServiceName(String ServiceName) {
        this.ServiceName = ServiceName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public BigDecimal getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(BigDecimal TotalPrice) {
        this.TotalPrice = TotalPrice;
    }

    public Timestamp getStartTime() {
        return StartTime;
    }

    public void setStartTime(Timestamp StartTime) {
        this.StartTime = StartTime;
    }

    public Timestamp getEndTime() {
        return EndTime;
    }

    public void setEndTime(Timestamp EndTime) {
        this.EndTime = EndTime;
    }

    public Timestamp getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Timestamp CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }
}
