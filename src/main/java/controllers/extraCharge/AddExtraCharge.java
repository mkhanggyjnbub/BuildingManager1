/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.extraCharge;

import dao.BookingDao;
import dao.ExtraChargeDao;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import models.Bookings;
import models.ExtraCharge;

/**
 *
 * @author dodan
 */
@WebServlet(name = "AddExtraCharge", urlPatterns = {"/AddExtraCharge"})
public class AddExtraCharge extends HttpServlet {

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
            out.println("<title>Servlet AddExtracharge</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddExtracharge at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String redirect = request.getParameter("redirect"); // redirect nếu có

            BookingDao dao = new BookingDao();
            Bookings b = dao.getBookingById(bookingId);

            if (b == null || b.getEndDate() == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking or end date.");
                return;
            }

            // 1. Tính thời gian phụ thu
            LocalDate endDate = b.getEndDate();
            LocalDateTime checkoutDeadline = endDate.atTime(12, 0); // 12:00 trưa ngày trả
            LocalDateTime now = LocalDateTime.now();

            long hoursLate = Duration.between(checkoutDeadline, now).toHours();
            if (hoursLate <= 0) {
                hoursLate = 0; // Không trễ
            }

            // 2. Nếu có trễ thì tạo phụ thu
            if (hoursLate > 0) {
                ExtraCharge e = new ExtraCharge();
                e.setBookingId(bookingId);
                e.setChargeType("Late Hour");
                e.setQuantity((int) hoursLate);

                RoomDao roomDao = new RoomDao();
                long roomPrice = roomDao.getPriceRoomByBookingId(bookingId);
                long hourlyPrice = Math.round(roomPrice * 0.1); // 10% mỗi giờ

                e.setUnitPrice(hourlyPrice);
                e.setStartTime(checkoutDeadline);
                e.setEndTime(now);

                ExtraChargeDao extraChargeDao = new ExtraChargeDao();
                extraChargeDao.insertExtraCharge(e);
            }

            // 3. Cập nhật trạng thái booking
            dao.checkedOutBooking(bookingId);

            // 4. Điều hướng
            if (redirect != null && redirect.equals("PaymentCheckOut")) {
                response.sendRedirect("PaymentCheckOut?bookingId=" + bookingId);
            } else {
                response.sendRedirect("ViewAllCheckInOutDashboard");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
        processRequest(request, response);
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
