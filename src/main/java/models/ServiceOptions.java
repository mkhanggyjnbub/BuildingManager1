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
public class ServiceOptions {
    private int ServiceDetailId;
    private int ServiceId;
    private BigDecimal Weight;
    private BigDecimal UnitPrice;
    private Timestamp PickupTime;
    private Timestamp DeliveryTime;
    private Timestamp ScheduledTime;
    private String CleanerName;
    private int Duration;
    private String TherapistName;
    private String ServiceType;
    private String Notes;

    public ServiceOptions() {
    }

    public ServiceOptions(int ServiceDetailId, int ServiceId, BigDecimal Weight, BigDecimal UnitPrice, Timestamp PickupTime, Timestamp DeliveryTime, Timestamp ScheduledTime, String CleanerName, int Duration, String TherapistName, String ServiceType, String Notes) {
        this.ServiceDetailId = ServiceDetailId;
        this.ServiceId = ServiceId;
        this.Weight = Weight;
        this.UnitPrice = UnitPrice;
        this.PickupTime = PickupTime;
        this.DeliveryTime = DeliveryTime;
        this.ScheduledTime = ScheduledTime;
        this.CleanerName = CleanerName;
        this.Duration = Duration;
        this.TherapistName = TherapistName;
        this.ServiceType = ServiceType;
        this.Notes = Notes;
    }

    public int getServiceDetailId() {
        return ServiceDetailId;
    }

    public void setServiceDetailId(int ServiceDetailId) {
        this.ServiceDetailId = ServiceDetailId;
    }

    public int getServiceId() {
        return ServiceId;
    }

    public void setServiceId(int ServiceId) {
        this.ServiceId = ServiceId;
    }

    public BigDecimal getWeight() {
        return Weight;
    }

    public void setWeight(BigDecimal Weight) {
        this.Weight = Weight;
    }

    public BigDecimal getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(BigDecimal UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    public Timestamp getPickupTime() {
        return PickupTime;
    }

    public void setPickupTime(Timestamp PickupTime) {
        this.PickupTime = PickupTime;
    }

    public Timestamp getDeliveryTime() {
        return DeliveryTime;
    }

    public void setDeliveryTime(Timestamp DeliveryTime) {
        this.DeliveryTime = DeliveryTime;
    }

    public Timestamp getScheduledTime() {
        return ScheduledTime;
    }

    public void setScheduledTime(Timestamp ScheduledTime) {
        this.ScheduledTime = ScheduledTime;
    }

    public String getCleanerName() {
        return CleanerName;
    }

    public void setCleanerName(String CleanerName) {
        this.CleanerName = CleanerName;
    }

    public int getDuration() {
        return Duration;
    }

    public void setDuration(int Duration) {
        this.Duration = Duration;
    }

    public String getTherapistName() {
        return TherapistName;
    }

    public void setTherapistName(String TherapistName) {
        this.TherapistName = TherapistName;
    }

    public String getServiceType() {
        return ServiceType;
    }

    public void setServiceType(String ServiceType) {
        this.ServiceType = ServiceType;
    }

    public String getNotes() {
        return Notes;
    }

    public void setNotes(String Notes) {
        this.Notes = Notes;
    }
    
    
}
