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
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import models.Bookings;
import models.Rooms;

/**
 *
 * @author dodan
 */
@WebServlet(name = "UpgradeBooking", urlPatterns = {"/UpgradeBooking"})
public class UpgradeBooking extends HttpServlet {

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
            out.println("<title>Servlet UpgradeBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpgradeBooking at " + request.getContextPath() + "</h1>");
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
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        System.out.println("bookingId la: "+ bookingId);
//        dao.updateStatusForUpgradeBooking(bookingId);
        Bookings b = new Bookings();
        BookingDao daoB = new BookingDao();
        b = daoB.getBookingByIdForUpdateBooking(bookingId);
        RoomDao daoR = new RoomDao();
        LocalDate startLocalDate = b.getStartDate();
        LocalDate endLocalDate = b.getEndDate();

        Date startDate = java.sql.Date.valueOf(startLocalDate);
        Date endDate = java.sql.Date.valueOf(endLocalDate);

        List<Rooms> listR = daoR.getAvailableRoomsForUpgrade(startDate, endDate, daoR.getMaxOccupancyByRoomId(b.getRoomId()) , bookingId);
        
        request.setAttribute("listR", listR);
        request.setAttribute("bookingId", bookingId);
        request.getRequestDispatcher("booking/upgradeBooking.jsp").forward(request, response);
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
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String roomType = request.getParameter("roomType");
        
        BookingDao daoB = new BookingDao();
        
        Bookings b;
        
        b = daoB.getBookingByIdForUpdateBooking(bookingId);
        HttpSession session = request.getSession();
        if (session.getAttribute("reception") != null) {
            b.setConfirmedBy(Integer.parseInt(session.getAttribute("reception").toString()));
        } else if (session.getAttribute("staffId") != null) {
            b.setConfirmedBy(Integer.parseInt(session.getAttribute("staffId").toString()));
        } else if (session.getAttribute("adminId") != null) {
            b.setConfirmedBy(Integer.parseInt(session.getAttribute("adminId").toString()));
        }
        
        int check = daoB.updateBooking(b, roomId, roomType);
        
        daoB.updateStatusForUpgradeBooking(bookingId);
        if (check != 0) {
            response.sendRedirect("ViewAllCheckInOutDashboard");
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
