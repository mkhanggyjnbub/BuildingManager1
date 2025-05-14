/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class AccountStatus {

    private int StatusId;
    private String StatusName;

    public AccountStatus() {
    }

    public AccountStatus(int StatusId, String StatusName) {
        this.StatusId = StatusId;
        this.StatusName = StatusName;
    }

    public int getStatusId() {
        return StatusId;
    }

    public void setStatusId(int StatusId) {
        this.StatusId = StatusId;
    }

    public String getStatusName() {
        return StatusName;
    }

    public void setStatusName(String StatusName) {
        this.StatusName = StatusName;
    }

}
