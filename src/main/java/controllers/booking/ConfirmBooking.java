/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "ConfirmBooking", urlPatterns = {"/ConfirmBooking"})
public class ConfirmBooking extends HttpServlet {

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
            out.println("<title>Servlet ConfirmBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmBooking at " + request.getContextPath() + "</h1>");
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
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        HttpSession session = request.getSession();
        String location = session.getAttribute("location").toString();
        LocalDate checkIn = LocalDate.parse(session.getAttribute("checkIn").toString());
        LocalDate checkOut = LocalDate.parse(session.getAttribute("checkOut").toString());
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String checkInFormat = checkIn.format(dateFormat);
        String checkOutFormat = checkOut.format(dateFormat);
        long numberNight = ChronoUnit.DAYS.between(checkIn, checkOut);
        int adults = Integer.parseInt(session.getAttribute("adults").toString());
        int children = Integer.parseInt(session.getAttribute("children").toString());
        RoomDao roomDao = new RoomDao();
        Rooms room = roomDao.getInformationRoomBooking(roomId);
        request.setAttribute("room", room);
        request.setAttribute("roomId", roomId);
        request.setAttribute("location", location);
        request.setAttribute("checkIn", checkInFormat);
        request.setAttribute("checkOut", checkOutFormat);
        request.setAttribute("numberNight", numberNight);
        request.setAttribute("adults", adults);
        request.setAttribute("children", children);

        String voucherId = request.getParameter("voucherId");
        if (voucherId != null && !voucherId.isEmpty()) {
            request.setAttribute("voucherId", voucherId);
        }
        request.getRequestDispatcher("booking/confirmBooking.jsp").forward(request, response);
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
