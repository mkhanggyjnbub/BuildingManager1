/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.time.LocalDateTime;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Bookings {

    private int bookingId;
    private int roomId;
    private int customerId;
    private int ConfirmedBy;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private String status;
    private Rooms rooms;
    private Customers customers;
    private LocalDateTime RequestTime;
    private LocalDateTime ConfirmationTime;
    private LocalDateTime CheckInTime;
    private LocalDateTime CheckOutTime;
    private LocalDateTime CancelTime;
    private int CanceledBy;
    private LocalDateTime DeletedTime;
    private String DeletedBy;
    private String Notes;
    private int userId;
    private String formattedStartDate;
    private String formattedEndDate;
private String roomType;
    public Bookings() {

    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCanceledBy() {
        return CanceledBy;
    }

    public void setCanceledBy(int CanceledBy) {
        this.CanceledBy = CanceledBy;
    }

    public LocalDateTime getRequestTime() {
        return RequestTime;
    }

    public void setRequestTime(LocalDateTime RequestTime) {
        this.RequestTime = RequestTime;
    }

    public LocalDateTime getConfirmationTime() {
        return ConfirmationTime;
    }

    public void setConfirmationTime(LocalDateTime ConfirmationTime) {
        this.ConfirmationTime = ConfirmationTime;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public LocalDateTime getCheckInTime() {
        return CheckInTime;
    }

    public void setCheckInTime(LocalDateTime CheckInTime) {
        this.CheckInTime = CheckInTime;
    }

    public LocalDateTime getCheckOutTime() {
        return CheckOutTime;
    }

    public void setCheckOutTime(LocalDateTime CheckOutTime) {
        this.CheckOutTime = CheckOutTime;
    }

    public LocalDateTime getCancelTime() {
        return CancelTime;
    }

    public void setCancelTime(LocalDateTime CancelTime) {
        this.CancelTime = CancelTime;
    }

    public LocalDateTime getDeletedTime() {
        return DeletedTime;
    }

    public void setDeletedTime(LocalDateTime DeletedTime) {
        this.DeletedTime = DeletedTime;
    }

    public String getDeletedBy() {
        return DeletedBy;
    }

    public void setDeletedBy(String DeletedBy) {
        this.DeletedBy = DeletedBy;
    }

    public String getNotes() {
        return Notes;
    }

    public void setNotes(String Notes) {
        this.Notes = Notes;
    }

    public Rooms getRooms() {
        return rooms;
    }

    public void setRooms(Rooms rooms) {
        this.rooms = rooms;
    }

    public Customers getCustomers() {
        return customers;
    }

    public void setCustomers(Customers customers) {
        this.customers = customers;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getConfirmedBy() {
        return ConfirmedBy;
    }

    public void setConfirmedBy(int ConfirmedBy) {
        this.ConfirmedBy = ConfirmedBy;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public String getFormattedStartDate() {
        return formattedStartDate;
    }

    public void setFormattedStartDate(String formattedStartDate) {
        this.formattedStartDate = formattedStartDate;
    }

    public String getFormattedEndDate() {
        return formattedEndDate;
    }

    public void setFormattedEndDate(String formattedEndDate) {
        this.formattedEndDate = formattedEndDate;
    }

    public String getFullName() {
        return customers != null ? customers.getFullName() : null;
    }

    public String getEmail() {
        return customers != null ? customers.getEmail() : null;
    }
}
