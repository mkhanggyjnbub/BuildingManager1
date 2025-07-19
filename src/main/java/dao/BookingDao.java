package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import models.Bookings;
import models.Customers;
import models.Rooms;

public class BookingDao {

    private Connection conn = null;

    public BookingDao() {
        conn = ConnectData.getConnection();
    }

    public List<Bookings> getAllBookingsKhanh() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT \n"
                + "    b.BookingId, \n"
                + "    b.RoomId, \n"
                + "    b.CustomerId, \n"
                + "    b.StartDate, \n"
                + "    b.EndDate, \n"
                + "    b.Status, \n"
                + "    b.RoomType, \n"
                + "    c.FullName\n"
                + "FROM \n"
                + "    Bookings b\n"
                + "Full JOIN \n"
                + "    Customers c ON b.CustomerId = c.CustomerId\n"
                + "WHERE \n"
                + "    b.Status IN ('Checked in', 'Confirmed', 'Checked out')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            Timestamp startTs = rs.getTimestamp("StartDate");
            if (startTs != null) {
                LocalDateTime startDate = startTs.toLocalDateTime();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            Timestamp endTs = rs.getTimestamp("EndDate");
            if (endTs != null) {
                LocalDateTime endDate = endTs.toLocalDateTime();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            int roomId = rs.getInt("RoomId");
            if (rs.wasNull()) {
                booking.setRooms(null);
            } else {
                Rooms room = new Rooms();
                room.setRoomId(roomId);
//                room.setRoomNumber(rs.getString("RoomNumber"));
                booking.setRooms(room);

            }
                                booking.setRoomType(rs.getString("RoomType")); 

            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }
        rs.close();
        ps.close();
        conn.close();
        return list;
    }

    public List<Bookings> getAllBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN (Waiting for processing', 'Confirmed')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            // Đọc StartDate dạng Timestamp và convert sang LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            Timestamp startTs = rs.getTimestamp("StartDate");
            if (startTs != null) {
                LocalDateTime startDate = startTs.toLocalDateTime();
                booking.setStartDate(startDate); // nếu vẫn cần giữ LocalDateTime
                booking.setFormattedStartDate(startDate.format(formatter)); // chuỗi đã format
            }

            Timestamp endTs = rs.getTimestamp("EndDate");
            if (endTs != null) {
                LocalDateTime endDate = endTs.toLocalDateTime();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            Rooms room = new Rooms();

            room.setRoomNumber(rs.getString("RoomNumber"));
            booking.setRooms(room);

            Customers name = new Customers();
            name.setFullName(rs.getString("FullName"));
            booking.setCustomers(name);

            list.add(booking);
        }
        rs.close();
        ps.close();
        conn.close();
        return list;
    }

    public int confirmBooking(int bookingId, int confirmedBy) throws SQLException {
        int check = 0;
        String sql = "UPDATE Bookings SET Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, confirmedBy);
            ps.setInt(3, bookingId);
            check = ps.executeUpdate();
        }
        return check;
    }

    public void cancelBooking(int bookingId, String notes, int canceledBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = ?, CancelTime = ?, CanceledBy = ?, Notes = ? WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Canceled");
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, canceledBy);
            ps.setString(4, notes);
            ps.setInt(5, bookingId);
            ps.executeUpdate();

        }
    }

    public int updateBookingStatus(int bookingId, String status) {
        int cnt = 0;
        try {
            Connection conn = ConnectData.getConnection();
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();
            ps.close();
            conn.close();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public void deleteBooking(int bookingId) throws SQLException {
        String sql = "DELETE FROM Bookings WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        }
    }

//     Thêm dữ liệu mới vào Bookings
    public void insertBooking(Bookings booking) throws SQLException {
        String sql = "INSERT INTO Bookings (RoomId, CustomerID, UserId, StartDate, EndDate, Status, Notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getCustomerId());
            ps.setInt(3, booking.getUserId());
            ps.setTimestamp(4, Timestamp.valueOf(booking.getStartDate()));
            ps.setTimestamp(5, Timestamp.valueOf(booking.getEndDate()));
            ps.setString(6, booking.getStatus());
            ps.setString(7, booking.getNotes());

            ps.executeUpdate();
        }
    }

    public List<Bookings> searchBookings(String roomNumber, String fullName, String startDateStr, String endDateStr, String status) throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        StringBuilder sql = new StringBuilder(
                "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed') "
        );

        List<Object> params = new ArrayList<>();

        if (roomNumber != null && !roomNumber.trim().isEmpty()) {
            sql.append("AND r.RoomNumber LIKE ? ");
            params.add("%" + roomNumber.trim() + "%");
        }

        if (fullName != null && !fullName.trim().isEmpty()) {
            sql.append("AND c.FullName LIKE ? ");
            params.add("%" + fullName.trim() + "%");
        }

        if (startDateStr != null && !startDateStr.trim().isEmpty()) {
            sql.append("AND CONVERT(varchar, b.StartDate, 23) LIKE ? ");
            params.add(startDateStr.trim() + "%");
        }

        if (endDateStr != null && !endDateStr.trim().isEmpty()) {
            sql.append("AND CONVERT(varchar, b.EndDate, 23) LIKE ? ");
            params.add(endDateStr.trim() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND b.Status = ? ");
            params.add(status.trim());
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));
            booking.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
            booking.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
            booking.setStatus(rs.getString("Status"));

            Rooms room = new Rooms();
            room.setRoomNumber(rs.getString("RoomNumber"));
            booking.setRooms(room);

            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }

        return list;
    }

    public int updateBookingStatusAndcheckInt(int bookingId, String status) {
        int cnt = 0;
        try {
            Connection conn = ConnectData.getConnection();
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();
            ps.close();
            conn.close();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public Bookings getCheckInCheckOutDetails(int id) {
        Bookings booked = new Bookings();

        try {
            Connection conn = ConnectData.getConnection();

            String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.UserId, b.StartDate, b.EndDate, "
                    + "b.Status, b.CheckInTime, b.CheckOutTime, b.ConfirmationTime, "
                    + "c.FullName, c.Email, c.Phone, r.RoomNumber "
                    + "FROM Bookings b "
                    + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                    + "JOIN Rooms r ON b.RoomId = r.RoomId "
                    + "WHERE b.BookingId =? ";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));
                booking.setRoomId(rs.getInt("RoomId"));
                booking.setCustomerId(rs.getInt("CustomerId"));
                booking.setUserId(rs.getInt("UserId"));
                booking.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                booking.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                booking.setStatus(rs.getString("Status"));
                booking.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                booking.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());
                booking.setConfirmationTime(rs.getTimestamp("ConfirmationTime").toLocalDateTime());

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));
                booking.setCustomers(customer);

                Rooms room = new Rooms();
                room.setRoomNumber(rs.getString("RoomNumber"));
                booking.setRooms(room);

            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return booked;

    }
//<<<<<<< HEAD
//     public Bookings getBookingById(int id) {
//        Bookings b = null;
//        String sql = "SELECT b.BookingID, b.Status, b.StartDate, b.EndDate, b.CheckInTime, b.CheckOutTime, " +
//               
//                "r.RoomNumber, c.FullName, c.Email, c.Phone " +
//                     "FROM Bookings b " +
//                     "JOIN Rooms r ON b.RoomID = r.RoomID " +
//                     "JOIN Customers c ON b.CustomerID = c.CustomerID " +
//                     "WHERE b.BookingID = ?";
//=======
//>>>>>>> 370bb7c8c639a75ba05f4d93eca96f78b62245a0

    public Bookings getBookingById(int id) {
        Bookings b = null;
        String sql = "SELECT b.BookingID, b.Status, b.StartDate, b.EndDate, b.CheckInTime, b.CheckOutTime, "
                + "r.RoomNumber, c.FullName, c.Email, c.Phone "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomID = r.RoomID "
                + "JOIN Customers c ON b.CustomerID = c.CustomerID "
                + "WHERE b.BookingID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                b = new Bookings();
                b.setBookingId(rs.getInt("BookingID"));
                b.setStatus(rs.getString("Status"));
                b.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                b.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                b.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                b.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());

                // Room
                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                b.setRooms(r);

                // Customer
                Customers c = new Customers();
                c.setFullName(rs.getString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                b.setCustomers(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }

    //vinh   
    public Bookings getBookingInfo(int bookingId) throws SQLException {
        String sql
                = "SELECT b.BookingId, b.StartDate, b.EndDate, "
                + "       c.FullName, c.Email "
                + "FROM Bookings b "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings info = new Bookings();
                info.setBookingId(rs.getInt("BookingId"));
                info.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                info.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
//                info.setFullName(rs.getString("FullName"));
//                info.setEmail(rs.getString("Email"));

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                info.setCustomers(customer);

                return info;
            }
        }

        return null;
    }
//vinh

    public String getBookingStatus(int bookingId) throws SQLException {
        String sql
                = "SELECT Status FROM Bookings WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("Status");
            }
        }

        return null; // Không tìm thấy booking
    }

    public Bookings getBookingCheckInInfo(int bookingId) {
        Bookings booking = null;

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(
                "SELECT "
                + "    b.BookingId, "
                + "    b.CustomerId, "
                + "    b.StartDate, "
                + "    b.EndDate, "
                + "    b.RoomType, "
                + "    c.FullName "
                + "FROM Bookings b "
                + "INNER JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?")) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));
                booking.setCustomerId(rs.getInt("CustomerId"));

                // Nếu model Bookings của bạn đang xài String cho ngày thì dùng getString
                Timestamp startTimestamp = rs.getTimestamp("StartDate");
                booking.setStartDate(startTimestamp.toLocalDateTime());
                Timestamp endTimestamp = rs.getTimestamp("EndDate");
                booking.setEndDate(endTimestamp.toLocalDateTime());

                booking.setRoomType(rs.getString("RoomType"));

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                booking.setCustomers(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booking;
    }

    public boolean updateCheckInStatus(int bookingId, String status, int actualGuests, String cccd, int assignedRoomId, LocalDateTime checkInTime) {
        String sql = "UPDATE Bookings SET Status = ?, NumberOfGuests = ?, CCCD = ?, RoomId = ?, CheckInTime = ? WHERE BookingId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, actualGuests);
            ps.setString(3, cccd);
            ps.setInt(4, assignedRoomId);
            ps.setTimestamp(5, Timestamp.valueOf(checkInTime));
            ps.setInt(6, bookingId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public Bookings getBookingBasicInfoById(int bookingId) {
        Bookings booking = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConnectData.getConnection();
            String sql = "SELECT "
                    + "    b.BookingId, "
                    + "    c.FullName AS CustomerName, "
                    + "    r.RoomType, "
                    + "    b.StartDate, "
                    + "    b.EndDate "
                    + "FROM Bookings b "
                    + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                    + "JOIN Rooms r ON b.RoomId = r.RoomId "
                    + "WHERE b.BookingId = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));

                Customers customer = new Customers();
                customer.setFullName(rs.getString("CustomerName"));
                booking.setCustomers(customer);

                Rooms room = new Rooms();
                room.setRoomType(rs.getString("RoomType"));
                booking.setRooms(room);

                booking.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                booking.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return booking;
    }

    public int checkRoomIdExists(Integer roomId) {
        int result = 0;
        String sql = "SELECT RoomId FROM Bookings WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getObject("RoomId") != null) {
                result = 1;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    //khanh
    public void updateRoomForBooking(int bookingId, int roomId, int actualGuests) throws SQLException {
        String sql = "UPDATE Bookings SET RoomId = ?, ActualGuests = ? WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ps.setInt(2, actualGuests);
            ps.setInt(3, bookingId);

            ps.executeUpdate();
        }
    }

    public void insertRoomIdForBookingK(int bookingId, int roomId, LocalDateTime checkInTime) {
        Connection conn = ConnectData.getConnection();
        try {
            String sql = "UPDATE Bookings SET RoomId = ?, CheckInTime = ?, Status = 'Checked in' WHERE BookingId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, roomId);
            ps.setTimestamp(2, Timestamp.valueOf(checkInTime));
            ps.setInt(3, bookingId);

            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
//code của khanh
     public int confirmBookingNotByRoomId(int bookingId, int confirmedBy) {
        int check = 0;
        try {
            
            String sql = "UPDATE Bookings SET Status = 'Checked in', CheckInTime = ?, CheckInBy = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, confirmedBy);
            ps.setInt(3, bookingId);    
            check = ps.executeUpdate();
            return check;
        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

     
     public int saveGuestInfos(int bookingId, List<String> fullNames, List<String> cccds) {
    int totalInserted = 0;
    String sql = "INSERT INTO GuestInfo (BookingId, FullName, CCCD) VALUES (?, ?, ?)";

    try (Connection conn = ConnectData.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        for (int i = 0; i < fullNames.size(); i++) {
            ps.setInt(1, bookingId);
            ps.setString(2, fullNames.get(i));
            ps.setString(3, cccds.get(i));
            totalInserted += ps.executeUpdate();
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return totalInserted;
}
    





     
    // đóng code của khanh
   
}
