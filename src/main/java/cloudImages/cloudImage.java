/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cloudImages;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// Import the required packages

import com.cloudinary.*;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Map;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@MultipartConfig
@WebServlet(name = "cloudImage", urlPatterns = {"/cloudImage"})
public class cloudImage extends HttpServlet {

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
            out.println("<title>Servlet cloudImage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cloudImage at " + request.getContextPath() + "</h1>");
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
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dmkdqxqx6",
                "api_key", "813724666765833",
                "api_secret", "rE6HgCAE0wMLSB1naRnhhU2wAmk"
        ));
        // Nhận phần file từ form HTML
        Part filePart = request.getPart("image");
        String title = request.getParameter("title");  // Nhận tiêu đề ảnh
        // Lưu tạm file lên server
        File tempFile = File.createTempFile("upload_", ".jpg");
        try ( InputStream input = filePart.getInputStream()) {
            Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // Upload file lên Cloudinary
        Map result = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
        String imageUrl = result.get("secure_url").toString();  // URL ảnh sau khi upload
        
        
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
