/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import com.nimbusds.oauth2.sdk.Role;
import java.sql.Date;
import java.time.LocalDateTime;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Users {

    private int userId;
    private String userName;
    private String password;
    private String avatarUrl;
    private Date lastLogin;
    private int roleId;
    private int status;
    private Roles role;
    private LocalDateTime CreationDate;
    private Employees employees;
    private AccountStatus accountStatus;

    public Users() {
    }

    public Users(int userId, String userName, String password, String avatarUrl, Date lastLogin, int roleId, int status, Roles role, LocalDateTime CreationDate, Employees employees, AccountStatus accountStatus) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.avatarUrl = avatarUrl;
        this.lastLogin = lastLogin;
        this.roleId = roleId;
        this.status = status;
        this.role = role;
        this.CreationDate = CreationDate;
        this.employees = employees;
        this.accountStatus = accountStatus;
    }

    public Employees getEmployees() {
        return employees;
    }

    public void setEmployees(Employees employees) {
        this.employees = employees;
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

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
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

    public LocalDateTime getCreationDate() {
        return CreationDate;
    }

    public void setCreationDate(LocalDateTime CreationDate) {
        this.CreationDate = CreationDate;
    }

    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(AccountStatus accountStatus) {
        this.accountStatus = accountStatus;
    }

  
   
    

}
