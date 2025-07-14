/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.BookingDao;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Rooms;

/**
 *
 * @author Dương Đinh Thế Vinh
 */
@WebServlet(name = "SelectRoom", urlPatterns = {"/SelectRoom"})
public class SelectRoom extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SelectRoom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SelectRoom at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            BookingDao bookingDao = new BookingDao();
            Bookings booking = bookingDao.getBookingInfoForConfirmation(bookingId);

            if (booking != null) {
                request.setAttribute("roomType", booking.getRoomType());

                request.setAttribute("startDate", booking.getStartDate().toString());
                request.setAttribute("endDate", booking.getEndDate().toString());
            }

            RoomDao roomDao = new RoomDao();
            List<Rooms> availableRoomsList = roomDao.getAvailableRoomSameType(bookingId);// Dùng ngày gốc từ booking

            // Nhóm phòng theo tầng
            Map<Integer, List<Rooms>> roomsByFloor = new HashMap<>();
            for (Rooms room : availableRoomsList) {
                if (!roomsByFloor.containsKey(room.getFloorNumber())) {
                    roomsByFloor.put(room.getFloorNumber(), new ArrayList<Rooms>());
                }
                roomsByFloor.get(room.getFloorNumber()).add(room);
            }

            request.setAttribute("roomsByFloor", roomsByFloor);
            request.setAttribute("bookingId", bookingId);
            request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SelectRoom.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String bookingIdStr = request.getParameter("bookingId");
            int bookingId = Integer.parseInt(bookingIdStr);

            BookingDao bookingDao = new BookingDao();
            Bookings booking = bookingDao.getBookingInfoForConfirmation(bookingId);

            if (booking != null) {
                request.setAttribute("roomType", booking.getRoomType());

                request.setAttribute("startDate", booking.getStartDate().toString());
                request.setAttribute("endDate", booking.getEndDate().toString());
            }
            // Nếu người dùng gửi ngày tùy chọn
            String customStart = request.getParameter("customStartDate");
            String customEnd = request.getParameter("customEndDate");

            RoomDao roomDao = new RoomDao();
            List<Rooms> availableRoomsList = new ArrayList<>();

            if (customStart != null && customEnd != null && !customStart.isEmpty() && !customEnd.isEmpty()) {
                try {
                    LocalDate startDate = LocalDate.parse(customStart);
                    LocalDate endDate = LocalDate.parse(customEnd);

                    // Kiểm tra logic ngày: check-in < check-out
                    if (startDate.isBefore(endDate)) {
                        availableRoomsList = roomDao.getAvailableRoomByDateRange(startDate, endDate);
                        request.setAttribute("customStart", startDate.toString());
                        request.setAttribute("customEnd", endDate.toString());
                    } else {
                        request.setAttribute("dateError", "Ngày trả phải sau ngày nhận.");
                    }
                } catch (DateTimeParseException e) {
                    request.setAttribute("dateError", "Ngày không hợp lệ.");
                }
            } else {
                // Nếu không có ngày tùy chọn => dùng ngày từ booking
                availableRoomsList = roomDao.getAvailableRoomSameType(bookingId);
            }

            // Nhóm theo tầng
            Map<Integer, List<Rooms>> roomsByFloor = new HashMap<>();
            for (Rooms room : availableRoomsList) {
                if (!roomsByFloor.containsKey(room.getFloorNumber())) {
                    roomsByFloor.put(room.getFloorNumber(), new ArrayList<Rooms>());
                }
                roomsByFloor.get(room.getFloorNumber()).add(room);
            }

            request.setAttribute("roomsByFloor", roomsByFloor);
            request.setAttribute("bookingId", bookingId);
            request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SelectRoom.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
