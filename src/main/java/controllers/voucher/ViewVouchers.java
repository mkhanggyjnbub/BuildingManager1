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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int customerId = Integer.parseInt(session.getAttribute("customerId").toString());

            VoucherDAO voucherDao = new VoucherDAO();
            List<Vouchers> allVouchers = voucherDao.getAllAvailableVouchers();
            List<Vouchers> savedVouchers = voucherDao.checkVoucherById(customerId);

            Set<Integer> savedIds = new HashSet<>();
            for (Vouchers v : savedVouchers) {
                savedIds.add(v.getVoucherId());
            }

            request.setAttribute("vouchers", allVouchers);
            request.setAttribute("savedIds", savedIds);

        } catch (Exception ex) {
            ex.printStackTrace();
           
        }

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
                response.sendRedirect("login");
                return;
            }

            int customerId = Integer.parseInt(customerStr);

            VoucherDAO dao = new VoucherDAO();

            // Nếu đã lưu rồi thì báo luôn
            if (dao.hasSavedVoucher(customerId, voucherId)) {
                //request.setAttribute("message", "Bạn đã lưu voucher này rồi!");
            } else {
                Connection conn = null;
                try {
                    conn = ConnectData.getConnection();
                    conn.setAutoCommit(false); // Bắt đầu transaction

                    boolean inserted = dao.saveCustomerVoucher(customerId, voucherId, conn);
                    boolean updated = dao.decreaseVoucherQuantity(voucherId, conn);

                    if (inserted && updated) {
                        conn.commit();
                       // request.setAttribute("message", "Lưu thành công!");
                    } else {
                        conn.rollback();
                      //request.setAttribute("message", "Lưu thất bại. Vui lòng thử lại.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    if (conn != null) {
                        conn.rollback();
                    }
                    //request.setAttribute("message", "Lỗi: " + e.getMessage());
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

            // Load lại danh sách vouchers và vouchers đã lưu
            List vouchers = dao.getAllAvailableVouchers();
            List saved = dao.getVouchersByCustomer(customerId);

            request.setAttribute("vouchers", vouchers);
            request.setAttribute("voucherCustomer", saved);

            request.getRequestDispatcher("voucher/viewVouchers.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            //request.setAttribute("message", "Lỗi: " + ex.getMessage());
            response.sendRedirect("ViewVouchers");
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
