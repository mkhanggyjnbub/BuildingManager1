package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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
                + "WHERE b.Status IN ( 'Confirmed', 'Checked In','Checked Out')";

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

    public List<Bookings> getAllCheckInBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, b.CheckInTime, b.UserId "
                + "FROM Bookings b WHERE b.Status = 'CheckedIn'";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));
            booking.setRoomId(rs.getInt("RoomId"));
            booking.setCustomerId(rs.getInt("CustomerId"));
            booking.setUserId(rs.getInt("UserId"));
            booking.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
            booking.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
            booking.setStatus(rs.getString("Status"));
            booking.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());

            list.add(booking);
        }

        rs.close();
        ps.close();
        conn.close();
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

    //Khoa
    public List<Bookings> getAllBookingsActive() {
        String sql = "SELECT * FROM Bookings b \n"
                + "inner join Rooms r on r.RoomId = b.RoomId\n"
                + "WHERE b.Status = 'Checked in' AND CheckInTime IS NOT NULL";
        List<Bookings> list = new ArrayList<>();
        try {
            Connection conn = ConnectData.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("BookingId"));
                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                b.setRooms(r);
                b.setCustomerId(rs.getInt("CustomerID"));
                b.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                b.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (list.isEmpty()) {
            System.out.println("list dang rong");
            return null;
        } else {
            System.out.println("list dang khong rong");
            System.out.println(list);
        }
        return list;
    }

    public Bookings getNextBookingByRoom(int roomId, LocalDateTime currentEndDate, int bookingId) {
        String sql = "SELECT TOP 1 * FROM Bookings\n"
                + "        WHERE RoomId = ? AND StartDate > (\n"
                + "            SELECT \n"
                + "                CASE \n"
                + "                    WHEN MAX(EndTime) IS NOT NULL AND MAX(EndTime) > ? \n"
                + "                    THEN MAX(EndTime) \n"
                + "                    ELSE ? \n"
                + "                END\n"
                + "            FROM ExtraCharge\n"
                + "            WHERE BookingId = ?\n"
                + "        )\n"
                + "        ORDER BY StartDate ASC";
        Bookings nextBooking = null;

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            Timestamp currentEndTimestamp = Timestamp.valueOf(currentEndDate);

            ps.setInt(1, roomId);
            ps.setTimestamp(2, currentEndTimestamp); // used in MAX check
            ps.setTimestamp(3, currentEndTimestamp); // fallback if no ExtraCharge
            ps.setInt(4, bookingId); // filter by BookingId in ExtraCharge

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                nextBooking = new Bookings();
                nextBooking.setBookingId(rs.getInt("BookingId"));
                nextBooking.setRoomId(rs.getInt("RoomId"));
                nextBooking.setCustomerId(rs.getInt("CustomerID"));
                nextBooking.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                nextBooking.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                nextBooking.setStatus(rs.getString("Status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (nextBooking == null) {
            System.out.println("Không có booking kế tiếp cho phòng " + roomId);
        } else {
            System.out.println("Booking kế tiếp: " + nextBooking.getBookingId());
        }

        return nextBooking;
    }

    public List<Bookings> getBookingHistoryByCustomerId(int customerId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT\n"
                + "    b.BookingId, b.RoomId, r.RoomNumber, r.ImageUrl,\n"
                + "    b.CustomerId, b.StartDate, b.EndDate, b.Notes, r.RoomType,\n"
                + "    b.Status,\n"
                + "    MAX(e.EndTime) AS ExtendedEndDate\n"
                + "FROM Bookings b\n"
                + "INNER JOIN Rooms r ON r.RoomId = b.RoomId\n"
                + "LEFT JOIN ExtraCharge e \n"
                + "    ON e.BookingId = b.BookingId\n"
                + "   AND e.ChargeType IN ('Late Hour', 'Extra Hour', 'Extra Day') -- ✅ chuyển điều kiện vào JOIN\n"
                + "WHERE b.CustomerId = ?\n"
                + "GROUP BY b.BookingId, b.RoomId, r.RoomNumber, r.ImageUrl,\n"
                + "         b.CustomerId, b.StartDate, b.EndDate, b.Notes,\n"
                + "         r.RoomType, b.Status\n"
                + "ORDER BY b.StartDate DESC;";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("BookingId"));
                b.setRoomId(rs.getInt("RoomId"));

                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                r.setImageUrl(rs.getString("ImageUrl"));
                r.setRoomType(rs.getString("RoomType"));
                b.setRooms(r);

                b.setCustomerId(rs.getInt("CustomerId"));
                b.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                b.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                b.setNotes(rs.getString("Notes"));
                b.setStatus(rs.getString("Status"));

                Timestamp extendedEnd = rs.getTimestamp("ExtendedEndDate");
                if (extendedEnd != null) {
                    b.setEndDate(extendedEnd.toLocalDateTime()); //thoi gian mo rong - chi de hien thi
                } else {
                    b.setEndDate(b.getEndDate());
                }
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("CustomerId: " + customerId);
        System.out.println("Bookings: " + list.size());

        return list;
    }

    public int cancelBookingById(int bookingId) {
        String sql = "UPDATE Bookings SET Status = 'Canceled' WHERE BookingId = ?";
        int check = 0;

        try ( PreparedStatement ps = conn.prepareStatement(sql) ) {

            ps.setInt(1, bookingId);
            check = ps.executeUpdate(); // trả về số bản ghi bị ảnh hưởng

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return check;
    }

}
