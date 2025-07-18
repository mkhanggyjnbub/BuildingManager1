/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

import dao.CustomerDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customers;

/**
 *
 * @author dodan
 */
@WebServlet(name = "EmailVerification", urlPatterns = {"/EmailVerification"})
public class EmailVerification extends HttpServlet {

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
            out.println("<title>Servlet EmailVerification</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmailVerification at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("account/emailVerification.jsp").forward(request, response);
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

        Long otpSentTime = (Long) session.getAttribute("otpSentTime");
        Long otpExpiryDuration  = null;
        if (session.getAttribute("otpExpiryDuration") != null) {
            otpExpiryDuration = (Long) session.getAttribute("otpExpiryDuration");
        }
        
        long currentTime = System.currentTimeMillis();

        // Kiểm tra hết hạn OTP
        if (otpSentTime == null || otpExpiryDuration == null || (currentTime - otpSentTime) > otpExpiryDuration) {
            request.setAttribute("error", "The OTP has expired. Please resend.");
            request.setAttribute("expired", true);
            request.getRequestDispatcher("account/emailVerification.jsp").forward(request, response);
            return;
        }

        try {
            int otpInput = Integer.parseInt(request.getParameter("otp"));
            Integer otpCode = (Integer) session.getAttribute("otpCode");

            if (otpCode == null || otpInput != otpCode) {
                request.setAttribute("error", "Incorrect OTP. Please try again.");
                request.getRequestDispatcher("account/emailVerification.jsp").forward(request, response);
                return;
            }

            CustomerDao dao = new CustomerDao();

            if ("signup".equals(otpPurpose)) {
                Customers tempUser = (Customers) session.getAttribute("tempUser");
                if (tempUser == null) {
                    response.sendRedirect("error");
                    return;
                }

                String hashedPassword = dao.md5(tempUser.getPassword());
                tempUser.setPassword(hashedPassword);

                int result = dao.createCustomer(tempUser);

                if (result > 0) {
                    session.removeAttribute("otpPurpose");
                    session.removeAttribute("otpCode");
                    session.removeAttribute("otpSentTime");
                    session.removeAttribute("otpExpiryDuration");
                    session.removeAttribute("tempUser");
                    response.sendRedirect("Login");
                } else {
                    response.sendRedirect("error");
                }

            } else if ("reset".equals(otpPurpose)) {
                // Trường hợp đặt lại mật khẩu
                session.removeAttribute("otpPurpose");
                session.removeAttribute("otpCode");
                session.removeAttribute("otpSentTime");
                session.removeAttribute("otpExpiryDuration");
                response.sendRedirect("ResetPassword");

            } else {
                response.sendRedirect("error");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid OTP format.");
            request.getRequestDispatcher("account/emailVerification.jsp").forward(request, response);
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
