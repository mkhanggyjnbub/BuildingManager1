package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

    public List<Bookings> getAllBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed')";

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
       
        return list;
    }

    public List<Bookings> getAllBookingsKhanh() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('checked In', 'Confirmed','checked Out')";

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
        
        return list;
    }

    public void confirmBooking(int bookingId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, confirmedBy);
            ps.setInt(3, bookingId);
            ps.executeUpdate();
        }
    }

    public void cancelBooking(int bookingId, String notes, int canceledBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = ?, CancelTime = ?, CanceledBy = ?, Notes = ? WHERE BookingId = ?";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {

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
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();

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
//Khang 

//    public int insertBookingBeforePayment(int customerId, LocalDate startDate, LocalDate endDate, String roomType) {
//        try {
//            String sql = "INSERT INTO Bookings(CustomerId, StartDate, EndDate, roomType, Status) "
//                    + "VALUES (?, ?, ?, ?, 'pending payment')";
//
//            PreparedStatement pst = conn.prepareStatement(sql);
//            pst.setInt(1, customerId);
//            pst.setDate(2, java.sql.Date.valueOf(startDate));
//            pst.setDate(3, java.sql.Date.valueOf(endDate));
//            pst.setString(4, roomType);
//
//            return pst.executeUpdate();
//
//        } catch (SQLException ex) {
//            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
public int insertBookingBeforePayment(int customerId, LocalDate startDate, LocalDate endDate, String roomType) {
    int bookingId = -1;

    try {
        String sql = "INSERT INTO Bookings(CustomerId, StartDate, EndDate, roomType, Status) "
                   + "VALUES (?, ?, ?, ?, 'pending payment')";

        // Sử dụng RETURN_GENERATED_KEYS
        PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pst.setInt(1, customerId);
        pst.setDate(2, java.sql.Date.valueOf(startDate));
        pst.setDate(3, java.sql.Date.valueOf(endDate));
        pst.setString(4, roomType);

        int affectedRows = pst.executeUpdate();

        if (affectedRows > 0) {
            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                bookingId = rs.getInt(1); // Lấy BookingId vừa tạo
            }
            rs.close();
        }

        pst.close();
        // KHÔNG đóng conn ở đây nếu bạn còn dùng tiếp

    } catch (SQLException ex) {
        Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
    }

    return bookingId;
}

    public int getBookingId(int customerId, LocalDate startDate, LocalDate endDate, String roomType) {
        String sql = "SELECT TOP 1 BookingId FROM Bookings "
                + "WHERE CustomerId = ? AND StartDate = ? AND EndDate = ? AND RoomType = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, customerId);
            pst.setTimestamp(2, Timestamp.valueOf(startDate.atStartOfDay()));
            pst.setTimestamp(3, Timestamp.valueOf(endDate.atStartOfDay()));
            pst.setString(4, roomType);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("BookingId");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return 0;
    }

//    public int insertInvoiceBeforePayment(int bookingId, long roomPriceTotal,
//            long discount, long totalAmount, long paidAmount, String status) {
//        try {
//            String sql = "INSERT INTO Invoices (BookingId, InvoiceDate, RoomPriceTotal, Discount, TotalAmount, PaidAmount,Status) "
//                    + "VALUES (?, ?, ?, ?, ?, ?,  'pending')";
//
//            PreparedStatement pst = conn.prepareStatement(sql);
//
//            // Set giá trị cho từng cột
//            pst.setInt(1, bookingId);
//            pst.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
//            pst.setLong(3, roomPriceTotal);
//            pst.setLong(4, discount);
//            pst.setLong(5, totalAmount);
//            pst.setLong(6, paidAmount);
//
//            return pst.executeUpdate();
//
//        } catch (SQLException ex) {
//            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
    public int insertInvoiceBeforePayment(int bookingId, long roomPriceTotal,
            long discount, long totalAmount, long paidAmount, String status) {
        int invoiceId = -1;

        try {
            String sql = "INSERT INTO Invoices (BookingId, InvoiceDate, RoomPriceTotal, Discount, TotalAmount, PaidAmount, Status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, 'pending')";

            PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set giá trị cho từng cột
            pst.setInt(1, bookingId);
            Timestamp now = Timestamp.valueOf(LocalDateTime.now());
            pst.setTimestamp(2, now);
            pst.setLong(3, roomPriceTotal);
            pst.setLong(4, discount);
            pst.setLong(5, totalAmount);
            pst.setLong(6, paidAmount);

            int rows = pst.executeUpdate();

            if (rows > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    invoiceId = rs.getInt(1); // hoặc rs.getInt("InvoiceId") nếu tên cột được trả về
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return invoiceId;
    }

    public int updateInvoiceStatus(int invoiceId, String status) {
        try {
            String sql = "UPDATE Invoices SET Status = ? WHERE InvoiceId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setInt(2, invoiceId);

            return pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int insertPayment(int invoiceId, long amount, String method, String status, String type) {
        try {
            String sql = "INSERT INTO Payments (InvoiceId, Amount, PaymentMethod, PaymentStatus, PaymentDate, PaymentType) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(sql);

            pst.setInt(1, invoiceId);
            pst.setLong(2, amount);
            pst.setString(3, method);
            pst.setString(4, status);
            pst.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            pst.setString(6, type);

            return pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    //Đóng code của khang
}
