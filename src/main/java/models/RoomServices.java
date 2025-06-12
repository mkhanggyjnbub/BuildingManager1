/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class RoomServices {

    private int roomServiceId;
    private int roomId;
    private int serviceId;
    private String status;

    public RoomServices() {
    }

    public RoomServices(int roomServiceId, int roomId, int serviceId, String status) {
        this.roomServiceId = roomServiceId;
        this.roomId = roomId;
        this.serviceId = serviceId;
        this.status = status;
    }

    public int getRoomServiceId() {
        return roomServiceId;
    }

    public void setRoomServiceId(int roomServiceId) {
        this.roomServiceId = roomServiceId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
