
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

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
import models.AccountStatus;
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

    public int loginForId(Users acc) {
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

        return -1;

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
<<<<<<< HEAD

=======
>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
    public List<Users> getFullOfDashBoard(int page) {
        List<Users> listUser = new ArrayList<>();

        ResultSet rs = null;
        try {
            String sql = "select UserId, Username,Email,Rolename \n"
                    + "FROM Users  inner join Roles on Users.RoleId = Roles.RoleId\n"
                    + "WHERE   UserId  >1  \n"
                    + "ORDER BY UserName  \n"
                    + "OFFSET (? - 1)*10 ROWS FETCH NEXT 10 ROWS ONLY; ";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                Roles role = new Roles();
                user.setUserId(rs.getInt("UserId"));

                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("email"));
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
            String sql = "select UserId, Username,Email,Rolename \n"
                    + "FROM Users  inner join Roles on Users.RoleId = Roles.RoleId\n"
                    + "WHERE   UserId  >1 and UserName LIKE ?  \n"
                    + "ORDER BY UserName  \n"
                    + "OFFSET (? - 1)*10 ROWS FETCH NEXT 10 ROWS ONLY; ";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            st.setInt(2, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                Roles role = new Roles();
                user.setUserId(rs.getInt("UserId"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("email"));
                role.setRoleName(rs.getString("RoleName"));
                user.setRole(role);
                listUser.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUser;

    }

<<<<<<< HEAD
=======


>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
    public Users getUserById(int id) {
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT Username, FullName, Email,Phone, RoleName, StatusName, AvatarUrl "
                    + "FROM Users "
                    + "INNER JOIN Roles ON Users.RoleId = Roles.RoleId "
                    + "INNER JOIN AccountStatus ON AccountStatus.StatusId = Users.StatusId "
                    + "WHERE UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                AccountStatus accountStatus = new AccountStatus();
                accountStatus.setStatusName(rs.getString("StatusName"));
                role.setRoleName(rs.getString("RoleName"));
                user.setUserName(rs.getString("Username"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAccountStatus(accountStatus);
                user.setRole(role);
                user.setAvatarUrl(rs.getString("AvatarUrl"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
<<<<<<< HEAD

    public Users getRoleUserById(int id) {
=======
    
    
     public Users getRoleUserById(int id) {
>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT UserId, FullName, RoleName "
                    + "FROM Users "
                    + "INNER JOIN Roles ON Users.RoleId = Roles.RoleId "
                    + "WHERE UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                role.setRoleName(rs.getString("RoleName"));
                user.setFullName(rs.getString("FullName"));
                user.setUserId(rs.getInt("UserId"));
                user.setRole(role);
<<<<<<< HEAD
            }
=======
          }
>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

<<<<<<< HEAD
=======

>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
    public int UpdateRole(int RoleId, int UserId) {
        int cnt = 0;

        try {
            String sql = "Update Users set RoleId = ? where UserId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, RoleId);
            pst.setInt(2, UserId);
            cnt = pst.executeUpdate();
<<<<<<< HEAD

=======
              
>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

<<<<<<< HEAD
    public int UpdateInfomationById(int id, Users user) {
        int cnt = 0;
        try {
            String sql = "Update Users set Phone=?, FullName=? where UserId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user.getPhone());
            pst.setString(2, user.getFullName());
            pst.setInt(3, id);
            cnt = pst.executeUpdate();
        } catch (Exception e) {
        }
        return cnt;
    }

    public List<Users> GetAllStaff() {
        List<Users> listStaff = new ArrayList<>();
        String sql = "SELECT Username, FullName, Email, Phone, RoleName, StatusName, AvatarUrl "
                + "FROM Users "
                + "INNER JOIN Roles ON Users.RoleId = Roles.RoleId "
                + "INNER JOIN AccountStatus ON AccountStatus.StatusId = Users.StatusId "
                + "WHERE RoleName IN (?, ?, ?)";

        try ( Connection conn = db.ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Quản lý");
            ps.setString(2, "Lễ tân");
            ps.setString(3, "Nhân viên");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                AccountStatus accountStatus = new AccountStatus();
                accountStatus.setStatusName(rs.getString("StatusName"));
                Roles roles = new Roles();
                roles.setRoleName(rs.getString("RoleName"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setRoles(roles);
                user.setAccountStatus(accountStatus);
                user.setAvatarUrl(rs.getString("AvatarUrl"));
                listStaff.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listStaff;
    }
=======
   
>>>>>>> 38f31009fab4d97f8c5093cf65233883ffc34ef1

}
