/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

import dao.CustomerDao;
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
import sendMail.EmailSender;

/**
 *
 * @author dodan
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/ForgotPassword"})
public class ForgotPassword extends HttpServlet {

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
            out.println("<title>Servlet ForgotPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassword at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("account/forgotPassword.jsp").forward(request, response);
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

        String username = request.getParameter("username");
        String email = request.getParameter("email");

        HttpSession session = request.getSession();
        CustomerDao dao = new CustomerDao();

        boolean hasError = false;

        if (!dao.isUsernameTaken(username)) {
            request.setAttribute("usernameError", "Tên đăng nhập không tồn tại.");
            hasError = true;
        }

        if (!dao.isEmailTaken(email)) {
            request.setAttribute("emailError", "Email không tồn tại.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("account/forgotPassword.jsp").forward(request, response);
            return;
        }

        int otpCode = new Random().nextInt(900000) + 100000;
        session.setAttribute("otpCode", otpCode);
        session.setAttribute("otpSentTime", System.currentTimeMillis());
        session.setAttribute("resetUsername", username);
        session.setAttribute("resetEmail", email);
        session.setAttribute("otpExpiryDuration", 300000L);
        session.setAttribute("otpPurpose", "reset");

        try {
            EmailSender emailSender = new EmailSender();
            emailSender.sendOTPEmailResetPassword(email, "Xác minh đặt lại mật khẩu - Big Resort", otpCode);
            response.sendRedirect("EmailVerification");
        } catch (MessagingException e) {
            request.setAttribute("error", "Không thể gửi mã OTP. Vui lòng thử lại.");
            request.getRequestDispatcher("account/forgotPassword.jsp").forward(request, response);
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
