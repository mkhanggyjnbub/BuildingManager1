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
import models.News;

/**
 *
 * @author dodan
 */
@WebServlet(name = "NewsAdminU", urlPatterns = {"/NewsAdminU"})
public class NewsAdminU extends HttpServlet {

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
            out.println("<title>Servlet NewAdminU</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewAdminU at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        NewDAO dao = new NewDAO();
        News news = dao.getNewsById(id);
        request.setAttribute("news", news);
        request.getRequestDispatcher("newsAdmin/newsAdminU.jsp").forward(request, response);
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
            int newsID = Integer.parseInt(request.getParameter("newsID")); // đảm bảo đúng tên param
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            String imageURL = request.getParameter("imageURL");
            boolean isPublished = request.getParameter("isPublished") != null;
            int userId = Integer.parseInt(request.getParameter("userId"));
            int buildingID = Integer.parseInt(request.getParameter("buildingID"));
            String content = request.getParameter("content");

            News updatedNews = new News();
            updatedNews.setTitle(title);
            updatedNews.setSummary(summary);
            updatedNews.setImageURL(imageURL);
            updatedNews.setIsPublished(isPublished);
            updatedNews.setUserId(userId);
            updatedNews.setBuildingID(buildingID);
            updatedNews.setContent(content);

            NewDAO dao = new NewDAO();
            int result = dao.updateNews(newsID, updatedNews);

            if (result > 0) {
                response.sendRedirect("NewsAdminR");
            } else {
                response.getWriter().println("Không thể cập nhật tin tức.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
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
