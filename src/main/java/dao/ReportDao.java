/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import db.ConnectData;
import static db.ConnectData.conn;
import java.sql.Connection;
import models.Report;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KHANH
 */

public class ReportDao {

    public List<Report> getAllReports() throws Exception {
        List<Report> list = new ArrayList<>();

        String sql = "SELECT * FROM RoomReports";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Report r = new Report();
                r.setReportId(rs.getInt("ReportId"));
                r.setRoomId(rs.getInt("RoomId"));
                r.setReportedByCustomerId(rs.getInt("ReportedByCustomerId"));
                r.setReportedByUserId(rs.getInt("ReportedByUserId"));
                r.setReportTime(rs.getTimestamp("ReportTime"));
                r.setDescription(rs.getString("Description"));
                r.setStatus(rs.getString("Status"));
                r.setHandledBy(rs.getInt("HandledBy"));
                r.setHandledTime(rs.getTimestamp("HandledTime"));
                r.setNotes(rs.getString("Notes"));

                list.add(r);
            }
        }

        return list;
    }
}
   


