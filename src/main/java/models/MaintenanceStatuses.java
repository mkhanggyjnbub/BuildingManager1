/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author KHANH
 */
public class MaintenanceStatuses {
    private int statusID;
    private String statusName;

    public MaintenanceStatuses(int statusID, String statusName) {
        this.statusID = statusID;
        this.statusName = statusName;
    }

    public MaintenanceStatuses() {
    }

    
    
    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
    
}


