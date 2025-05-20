/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Customers {
    private int CustomerID;
    private String  UserName;
    private String  Password;
    private String  FullName;
    private String  Phone;
    private String  Email;
    private String  Address;
    private String  Gender;
    private Date  DateOfBirth;
    private int  StatusId;
    private String  AvatarUrl;
    private LocalDateTime  CreationDate;
    private LocalDateTime  LastLogin;

    public Customers() {
    }

    public Customers(int CustomerID, String UserName, String Password, String FullName, String Phone, String Email, String Address, String Gender, Date DateOfBirth, int StatusId, String AvatarUrl, LocalDateTime CreationDate, LocalDateTime LastLogin) {
        this.CustomerID = CustomerID;
        this.UserName = UserName;
        this.Password = Password;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Email = Email;
        this.Address = Address;
        this.Gender = Gender;
        this.DateOfBirth = DateOfBirth;
        this.StatusId = StatusId;
        this.AvatarUrl = AvatarUrl;
        this.CreationDate = CreationDate;
        this.LastLogin = LastLogin;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public Date getDateOfBirth() {
        return DateOfBirth;
    }

    public void setDateOfBirth(Date DateOfBirth) {
        this.DateOfBirth = DateOfBirth;
    }

    public int getStatusId() {
        return StatusId;
    }

    public void setStatusId(int StatusId) {
        this.StatusId = StatusId;
    }

    public String getAvatarUrl() {
        return AvatarUrl;
    }

    public void setAvatarUrl(String AvatarUrl) {
        this.AvatarUrl = AvatarUrl;
    }

    public LocalDateTime getCreationDate() {
        return CreationDate;
    }

    public void setCreationDate(LocalDateTime CreationDate) {
        this.CreationDate = CreationDate;
    }

    public LocalDateTime getLastLogin() {
        return LastLogin;
    }

    public void setLastLogin(LocalDateTime LastLogin) {
        this.LastLogin = LastLogin;
    }
  
}
