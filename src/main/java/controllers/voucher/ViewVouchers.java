/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.CustomerDao;
import dao.CustomerVoucherDao;
import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Customers;
import models.Vouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "ViewVouchers", urlPatterns = {"/ViewVouchers"})
public class ViewVouchers extends HttpServlet {

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
            out.println("<title>Servlet Vouchers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Vouchers at " + request.getContextPath() + "</h1>");
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
        int customerId = Integer.parseInt(session.getAttribute("cusstomerId").toString()); // từ session hoặc form
        VoucherDAO voucherDao = new VoucherDAO();
        List<Vouchers> list = voucherDao.selectAllVouchers();

        List<Vouchers> list1 = voucherDao.checkVoucherById(customerId);

        request.setAttribute("voucherCustomer", list1);
        request.setAttribute("vouchers", list);
        request.getRequestDispatcher("voucher/viewVouchers.jsp").forward(request, response);

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

        HttpSession session = request.getSession();
        Object sessionValue = session.getAttribute("customerId");

        // Kiểm tra nếu chưa đăng nhập
//        if (sessionValue == null) {
//            response.sendRedirect("Login.jsp"); // hoặc trang phù hợp
//            return;
//        }
        int customerId = Integer.parseInt(session.getAttribute("cusstomerId").toString());
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));

        CustomerVoucherDao dao = new CustomerVoucherDao();
        int result = dao.saveVoucher(customerId, voucherId);

        response.sendRedirect("ViewVouchers");
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
