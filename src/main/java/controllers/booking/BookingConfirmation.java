/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.BookingDao;
import dao.RoomDao;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Rooms;
import sendMail.EmailSender;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet("/BookingConfirmation")
public class BookingConfirmation extends HttpServlet {

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
            out.println("<title>Servlet VouchersDashBoard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VouchersDashBoard at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession();

        String roomType = (String) session.getAttribute("search_room");
        String fullName = (String) session.getAttribute("search_name");
        String startDate = (String) session.getAttribute("search_start");
        String endDate = (String) session.getAttribute("search_end");
        String status = (String) session.getAttribute("search_status");

        session.removeAttribute("search_room");
        session.removeAttribute("search_name");
        session.removeAttribute("search_start");
        session.removeAttribute("search_end");
        session.removeAttribute("search_status");

        try {
            BookingDao dao = new BookingDao();
            List<Bookings> list;

            boolean isSearch
                    = (roomType != null && !roomType.trim().isEmpty())
                    || (fullName != null && !fullName.trim().isEmpty())
                    || (startDate != null && !startDate.trim().isEmpty())
                    || (endDate != null && !endDate.trim().isEmpty())
                    || (status != null && !status.trim().isEmpty());

            if (isSearch) {
                request.setAttribute("searched", true);
                list = dao.searchBookings(roomType, fullName, startDate, endDate, status);
            } else {
                list = dao.getAllBookings();
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            for (Bookings b : list) {
                if (b.getStartDate() != null) {
                    b.setFormattedStartDate(b.getStartDate().format(formatter));
                }
                if (b.getEndDate() != null) {
                    b.setFormattedEndDate(b.getEndDate().format(formatter));
                }
            }

            request.setAttribute("roomType", roomType);
            request.setAttribute("fullName", fullName);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("status", status);
            request.setAttribute("bookingList", list);

            if (isSearch && list.isEmpty()) {
                request.setAttribute("noResult", true);
            }

            request.getRequestDispatcher("booking/bookingConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
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

        String actionType = request.getParameter("actionType");
        HttpSession session = request.getSession();

        try {
            // 1. Xử lý chọn phòng
            if ("goToSelectRoom".equals(actionType)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                response.sendRedirect("SelectRoom?bookingId=" + bookingId);
                return;
            }

            // 2. Xác nhận không cần chọn phòng
            if ("confirmBooking".equals(actionType)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                String staffIdStr = (String) session.getAttribute("staffId");

                if (staffIdStr == null) {
                    response.sendRedirect("Login");
                    return;
                }

                int confirmedBy = Integer.parseInt(staffIdStr);
                BookingDao dao = new BookingDao();
                String currentStatus = dao.getBookingStatus(bookingId);

                if ("Waiting for processing".equalsIgnoreCase(currentStatus)) {
                    String roomIdStr = request.getParameter("roomId");

                    if (roomIdStr != null && !roomIdStr.isEmpty()) {
                        int roomId = Integer.parseInt(roomIdStr);
                        dao.confirmBookingWithRoom(bookingId, roomId, confirmedBy);
                    } else {
                        dao.confirmBooking(bookingId, confirmedBy);
                    }

                    Bookings info = dao.getBookingInfoForConfirmation(bookingId);
                    if (info != null) {
                        EmailSender sender = new EmailSender();
                        sender.sendHTMLEmail(
                                info.getCustomers().getEmail(),
                                "Confirm booking #" + info.getBookingId(),
                                info.getCustomers().getFullName(),
                                info.getBookingId(),
                                info.getStartDate(),
                                info.getEndDate(),
                                info.getRooms() != null ? info.getRooms().getRoomType() : "Not assigned",
                                info.getConfirmationTime()
                        );
                    }

                    session.setAttribute("bookingConfirmed", true);
                    response.sendRedirect("BookingConfirmation");
                    return;
                }
            }

            // 3. Tìm kiếm đơn - dùng session
            session.setAttribute("search_room", request.getParameter("roomType"));
            session.setAttribute("search_name", request.getParameter("fullName"));
            session.setAttribute("search_start", request.getParameter("startDate"));
            session.setAttribute("search_end", request.getParameter("endDate"));
            session.setAttribute("search_status", request.getParameter("status"));

            response.sendRedirect("BookingConfirmation");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
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
