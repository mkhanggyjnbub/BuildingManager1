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

    // Kiều Hoàng Mạnh Khang
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
                    + "AND R.Status  =N'Active'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "   AND B.Status IN (N'Checked in', N'Confirmed', N'Waiting for processing')\n"
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
                    + "AND R.Status  =N'Active'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "   AND B.Status IN (N'Checked in', N'Confirmed', N'Waiting for processing')\n"
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
                    + "    R.ImageUrl,\n"
                    + "     R.Area\n"
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
                room.setArea(rs.getFloat("Area"));

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
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    public List<Rooms> getFullRoomsForDashboard(int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();

        try {
            String sql = "select RoomId, FloorNumber,RoomNumber,RoomType, Price , status from Rooms order by RoomNumber offset (?-1) *10 Rows Fetch NEXT 10 row only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setStatus(rs.getString("Status"));
                list.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Rooms> getSearchOfDashBoard(int page, int roomNumber) {
        List<Rooms> list = new ArrayList<>();

        ResultSet rs = null;
        try {
            String sql = "select RoomId,FloorNumber,RoomNumber,RoomType, Price , status from Rooms\n"
                    + "where RoomNumber like ?\n"
                    + "order by RoomNumber offset (?-1) *10 Rows Fetch NEXT 10 row only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + roomNumber + "%");
            st.setInt(2, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setStatus(rs.getString("Status"));
                list.add(room);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public int checkRoomOfFoor(String roomNumber, int floorNumber) {
        ResultSet rs = null;
        try {
            String sql = "select RoomId from Rooms where RoomNumber = ? and FloorNumber =?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, roomNumber);
            pst.setInt(2, floorNumber);
            rs = pst.executeQuery();
            if (rs.next()) {
                return 1;
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int createRoom(String roomNumber, int floorNumber, String roomType, String bedType, Long price, int maxOccupancy,
            String description, String imageUrl, String status, int buildingId, float area) {
        int cnt = 0;
        try {
            String sql = "INSERT INTO Rooms \n"
                    + "(RoomNumber, FloorNumber,\n"
                    + "RoomType, BedType,\n"
                    + "Price, MaxOccupancy,\n"
                    + "Description, ImageUrl,\n"
                    + "Status, BuildingId,Area)\n"
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, roomNumber);
            pst.setInt(2, floorNumber);
            pst.setString(3, roomType);
            pst.setString(4, bedType);
            pst.setLong(5, price);
            pst.setInt(6, maxOccupancy);
            pst.setString(7, description);
            pst.setString(8, imageUrl);
            pst.setString(9, status);
            pst.setInt(10, buildingId);
            pst.setFloat(11, area);

            cnt = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public Rooms getRoomDetailForEdit(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "R.RoomNumber,\n"
                    + "R.FloorNumber,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "R.BedType,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl,\n"
                    + "R.Status,\n"
                    + "R.BuildingId,\n"
                    + "     R.Area\n"
                    + "FROM Rooms R\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setBedType(rs.getString("BedType"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));
                room.setBuildingId(rs.getInt("BuildingId"));
                room.setArea(rs.getFloat("Area"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    public int UpdateRoomDetailForEdit(Rooms r) {
        int check = 0;
        try {
            String sql = "UPDATE Rooms\n"
                    + "SET\n"
                    + "    FloorNumber = ?,         \n"
                    + "    RoomType = ?,           \n"
                    + "    BedType = ?,            \n"
                    + "    Price = ?,              \n"
                    + "    MaxOccupancy = ?,       \n"
                    + "    Description = ?,        \n"
                    + "    ImageUrl = ?,          \n"
                    + "    Status = ?,           \n"
                    + "    BuildingId = ?,        \n"
                    + "    Area = ?         \n"
                    + "WHERE\n"
                    + "    RoomId = ?;            ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, r.getFloorNumber());
            pst.setString(2, r.getRoomType());
            pst.setString(3, r.getBedType());
            pst.setLong(4, r.getPrice());
            pst.setInt(5, r.getMaxOccupancy());
            pst.setString(6, r.getDescription());
            pst.setString(7, r.getImageUrl());
            pst.setString(8, r.getStatus());
            pst.setInt(9, r.getBuildingId());
            pst.setFloat(10, r.getArea());
            pst.setInt(11, r.getRoomId());
            check = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

}
