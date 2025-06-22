/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.Vouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "AddVoucher", urlPatterns = {"/AddVoucher"})
public class AddVoucher extends HttpServlet {

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
            out.println("<title>Servlet AddVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddVoucher at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");

        Vouchers voucher = new Vouchers();
        VoucherDAO voucherDao = new VoucherDAO();

        // Nhận các dữ liệu cơ bản
        voucher.setCode(request.getParameter("code"));
        voucher.setDescription(request.getParameter("description"));
        voucher.setDiscountPercent(Integer.parseInt(request.getParameter("discountPercent")));
        voucher.setMinOrderAmount(new BigDecimal(request.getParameter("minOrderAmount")));
        voucher.setQuantity(Integer.parseInt(request.getParameter("quantity")));

        // Lấy startDate (định dạng từ datetime-local: yyyy-MM-ddTHH:mm)
        String startDateStr = request.getParameter("startDate"); // ví dụ: 2025-06-23T22:30
        LocalDateTime startDate = LocalDateTime.parse(startDateStr);
        voucher.setStartDate(startDate);

// Lấy endDate tương tự
        String endDateStr = request.getParameter("endDate"); // ví dụ: 2025-06-30T23:59
        LocalDateTime endDate = LocalDateTime.parse(endDateStr);
        voucher.setEndDate(endDate);

        // Xử lý trạng thái
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        voucher.setIsActive(isActive);

        // Chèn vào database
        voucherDao.insertVoucher(voucher);

        // Chuyển hướng về danh sách
        response.sendRedirect("VouchersDashBoard");
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
