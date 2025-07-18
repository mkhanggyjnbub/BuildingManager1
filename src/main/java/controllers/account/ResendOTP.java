/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import models.Customers;
import sendMail.EmailSender;

/**
 *
 * @author dodan
 */
@WebServlet(name = "ResendOTP", urlPatterns = {"/ResendOTP"})
public class ResendOTP extends HttpServlet {

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
            out.println("<title>Servlet ResendOTP</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResendOTP at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String otpPurpose = (String) session.getAttribute("otpPurpose");

        if ("signup".equals(otpPurpose)) {
            Customers temp = (Customers) session.getAttribute("tempUser");
            if (temp != null) {
                // Gửi lại OTP cho đăng ký
                int otpCode = new Random().nextInt(900000) + 100000;
                session.setAttribute("otpCode", String.valueOf(otpCode));
                session.setAttribute("otpSentTime", System.currentTimeMillis());

                EmailSender emailSender = new EmailSender();
                try {
                    emailSender.sendOTPEmailRegistered(temp.getEmail(), "OTP Verification - Big Resort", otpCode);
                    request.setAttribute("message", "Mã OTP mới đã được gửi.");
                } catch (MessagingException e) {
                    request.setAttribute("error", "Không thể gửi lại OTP.");
                }
            }
        } else if ("reset".equals(otpPurpose)) {
            String email = (String) session.getAttribute("resetEmail");
            if (email != null) {
                int otpCode = new Random().nextInt(900000) + 100000;
                session.setAttribute("otpCode", String.valueOf(otpCode));
                session.setAttribute("otpSentTime", System.currentTimeMillis());

                EmailSender emailSender = new EmailSender();
                try {
                    emailSender.sendOTPEmailResetPassword(email, "Xác minh đặt lại mật khẩu - Big Resort", otpCode);
                    request.setAttribute("message", "Mã OTP mới đã được gửi.");
                } catch (MessagingException e) {
                    request.setAttribute("error", "Không thể gửi lại OTP.");
                }
            }
        }
        request.getRequestDispatcher("account/emailVerification.jsp").forward(request, response);
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
