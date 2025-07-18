/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

//import db.SendOTPEmail;
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
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.Random;
import models.Customers;
import sendMail.EmailSender;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "SignUp", urlPatterns = {"/SignUp"})
public class SignUp extends HttpServlet {

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
            out.println("<title>Servlet SignUp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUp at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("account/signUp.jsp").forward(request, response);
    }

    private final EmailSender emailSender = new EmailSender();

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

        String username = request.getParameter("tk");
        String email = request.getParameter("email");
        String password = request.getParameter("pas");
        String dobStr = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String identityNumber = request.getParameter("cccd");

        HttpSession session = request.getSession();

        // Lưu dữ liệu để hiển thị lại khi có lỗi
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("dob", dobStr);
        request.setAttribute("phone", phone);
        request.setAttribute("cccd", identityNumber);

        boolean hasError = false;
        CustomerDao dao = new CustomerDao();

        // Kiểm tra trùng username
        if (dao.isUsernameTaken(username)) {
            request.setAttribute("usernameError", "Username is already taken.");
            hasError = true;
        }

        // Kiểm tra trùng email
        if (dao.isEmailTaken(email)) {
            request.setAttribute("emailError", "Email is already registered.");
            hasError = true;
        }

        // Chuyển đổi ngày sinh
        Date dob = null;
        try {
            dob = java.sql.Date.valueOf(dobStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("dobError", "Invalid date of birth.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("account/signUp.jsp").forward(request, response);
            return;
        }

        // Tạo OTP và lưu vào session
        int otpCode = new Random().nextInt(900000) + 100000;
        long currentTime = System.currentTimeMillis();

        session.setAttribute("otpPurpose", "signup");
        session.setAttribute("otpCode", otpCode); // Integer
        session.setAttribute("otpSentTime", currentTime);
        session.setAttribute("otpExpiryDuration", 300000L); // 5 phút

        Customers tempCustomer = new Customers(username, password, dob, phone, email, identityNumber, LocalDateTime.now());
        session.setAttribute("tempUser", tempCustomer);

        try {
            emailSender.sendOTPEmailRegistered(email, "OTP Verification - Big Resort", otpCode);
            response.sendRedirect("EmailVerification");
        } catch (MessagingException e) {
            request.setAttribute("error", "Failed to send OTP. Please try again.");
            request.getRequestDispatcher("account/signUp.jsp").forward(request, response);
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
