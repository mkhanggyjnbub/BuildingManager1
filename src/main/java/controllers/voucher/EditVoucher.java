/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.VoucherDAO;
import models.Vouchers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "EditVoucher", urlPatterns = {"/EditVoucher"})
public class EditVoucher extends HttpServlet {

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
            out.println("<title>Servlet EditVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditVoucher at " + request.getContextPath() + "</h1>");
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
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        Vouchers vouchers = new Vouchers();

        VoucherDAO dao = new VoucherDAO();
        vouchers = dao.getVoucherById(voucherId);
        request.setAttribute("voucher", vouchers);
        request.getRequestDispatcher("vouchersAdmin/editVoucher.jsp").forward(request, response);

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

        Vouchers v = new Vouchers();

        int id = Integer.parseInt(request.getParameter("voucherId"));
        v.setVoucherId(id);
        v.setVoucherId(Integer.parseInt(request.getParameter("voucherId")));
        v.setCode(request.getParameter("code"));
        v.setDiscountPercent(Integer.parseInt(request.getParameter("discountPercent")));
        v.setStartDate(Date.valueOf(request.getParameter("startDate")));
        v.setEndDate(Date.valueOf(request.getParameter("endDate")));
        v.setMinOrderAmount(new BigDecimal(request.getParameter("minOrderAmount")));
        v.setDescription(request.getParameter("description"));
        v.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        boolean isActive = request.getParameter("isActive") != null;
        v.setIsActive(isActive);

        VoucherDAO dao = new VoucherDAO();
        int cnt = dao.updateVoucher(v);

        if (cnt != 0) {
            response.sendRedirect("VouchersDashBoard");
        } else {
            response.sendRedirect("EditVoucher?voucherId=" + id + "&error=1");
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
