/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.CustomerDao;
import dao.VoucherDAO;
import db.ConnectData;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
        HttpSession session = (HttpSession) request.getSession();
        if (session.getAttribute("customerId") == null) {
            response.sendRedirect("Login");
        }

        String customerId = session.getAttribute("customerId").toString();
        try {
            int id = Integer.parseInt(customerId);
            VoucherDAO voucherDao = new VoucherDAO();

            // Lấy tất cả các voucher còn hiệu lực
            List<Vouchers> allVouchers = voucherDao.getAllAvailableVouchers();

            // Lấy các voucher mà user đã lưu
            List<Vouchers> savedVouchers = voucherDao.checkVoucherById(id);

            // Dùng Set để check nhanh voucherId nào đã lưu
//            Set<Integer> savedIds = new HashSet<>();
//            for (Vouchers v : savedVouchers) {
//                savedIds.add(v.getVoucherId());
//                System.out.println(v.getVoucherId());
//            }

            // Gửi dữ liệu sang JSP
            request.setAttribute("vouchers", allVouchers);
            request.setAttribute("savedIds", savedVouchers);

            request.getRequestDispatcher("voucher/viewVouchers.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();

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
//        try {
//            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
//            System.out.println("voucherId: " + voucherId);
//
//            HttpSession session = request.getSession();
//
//            String customerId = (String) session.getAttribute("customerId");
//
//            int id = Integer.parseInt((String) session.getAttribute("customerId"));
//            System.out.println("CustomerId: " + id);
//            if (customerId == null) {
//                request.setAttribute("message", "Bạn cần đăng nhập!");
//                response.sendRedirect("login");
//                return;
//            }
//
//            VoucherDAO dao = new VoucherDAO();
//            boolean alreadySaved = dao.hasSavedVoucher(id, voucherId);
//
//            if (!alreadySaved) {
//                dao.saveCustomerVoucher(id, voucherId);
//                request.setAttribute("message", "Lưu thành công!");
//            } else {
//                request.setAttribute("message", "Bạn đã lưu voucher này rồi!");
//            }
//
//            List vouchers = dao.getAllAvailableVouchers();
//            List saved = dao.getVouchersByCustomer(id);
//
//            request.setAttribute("vouchers", vouchers);
//            request.setAttribute("voucherCustomer", saved);
//
//            request.getRequestDispatcher("voucher/viewVouchers.jsp").forward(request, response);
//
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            request.setAttribute("message", "Có lỗi xảy ra: " + ex.getMessage());
//            response.sendRedirect("ViewVouchers");
//        }

        try {
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            HttpSession session = request.getSession();
            String customerStr = (String) session.getAttribute("customerId");

            if (customerStr == null) {
                response.sendRedirect("Login");
                return;
            }

            int customerId = Integer.parseInt(customerStr);
            VoucherDAO dao = new VoucherDAO();

            // Nếu chưa lưu thì mới xử lý
            if (!dao.hasSavedVoucher(customerId, voucherId)) {
                Connection conn = null;
                try {
                    conn = ConnectData.getConnection();
                    conn.setAutoCommit(false);

                    boolean inserted = dao.saveCustomerVoucher(customerId, voucherId, conn);
                    boolean updated = dao.decreaseVoucherQuantity(voucherId, conn);

                    if (inserted && updated) {
                        conn.commit(); // thành công
                    } else {
                        conn.rollback(); // thất bại
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    if (conn != null) {
                        conn.rollback();
                    }
                } finally {
                    if (conn != null) {
                        try {
                            conn.setAutoCommit(true);
                            conn.close();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            }

            // Sau khi xử lý xong thì gọi lại chính servlet này bằng GET để load lại dữ liệu và hiển thị mới
            response.sendRedirect("ViewVouchers");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("ViewVouchers"); // fallback
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
