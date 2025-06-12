
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import com.nimbusds.jose.crypto.impl.AAD;
import com.nimbusds.oauth2.sdk.Role;
import com.nimbusds.openid.connect.sdk.assurance.claims.ISO3166_1Alpha2CountryCode;

import db.ConnectData;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.spi.DirStateFactory;
import models.Customers;
import models.Employees;
import models.Roles;
import models.Users;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class UserDao {

    private Connection conn = null;

    public UserDao() {
        conn = ConnectData.getConnection();
    }

    public static String md5(String input) {
        try {
            // Tạo đối tượng MessageDigest với thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            // Mã hóa chuỗi đầu vào
            byte[] messageDigest = md.digest(input.getBytes());

            // Chuyển đổi byte thành chuỗi hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0'); // Thêm 0 nếu cần
                }
                hexString.append(hex);
            }
            return hexString.toString(); // Trả về mã băm dưới dạng chuỗi
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int loginAdminForId(Users acc) {
        try {
            String sql = "Select * from Users where UserName=? and Password=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUserName());
            pst.setString(2, md5(acc.getPassword()));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("UserId");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Lỗi truy vấn đăng nhập", ex);
        }

        return 0;

    }

    public int getRoleById(int id) {
        int role = 0;
        try {
            String sql = "Select roleid from Users where UserId=? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                role = rs.getInt("RoleId");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return role;
    }

    public List<Users> getFullOfDashBoard(int page) {
        List<Users> listUser = new ArrayList<>();

        ResultSet rs = null;
        try {
            String sql = "SELECT  u.UserId,\n"
                    + "        UserName,\n"
                    + "        Email,\n"
                    + "        r.RoleName\n"
                    + "FROM    Users  AS u\n"
                    + "inner JOIN    Roles  AS r   ON u.RoleId = r.RoleId inner join Employees on Employees.UserID = u.UserId\n"
                    + "WHERE   u.UserId > 1\n"
                    + "ORDER BY u.UserName\n"
                    + "OFFSET  (?- 1) * 10 ROWS\n"
                    + "FETCH NEXT 10 ROWS ONLY";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                Roles role = new Roles();
                Employees employees = new Employees();
                user.setUserId(rs.getInt("UserId"));

                user.setUserName(rs.getString("UserName"));
                employees.setEmail(rs.getString("email"));
                user.setEmployees(employees);
                role.setRoleName(rs.getString("RoleName"));
                user.setRole(role);
                listUser.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUser;

    }

    public List<Users> getSearchOfDashBoard(int page, String name) {
        List<Users> listUser = new ArrayList<>();

        ResultSet rs = null;
        try {
            String sql = "SELECT  u.UserId,\n"
                    + "        u.UserName,\n"
                    + "    Email,\n"
                    + "        r.RoleName\n"
                    + "FROM    Users      AS u\n"
                    + "JOIN    Roles      AS r ON u.RoleId  = r.RoleId\n"
                    + "JOIN    Employees  AS e ON e.UserID  = u.UserId\n"
                    + "WHERE   u.UserId  > 1\n"
                    + "  AND   u.UserName LIKE ? \n"
                    + "ORDER BY u.UserName\n"
                    + "OFFSET  (? - 1) * 10 ROWS\n"
                    + "FETCH NEXT 10 ROWS ONLY";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            st.setInt(2, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                Roles role = new Roles();
                Employees employees = new Employees();
                user.setUserId(rs.getInt("UserId"));
                user.setUserName(rs.getString("UserName"));
                employees.setEmail(rs.getString("email"));
                user.setEmployees(employees);
                role.setRoleName(rs.getString("RoleName"));
                user.setRole(role);
                listUser.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUser;

    }

    public Users getUserById(int id) {
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT Username, FullName, Email,Phone, RoleName, StatusName,AvatarUrl \n"
                    + "                    FROM Users \n"
                    + "                INNER JOIN Roles ON Users.RoleId = Roles.RoleId \n"
                    + "             INNER JOIN AccountStatus ON AccountStatus.StatusId = Users.StatusId\n"
                    + "                INNER JOIN Employees ON EMpLOYEES.UserId = Users.UserId \n"
                    + "              WHERE Users.UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                Employees employees = new Employees();
                
                role.setRoleName(rs.getString("RoleName"));
                user.setUserName(rs.getString("Username"));
                employees.setFullName(rs.getString("FullName"));
                employees.setEmail(rs.getString("Email"));
                employees.setPhone(rs.getString("Phone"));
                user.setEmployees(employees);
                user.setRole(role);
                user.setAvatarUrl(rs.getString("AvatarUrl"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public Users getRoleUserById(int id) {
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT Users.UserId, FullName, RoleName \n"
                    + "                FROM Users \n"
                    + "               INNER JOIN Roles ON Users.RoleId = Roles.RoleId \n"
                    + "			   inner Join Employees on Employees.userId = Users.UserId\n"
                    + "                WHERE Users.UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                Employees employees = new Employees();
                role.setRoleName(rs.getString("RoleName"));
                employees.setFullName(rs.getString("FullName"));
                user.setEmployees(employees);
                user.setUserId(rs.getInt("UserId"));
                user.setRole(role);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public int UpdateRole(int RoleId, int UserId) {
        int cnt = 0;

        try {
            String sql = "Update Users set RoleId = ? where UserId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, RoleId);
            pst.setInt(2, UserId);
            cnt = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

}
