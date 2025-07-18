/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package models;

import java.time.LocalDateTime;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class Invoices {
    private int invoiceId;
    private int bookingId;
    private LocalDateTime datetime; // ngay tao hoa don
    private Long roomTotal; // tong tien cua phong khi chua apply voucher
    private Long serviceTotal; // tong so services order
    private Long discount; // so tien duoc giam
    private Long totalAmount; // tong tien sau cung
    private boolean status; // status cua hoa don
    
    private Rooms rooms;
    private Bookings booking;
    private Vouchers vouchers;
    private Payments payments;
    private Customers customer;

    public Invoices() {
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public LocalDateTime getDatetime() {
        return datetime;
    }

    public void setDatetime(LocalDateTime datetime) {
        this.datetime = datetime;
    }

    public Long getRoomTotal() {
        return roomTotal;
    }

    public void setRoomTotal(Long roomTotal) {
        this.roomTotal = roomTotal;
    }

    public Long getServiceTotal() {
        return serviceTotal;
    }

    public void setServiceTotal(Long serviceTotal) {
        this.serviceTotal = serviceTotal;
    }

    public Long getDiscount() {
        return discount;
    }

    public void setDiscount(Long discount) {
        this.discount = discount;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Rooms getRooms() {
        return rooms;
    }

    public void setRooms(Rooms rooms) {
        this.rooms = rooms;
    }

    public Bookings getBooking() {
        return booking;
    }

    public void setBooking(Bookings booking) {
        this.booking = booking;
    }

    public Vouchers getVouchers() {
        return vouchers;
    }

    public void setVouchers(Vouchers vouchers) {
        this.vouchers = vouchers;
    }

    public Payments getPayments() {
        return payments;
    }

    public void setPayments(Payments payments) {
        this.payments = payments;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
    }
    
    
}
