/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import controllers.voucher.*;
import dao.BookingDao;
import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Vouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "BookingConfirmation", urlPatterns = {"/BookingConfirmation"})
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

        // Lấy dữ liệu từ session
        String roomNumber = (String) session.getAttribute("search_room");
        String fullName = (String) session.getAttribute("search_name");
        String startDate = (String) session.getAttribute("search_start");
        String endDate = (String) session.getAttribute("search_end");
        String status = (String) session.getAttribute("search_status");

        // Xóa session để tránh lưu lại sau khi load
        session.removeAttribute("search_room");
        session.removeAttribute("search_name");
        session.removeAttribute("search_start");
        session.removeAttribute("search_end");
        session.removeAttribute("search_status");

        try {
            BookingDao dao = new BookingDao();
            List<Bookings> list;

            boolean isSearch
                    = (roomNumber != null && !roomNumber.trim().isEmpty())
                    || (fullName != null && !fullName.trim().isEmpty())
                    || (startDate != null && !startDate.trim().isEmpty())
                    || (endDate != null && !endDate.trim().isEmpty())
                    || (status != null && !status.trim().isEmpty());

            if (isSearch) {
                list = dao.searchBookings(roomNumber, fullName, startDate, endDate, status);
            } else {
                list = dao.getAllBookings();
            }

            // Truyền giá trị lại vào form tìm kiếm
            request.setAttribute("roomNumber", roomNumber);
            request.setAttribute("fullName", fullName);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("status", status);
            request.setAttribute("booking", list);

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

        String roomNumber = request.getParameter("roomNumber");
        String fullName = request.getParameter("fullName");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String status = request.getParameter("status");

        HttpSession session = request.getSession();
        session.setAttribute("search_room", roomNumber);
        session.setAttribute("search_name", fullName);
        session.setAttribute("search_start", startDate);
        session.setAttribute("search_end", endDate);
        session.setAttribute("search_status", status);

        // Redirect sang GET để tránh lỗi reload/resubmit
        response.sendRedirect("BookingConfirmation");
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
