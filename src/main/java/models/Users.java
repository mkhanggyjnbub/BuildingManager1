/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Users {

    private int userId;
    private String userName;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String avatarUrl;
    private Date last_Login;
    private int roleId;
    private int status;
    private Roles role;
    private AccountStatus accountStatus;

    public Users() {
    }

    public Users(int userId, String userName, String password, String fullName, String email, String phone, String avatarUrl, Date last_Login, int roleId, int status, Roles role, AccountStatus accountStatus) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.avatarUrl = avatarUrl;
        this.last_Login = last_Login;
        this.roleId = roleId;
        this.status = status;
        this.role = role;
        this.accountStatus = accountStatus;
    }

   
    

    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(AccountStatus accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

   

    

    

    public Date getLast_Login() {
        return last_Login;
    }

    public void setLast_Login(Date last_Login) {
        this.last_Login = last_Login;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Roles getRole() {
        return role;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

}
