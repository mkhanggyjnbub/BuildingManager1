/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.admin;

import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import models.Users;

/**
 *
 * @author dodan
 */
@WebServlet(name = "CreateStaff", urlPatterns = {"/CreateStaff"})
public class CreateStaff extends HttpServlet {

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
            out.println("<title>Servlet CreateUserDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateUserDashboard at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("admin/createStaff.jsp").forward(request, response);
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

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String identityNumber = request.getParameter("identityNumber");
        String phone = request.getParameter("phone");

        UserDao dao = new UserDao();

        boolean userNameExists = dao.isUserNameExists(userName);
        boolean emailExists = dao.isEmailExists(email);
        boolean identityExists = dao.isIdentityNumberExists(identityNumber);

        if (userNameExists || emailExists || identityExists) {
            StringBuilder errorMsg = new StringBuilder();
            if (userNameExists) {
                errorMsg.append("Username already exists.<br>");
            }
            if (emailExists) {
                errorMsg.append("Email already exists.<br>");
            }
            if (identityExists) {
                errorMsg.append("Identity Number already exists.<br>");
            }

            request.setAttribute("error", errorMsg.toString());

            // Preserve user input
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("identityNumber", identityNumber);
            request.setAttribute("phone", phone);

            request.getRequestDispatcher("admin/createStaff.jsp").forward(request, response);
            return;
        }

        // If not duplicate, proceed to create
        Users newUser = new Users();
        newUser.setUserName(userName);
        newUser.setPassword(dao.md5(password));
        newUser.setEmail(email);
        newUser.setIdenityNumber(identityNumber);
        newUser.setPhone(phone);
        newUser.setRoleId(2);
        newUser.setCreationDate(LocalDateTime.now());
        newUser.setGender("Other");
        newUser.setStatus("1");
        newUser.setAvatarUrl("images/default.jpg");

        int check = dao.createStaff(newUser);

        if (check > 0) {
            response.sendRedirect("DashboardUser");
        } else {
            request.setAttribute("error", "Failed to create staff account.");
            request.getRequestDispatcher("admin/createStaff.jsp").forward(request, response);
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
