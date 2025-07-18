/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

import dao.CustomerDao;
import db.GoogleUtils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customers;
import models.GoogleUser;

/**
 *
 * @author dodan
 */
@WebServlet(name = "GoogleLogin", urlPatterns = {"/GoogleLogin"})
public class GoogleLogin extends HttpServlet {

    private static final String CLIENT_ID = "997801693447-snhm9e2fn2ml7t8c2f40iv02n2ov8a6d.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/GoogleLogin";

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
            out.println("<title>Servlet GoogleLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GoogleLogin at " + request.getContextPath() + "</h1>");
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

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Exchange code for access token
        String accessToken = GoogleUtils.getToken(code, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

        // Get user info from Google
        GoogleUser googleUser = GoogleUtils.getUserInfo(accessToken);

        // Kiểm tra người dùng đã tồn tại chưa?
        CustomerDao dao = new CustomerDao();
        Customers user = dao.getCustomerByEmail(googleUser.getEmail());

        if (user == null) {
            // Đăng ký tài khoản mới
            Customers newUser = new Customers();
            newUser.setUserName(googleUser.getEmail().split("@")[0]); // Tùy bạn gán username
            newUser.setEmail(googleUser.getEmail());
            newUser.setPassword(""); // Có thể để trống hoặc random

            dao.createCustomer(newUser); // Đăng ký vào DB
            user = newUser;
        }

        // Lưu user vào session
        HttpSession session = request.getSession();
        session.setAttribute("customer", user);
        response.sendRedirect("Index"); // Chuyển về trang chính
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
