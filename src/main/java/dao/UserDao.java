
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.spi.DirStateFactory;
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

    public String md5(String input) {
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
            String sql = "	SELECT  \n"
                    + "		u.UserId,\n"
                    + "		UserName,\n"
                    + "         Status, \n"
                    + "		Email,\n"
                    + "		r.RoleName\n"
                    + "	FROM    \n"
                    + "		Users AS u\n"
                    + "	INNER JOIN    \n"
                    + "		Roles AS r ON u.RoleId = r.RoleId\n"
                    + "	WHERE   \n"
                    + "		u.UserId > 1\n"
                    + "	ORDER BY \n"
                    + "		u.UserName\n"
                    + "	OFFSET (?- 1) * 10 ROWS\n"
                    + "	FETCH NEXT 10 ROWS ONLY";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                Roles role = new Roles();
                user.setUserId(rs.getInt("UserId"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("email"));
                user.setStatus(rs.getString("Status"));
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

    public Users getUserById(int id) {
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT UserId, IdentityNumber,Username,FullName, Email, Phone, RoleName, Status, AvatarUrl , CreationDate FROM Users INNER JOIN Roles ON Users.RoleId = Roles.RoleId WHERE Users.UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                role.setRoleName(rs.getString("RoleName"));
                user.setUserName(rs.getString("Username"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getString("Status"));
                user.setIdentityNumber(rs.getString("IdentityNumber"));
                user.setPhone(rs.getString("Phone"));
                user.setAvatarUrl(rs.getString("AvatarUrl"));
        user.setUserId(rs.getInt("UserId"));
                user.setRole(role);
                user.setCreationDate(rs.getTimestamp("CreationDate").toLocalDateTime());
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
                    + "                WHERE Users.UserId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                Roles role = new Roles();
                role.setRoleName(rs.getString("RoleName"));
                user.setFullName(rs.getString("FullName"));
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
                Roles roles = new Roles();
                roles.setRoleName(rs.getString("RoleName"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setRole(roles);
                user.setStatus(rs.getString("Status"));
                user.setAvatarUrl(rs.getString("AvatarUrl"));
                listStaff.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listStaff;
    }

    public int UpdateStatusOnl(int UserId, int Status) {
        int cnt = 0;

        try {
            String sql = "Update Users set IsOnl = ? where UserId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, Status);
            pst.setInt(2, UserId);
            cnt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public int checkIsOnl() {
        ResultSet rs = null;
        Users user = new Users();
        try {
            String sql = "SELECT TOP 1 userId\n"
                    + "FROM Users\n"
                    + "WHERE isOnl = 1\n"
                    + "ORDER BY userId ASC";

            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("userId");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Users getUserByIdForProfile(int id) {
        Users u = null;
        String sql = "SELECT * FROM Users WHERE UserId = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    u = new Users();
                    u.setUserId(rs.getInt("UserId"));
                    u.setUserName(rs.getString("UserName"));
                    u.setFullName(rs.getString("FullName"));
                    u.setPhone(rs.getString("Phone"));
                    u.setEmail(rs.getString("Email"));
                    u.setAddress(rs.getString("Address"));
                    u.setAvatarUrl(rs.getString("AvatarUrl"));
                    u.setGender(rs.getString("Gender"));
                    u.setIdentityNumber(rs.getString("IdentityNumber"));
                    u.setStatus(rs.getString("Status"));
                    try {
                        u.setDayOfBirth(rs.getDate("DateOfBirth"));
                    } catch (SQLException e) {
                        u.setDayOfBirth(null); // fallback
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }

    public int updateUserProfileById(int id, Users staff) {
        int result = 0;
        try {
            String sql = "UPDATE Users SET Address = ?, FullName = ?, DateOfBirth = ?, Gender = ?, AvatarUrl = ? WHERE UserId = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, staff.getAddress());
            pst.setString(2, staff.getFullName());
            pst.setDate(3, staff.getDayOfBirth());
            pst.setString(4, staff.getGender());
            pst.setString(5, staff.getAvatarUrl());
            pst.setInt(6, id);
            result = pst.executeUpdate();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public Users getUserByIdForEdit(int id) {
        Users user = null;
        String sql = "SELECT UserName, FullName, Email, Phone, Status, AvatarUrl, Address, Gender, DateOfBirth, LastLogin "
                + "FROM Users WHERE UserId = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new Users();
                    user.setUserName(rs.getString("UserName"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setStatus(rs.getString("Status"));
                    user.setAvatarUrl(rs.getString("AvatarUrl"));
                    user.setAddress(rs.getString("Address")); // nullable
                    user.setGender(rs.getString("Gender"));   // nullable
                    user.setDayOfBirth(rs.getDate("DateOfBirth")); // nullable
                    Timestamp ts = rs.getTimestamp("LastLogin");
                    if (ts != null) {
                        user.setLastLogin(ts.toLocalDateTime());
                    } else {
                        user.setLastLogin(null);
                    }
                    return user;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int updateUserById(Users user) {
        int cnt = 0;

        try {
            String sql = "UPDATE Users \n"
                    + "SET IdentityNumber = ?, \n"
                    + "    FullName = ?, \n"
                    + "    Email = ?, \n"
                    + "    Phone = ? \n"
                    + "WHERE UserId = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user.getIdentityNumber());
            pst.setString(2, user.getFullName());
            pst.setString(3, user.getEmail());
            pst.setString(4, user.getPhone());
            pst.setInt(5, user.getUserId());
            cnt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }
    public int createStaff(Users newUser) {
        int check = 0;
        String sql = "INSERT INTO Users (UserName, Password, Email, IdentityNumber, Phone, RoleId, "
                + "CreationDate, Gender, Status, AvatarUrl) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newUser.getUserName());
            ps.setString(2, newUser.getPassword());
            ps.setString(3, newUser.getEmail());
            ps.setString(4, newUser.getIdentityNumber());
            ps.setString(5, newUser.getPhone());
            ps.setInt(6, newUser.getRoleId());
            ps.setTimestamp(7, Timestamp.valueOf(newUser.getCreationDate())); // LocalDateTime -> Timestamp
            ps.setString(8, newUser.getGender());
            ps.setString(9, newUser.getStatus());
            ps.setString(10, newUser.getAvatarUrl());

            check = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return check;
    }

    public boolean isUserNameExists(String userName) {
        String sql = "SELECT 1 FROM Users WHERE UserName = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT 1 FROM Users WHERE Email = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isIdentityNumberExists(String identityNumber) {
        String sql = "SELECT 1 FROM Users WHERE IdentityNumber = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, identityNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStaff(int userId, String status) {
        String sql = "UPDATE Users SET Status = ? WHERE UserId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
