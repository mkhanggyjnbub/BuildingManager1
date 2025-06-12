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
        int id = Integer.parseInt(request.getParameter("voucherId"));
        
        String code = request.getParameter("code");
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        int discountPercent = Integer.parseInt(request.getParameter("discountPercent"));
        int discountAmount = Integer.parseInt(request.getParameter("discountAmount"));
        int minOrderAmount = Integer.parseInt(request.getParameter("minOrderAmount"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String description = request.getParameter("description");

        Vouchers v = new Vouchers(id, code, typeId, discountPercent, discountAmount,
                minOrderAmount, startDate, endDate, description);

        VoucherDAO dao = new VoucherDAO();
        
        int cnt = dao.updateVoucher(v); // Phải có phương thức này trong DAO

        
        if(cnt != 0){
            response.sendRedirect("VouchersDashBoard");
        }
        else {
            response.sendRedirect("...");
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
