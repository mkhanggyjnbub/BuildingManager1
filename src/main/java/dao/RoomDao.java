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
                    + "INNER JOIN Floors F ON R.FloorId = F.FloorId\n"
                    + "INNER JOIN Buildings B ON F.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Booking B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "    AND B.StatusId in(1,2,3)\n"
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
                    + "INNER JOIN Floors F ON R.FloorId = F.FloorId\n"
                    + "INNER JOIN Buildings B ON F.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "    AND B.StatusId in(1,2,3)\n"
                    + ")  order by RoomId offset ? Rows Fetch NEXT 6 Rows Only";
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

}
