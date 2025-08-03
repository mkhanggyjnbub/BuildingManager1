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

            if (booking == null) {
                response.sendError(404, "Booking not found.");
                return;
            }

            String roomType = booking.getRoomType();
            LocalDate startDate = booking.getStartDate();
            LocalDate endDate = booking.getEndDate();

            RoomDao roomDao = new RoomDao();
            List<Rooms> rooms = roomDao.getAvailableRoomSameType(bookingId);

            Map<Integer, List<Rooms>> roomsByFloor = new HashMap<>();
            for (Rooms r : rooms) {
                int floor = r.getFloorNumber();
                if (!roomsByFloor.containsKey(floor)) {
                    roomsByFloor.put(floor, new ArrayList<Rooms>());
                }
                roomsByFloor.get(floor).add(r);
            }

            request.setAttribute("bookingId", bookingId);
            request.setAttribute("roomType", roomType);
            request.setAttribute("startDate", startDate.toString());
            request.setAttribute("endDate", endDate.toString());
            request.setAttribute("roomsByFloor", roomsByFloor);

            if (rooms.isEmpty()) {
                request.setAttribute("noRoomTypeAlert", true);
            }

            request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(500, "Handling SelectRoom (GET) errors");
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
            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                request.setAttribute("noRoomTypeAlert", true);
                request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
                return;
            }

            int bookingId = Integer.parseInt(bookingIdStr);

            BookingDao bookingDao = new BookingDao();
            Bookings booking = bookingDao.getBookingInfoForConfirmation(bookingId);

            if (booking == null || booking.getRoomType() == null || booking.getRoomType().trim().isEmpty()) {
                request.setAttribute("noRoomTypeAlert", true);
                request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
                return;
            }

            String roomType = booking.getRoomType().trim();
            LocalDate defaultStart = booking.getStartDate();
            LocalDate defaultEnd = booking.getEndDate();

            request.setAttribute("bookingId", bookingId);
            request.setAttribute("roomType", roomType);
            request.setAttribute("startDate", defaultStart.toString());
            request.setAttribute("endDate", defaultEnd.toString());

            String customStartStr = request.getParameter("customStartDate");
            String customEndStr = request.getParameter("customEndDate");

            List<Rooms> availableRoomsList = new ArrayList<Rooms>();
            boolean isUserSearching = false;

            if (customStartStr != null && customEndStr != null
                    && !customStartStr.isEmpty() && !customEndStr.isEmpty()) {
                isUserSearching = true;
                try {
                    LocalDate start = LocalDate.parse(customStartStr);
                    LocalDate end = LocalDate.parse(customEndStr);

                    if (start.isBefore(end)) {
                        RoomDao roomDao = new RoomDao();
                        System.out.println("start time m" + start);
                        System.out.println("end time m" + end);
                        availableRoomsList = roomDao.getAvailableRoomByDateAndType(end, start, roomType);
                        request.setAttribute("customStart", start.toString());
                        request.setAttribute("customEnd", end.toString());
                    } else {
                        request.setAttribute("dateError", "❌ End date must be after start date.");
                    }

                } catch (DateTimeParseException e) {
                    request.setAttribute("dateError", "❌ Invalid date format.");
                }
            }

            // fallback nếu không có phòng hoặc user chưa chọn ngày
            if (availableRoomsList == null || availableRoomsList.isEmpty()) {
                RoomDao roomDao = new RoomDao();
                availableRoomsList = roomDao.getAvailableRoomSameType(bookingId);

                // gán lại ngày mặc định nếu fallback
                request.setAttribute("customStart", defaultStart.toString());
                request.setAttribute("customEnd", defaultEnd.toString());
            }

            // chỉ hiển thị cảnh báo nếu người dùng chủ động tìm
            if ((availableRoomsList == null || availableRoomsList.isEmpty()) && isUserSearching) {
                request.setAttribute("noRoomTypeAlert", true);
            }

            // Nhóm phòng theo tầng
            Map<Integer, List<Rooms>> roomsByFloor = new HashMap<Integer, List<Rooms>>();
            if (availableRoomsList != null) {
                for (int i = 0; i < availableRoomsList.size(); i++) {
                    Rooms room = availableRoomsList.get(i);
                    int floor = room.getFloorNumber();

                    if (!roomsByFloor.containsKey(floor)) {
                        roomsByFloor.put(floor, new ArrayList<Rooms>());
                    }
                    roomsByFloor.get(floor).add(room);
                }
            }

            request.setAttribute("roomsByFloor", roomsByFloor);
            request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);

        } catch (Exception ex) {
            // Nếu có bất kỳ lỗi nào khác thì chỉ hiển thị popup thông báo chung
            ex.printStackTrace();
            request.setAttribute("noRoomTypeAlert", true);
            request.getRequestDispatcher("booking/selectRoom.jsp").forward(request, response);
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
