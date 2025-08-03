/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customers;
import models.RoomReviews;
import java.util.ArrayList;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class RoomReviewDao {

    private Connection conn = null;

    public RoomReviewDao() {
        conn = ConnectData.getConnection();
    }

    public int addReview(int roomId, int customerId, int rating, String comment) {
        int count = 0;
        try {
            String sql = "INSERT INTO RoomReviews (RoomId, CustomerId,  Rating, Comment, CreatedAt)\n"
                    + "VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, roomId);
            pst.setInt(2, customerId);
            pst.setInt(3, rating);
            pst.setString(4, comment);
            LocalDateTime createAt = LocalDateTime.now();
            pst.setTimestamp(5, Timestamp.valueOf(createAt));
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomReviewDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int countReviewsByRoomAndCustomer(int roomId, int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM RoomReviews WHERE RoomId = ? AND CustomerId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<RoomReviews> getReviewsByRoomId(int roomId) {
        List<RoomReviews> reviews = new ArrayList<>();
        String sql = "SELECT rr.ReviewId, rr.RoomId, rr.CustomerId, rr.Rating, rr.Comment, rr.CreatedAt, "
                + "c.UserName, c.AvatarUrl "
                + "FROM RoomReviews rr "
                + "JOIN Customers c ON rr.CustomerId = c.CustomerId "
                + "WHERE rr.RoomId = ? "
                + "ORDER BY rr.CreatedAt DESC";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RoomReviews review = new RoomReviews();
                review.setReviewId(rs.getInt("ReviewId"));
                review.setRoomId(rs.getInt("RoomId"));
                review.setCustomerId(rs.getInt("CustomerId"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());

                Customers customer = new Customers();
                customer.setUserName(rs.getString("UserName"));
                customer.setAvatarUrl(rs.getString("AvatarUrl"));

                review.setCustomer(customer);
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

}
