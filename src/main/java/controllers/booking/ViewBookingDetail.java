/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.BookingDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;

/**
 *
 * @author Dương Đinh Thế Vinh
 */
@WebServlet(name = "ViewBookingDetail", urlPatterns = {"/ViewBookingDetail"})
public class ViewBookingDetail extends HttpServlet {

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
            out.println("<title>Servlet ViewBookingDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewBookingDetail at " + request.getContextPath() + "</h1>");
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

    String bookingIdParam = request.getParameter("bookingId");

    if (bookingIdParam == null || bookingIdParam.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
        return;
    }

    try {
        int bookingId = Integer.parseInt(bookingIdParam);
        BookingDao bookingDao = new BookingDao();
        Bookings booking = bookingDao.getBookingDetail(bookingId);

        if (booking != null) {
            request.setAttribute("bookingDetail", booking);
            request.getRequestDispatcher("booking/viewBookingDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Booking not found");
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found"); //  chuyển vào bên trong
        }

    } catch (SQLException ex) {
        Logger.getLogger(ViewBookingDetail.class.getName()).log(Level.SEVERE, null, ex);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error"); //  truyền vào catch
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
