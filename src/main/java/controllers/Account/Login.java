/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Account;

import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Users;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("account/login.jsp").forward(request, response);
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
        if (request.getParameter("sub") != null) {
            String userName = request.getParameter("tk").trim();
            String PassWord = request.getParameter("pas").trim();
            Users user = new Users();
            user.setUserName(userName);
            user.setPassword(PassWord);
            UserDao userDao = new UserDao();
            int checkLogin = userDao.loginForId(user);
            int checkRole = userDao.getRoleById(checkLogin);
            if (checkLogin != 0 && checkRole != 0 && checkLogin != 0) {
                String userId = checkLogin + "";
                HttpSession session = request.getSession();

                if (checkRole == 1) {
                    Cookie c = new Cookie("phienAdmin", userId);
                    // thiết lập thời gian hết hạn của cookie
                    c.setMaxAge(60 * 10 * 3);
                    // đẩy file xuống máy người dùng
                    response.addCookie(c);
                    response.sendRedirect("Admin");
                } else if (checkRole == 2) {

                } else if (checkRole == 3) {
                    response.sendRedirect("Index");
                } else if (checkRole == 4) {

                } else if (checkRole == 5) {
                    Cookie c = new Cookie("phienCustomer", userId);
                    // thiết lập thời gian hết hạn của cookie
                    c.setMaxAge(60 * 10 * 3);
                    // đẩy file xuống máy người dùng
                    response.addCookie(c);
                    session.setAttribute("customerName", userName);
                    session.setAttribute("customerId", userId);

                    response.sendRedirect("Index");
                }

            } else {
                response.sendRedirect("Login");
            }

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
