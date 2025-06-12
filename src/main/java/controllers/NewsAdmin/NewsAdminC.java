/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.NewsAdmin;

import dao.NewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import models.News;

/**
 *
 * @author dodan
 */
@WebServlet(name = "NewsAdminC", urlPatterns = {"/NewsAdminC"})
public class NewsAdminC extends HttpServlet {

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
            out.println("<title>Servlet NewsAdminC</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewsAdminC at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("newsAdmin/newsAdminC.jsp").forward(request, response);
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
            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            String imageURL = request.getParameter("imageURL");
            String content = request.getParameter("content");
            boolean isPublished = Boolean.parseBoolean(request.getParameter("isPublished"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int buildingID = Integer.parseInt(request.getParameter("buildingID"));

            // Tạo đối tượng News mới
            News news = new News();
            news.setTitle(title);
            news.setSummary(summary);
            news.setImageURL(imageURL);
            news.setContent(content);
            news.setIsPublished(isPublished);
            news.setUserId(userId);
            news.setBuildingID(buildingID);

            // Set ngày giờ hiện tại
            Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
            news.setDatePosted(currentTimestamp);

            // Thêm tin tức vào database
            NewDAO dao = new NewDAO();
            int check = dao.create(news); // Bạn cần đảm bảo phương thức này tồn tại và đúng cấu trúc

            if (check != 0) {
                response.sendRedirect("NewsAdminR");
            } else {
                request.getRequestDispatcher("newsAdmin/newsAdminC.jsp").forward(request, response);
            }
            // Sau khi thêm thành công, chuyển hướng về danh sách tin tức hoặc trang xác nhận
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi tạo tin tức: " + e.getMessage());
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
