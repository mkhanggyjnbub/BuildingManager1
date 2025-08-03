/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.admin;

import dao.UserDao;
import db.FileUploader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Date;
import java.util.Arrays;
import models.Users;

/**
 *
 * @author dodan
 */
@MultipartConfig
@WebServlet(name = "EditUserProfile", urlPatterns = {"/EditUserProfile"})
public class EditUserProfile extends HttpServlet {

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
            out.println("<title>Servlet EditUserProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditUserProfile at " + request.getContextPath() + "</h1>");
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
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UserDao dao = new UserDao(); // hoặc AdminDao nếu dùng riêng
            Users user = dao.getUserByIdForEdit(id);

            if (user != null) {
                request.setAttribute("userInfomation", user);
                request.setAttribute("userId", id);
            } else {
                request.setAttribute("message", "User not found.");
            }

            request.getRequestDispatcher("admin/editUserProfile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid request.");
            request.getRequestDispatcher("admin/editUserProfile.jsp").forward(request, response);
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
        try {
            String uid = request.getParameter("uid");
            System.out.println("uid: " +uid);
            
            
            String fullName = request.getParameter("fullName");
            System.out.println("fullName: " +fullName);
            String address = request.getParameter("address");
            System.out.println("address: " +address);
            String gender = request.getParameter("gender");
            System.out.println("gender: " +gender);
            Date dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
            System.out.println("dateOfBirth: " +dateOfBirth);
            Part filePart = request.getPart("imageFile");
            String oldAvatar = request.getParameter("oldAvatar");
            System.out.println("oldAvatar: " +oldAvatar);
            

            int id = Integer.parseInt(uid);
            String uploadedUrl = null;
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
                String fileName = FileUploader.uploadImage(filePart, uploadPath);
                uploadedUrl = "images/" + fileName;
            } else {
                uploadedUrl = oldAvatar;
            }

            Users user = new Users(); // hoặc Admin
            user.setFullName(fullName);
            user.setAddress(address);
            user.setGender(gender);
            user.setDayOfBirth(dateOfBirth);
            user.setAvatarUrl(uploadedUrl);

            UserDao dao = new UserDao();
            int check = dao.updateUserProfileById(id, user);

            if (check != 0) {
                response.sendRedirect("ViewUserProfile?id=" + id);
            } else {
                request.setAttribute("message", "Cập nhật thất bại.");
                response.sendRedirect("EditUserProfile?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Đã xảy ra lỗi.");
            request.getRequestDispatcher("admin/editUserProfile.jsp").forward(request, response);
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
