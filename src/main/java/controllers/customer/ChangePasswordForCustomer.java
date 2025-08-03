/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.customer;

import dao.CustomerDao;
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

/**
 *
 * @author dodan
 */
@WebServlet(name = "ChangePasswordForCustomer", urlPatterns = {"/ChangePasswordForCustomer"})
public class ChangePasswordForCustomer extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordForCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordForCustomer at " + request.getContextPath() + "</h1>");
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
        request.setAttribute("customerId", request.getAttribute("id"));
        request.getRequestDispatcher("account/changePasswordForCustomer.jsp").forward(request, response);
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
    Object userObj = session.getAttribute("customerId");

    if (userObj == null) {
        response.sendRedirect("Login");
        return;
    }

    int id = Integer.parseInt(userObj.toString());

    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    CustomerDao dao = new CustomerDao();

    // Check current password (hashed)
    String hashedCurrent = dao.md5(currentPassword);
    if (!hashedCurrent.equals(dao.getPasswordFoChange(id))) {
        request.setAttribute("error", "Current password is incorrect.");
        request.getRequestDispatcher("account/changePasswordForCustomer.jsp").forward(request, response);
        return;
    }

    // Check if new password and confirm match
    if (!newPassword.equals(confirmPassword)) {
        request.setAttribute("error", "New passwords do not match.");
        request.getRequestDispatcher("account/changePasswordForCustomer.jsp").forward(request, response);
        return;
    }

    // Update password
    String hashedNew = dao.md5(newPassword);
    boolean check = dao.updatePassword(id, hashedNew);

    if (check) {
        request.setAttribute("message", "Your password has been changed successfully.");
    } else {
        request.setAttribute("error", "Failed to change password. Please try again.");
    }

    response.sendRedirect("Logout");
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
