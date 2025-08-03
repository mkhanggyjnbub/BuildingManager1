/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.checkInOut;

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
import java.util.List;
import models.Bookings;
import models.Rooms;

/**
 *
 * @author KHANH
 */
@WebServlet(name = "UpdateRoomOption", urlPatterns = {"/UpdateRoomOption"})
public class UpdateRoomOption extends HttpServlet {

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
            out.println("<title>Servlet UpdateRoomOption</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRoomOption at " + request.getContextPath() + "</h1>");
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
        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null) {
            response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=missingBookingId");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);
        BookingDao bookingDao = new BookingDao();
        Bookings booking = bookingDao.getBookingCheckInInfoForUpdate(bookingId);

        int currentMax = 0;
        if (booking != null && booking.getRooms() != null) {
            currentMax = booking.getRooms().getMaxOccupancy();
        }

        RoomDao roomDao = new RoomDao();
        List<Rooms> roomList = roomDao.getAvailableRoomsForUpgrade(currentMax + 1);

        request.setAttribute("availableRooms", roomList);
        request.setAttribute("bookingId", bookingId);
        request.getRequestDispatcher("checkInOut/updateRoomOption.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=invalidBookingId");
    } catch (Exception e) {
        response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=server");
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
