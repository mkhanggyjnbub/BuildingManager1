/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Amenities;
import models.Customers;
import models.RoomReviews;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class RoomDao {

    private Connection conn = null;

    public RoomDao() {
        conn = ConnectData.getConnection();
    }

    public int getCountRooms() {
        int totalRoom = 0;
        String sql = "select count(*) as TotalRooms from Rooms";
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                totalRoom = rs.getInt("TotalRooms");
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalRoom;
    }

    public int getCountRoomsSearch(String location, LocalDate checkIn, LocalDate checkOut, int people) {
        ResultSet rs = null;
        int totalRoom = 0;
        try {

            String sql = "SELECT \n"
                    + "    count(*) as TotalRooms\n"
                    + "FROM Rooms R\n"
                    + "JOIN Buildings B ON R.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND R.Status  =N'Còn trống'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "   AND B.Status IN (N'Ðã nhận phòng', N'Ðã xác nhận', N'Chờ xử lý')\n"
                    + ")";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, people);
            st.setString(2, location);
            st.setDate(3, Date.valueOf(checkOut));
            st.setDate(4, Date.valueOf(checkIn));
            rs = st.executeQuery();
            if (rs.next()) {
                totalRoom = rs.getInt("TotalRooms");
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalRoom;
    }

    public List<Rooms> getFullRooms(int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();

        try {
            String sql = "select  RoomId,RoomType,Price,Description, ImageUrl from Rooms order by RoomId offset ? Rows Fetch NEXT 6 Rows Only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                list.add(room);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public List<Rooms> getSearchRooms(String location, LocalDate checkIn, LocalDate checkOut, int people, int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl\n"
                    + "FROM Rooms R\n"
                    + "JOIN Buildings B ON R.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND R.Status  =N'Còn trống'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "  AND  B.Status IN (N'Đã đặt', N'Đang sử dụng', N'Bảo trì', N'Ngưng hoạt động')\n"
                    + ")   order by RoomId offset ? Rows Fetch NEXT 6 Rows Only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, people);
            st.setString(2, location);
            st.setDate(3, Date.valueOf(checkOut));
            st.setDate(4, Date.valueOf(checkIn));
            st.setInt(5, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                list.add(room);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public Rooms getRoomDetail(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl\n"
                    + "FROM Rooms R\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    public int getNumberOfReview(int id) {
        ResultSet rs = null;
        int numberOfReview = 0;
        try {
            String sql = "SELECT \n"
                    + " Count(	RR.Comment) as Total  \n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                numberOfReview = rs.getInt("Total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return numberOfReview;

    }

    public float getTotalRating(int id, int numberOfReview) {
        ResultSet rs = null;
        float totalRating = 0;
        try {
            String sql = "SELECT \n"
                    + "	Sum(RR.Rating) as Total \n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                totalRating = rs.getInt("Total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return (float) totalRating / numberOfReview;

    }

    public List<Amenities> getAmenities(int id) {
        ResultSet rs = null;
        List<Amenities> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "	A.Name\n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomAmenities RA on RA.RoomId = R.RoomId\n"
                    + "Inner JOIN Amenities A on A.AmenityId = RA.AmenityId\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                Amenities amenities = new Amenities();
                amenities.setName(rs.getString("Name"));
                list.add(amenities);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public List<RoomReviews> getCustomerReviews(int id) {
        ResultSet rs = null;
        List<RoomReviews> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "	C.AvatarUrl,\n"
                    + "	C.UserName,\n"
                    + "	RR.Comment,\n"
                    + "	RR.Rating,\n"
                    + "	RR.CreatedAt\n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?\n"
                    + "Order by ReviewId desc";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                RoomReviews roomreview = new RoomReviews();
                roomreview.setComment(rs.getString("Comment"));
                roomreview.setRating(rs.getInt("Rating"));
                roomreview.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                Customers customer = new Customers();
                customer.setAvatarUrl(rs.getString("AvatarUrl"));
                customer.setUserName(rs.getString("UserName"));
                roomreview.setCustomer(customer);
                list.add(roomreview);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void clearRoomCustomerInfo(int roomId) throws SQLException {
        String sql = "UPDATE Rooms SET Status = 0 WHERE RoomId = ?";
        try ( Connection conn = ConnectData.getConnection();  
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomId);
            stmt.executeUpdate();
        }

        }
        public Rooms getInformationRoomBooking(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "select RoomId,RoomNumber,RoomType,Price,ImageUrl,BedType from Rooms where RoomId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setBedType(rs.getString("BedType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }
}
