///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controllers.cloudinary;
//
//import com.cloudinary.Cloudinary;
//import com.cloudinary.utils.ObjectUtils;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.Part;
//import java.io.InputStream;
//import java.util.HashMap;
//import java.util.Map;
//
///**
// *
// * @author Kiều Hoàng Mạnh Khang - ce180749
// */
//@MultipartConfig
//@WebServlet(name = "CloudinaryUpload", urlPatterns = {"/CloudinaryUpload"})
//public class CloudinaryUpload extends HttpServlet {
//
//    private Cloudinary cloudinary;
//
//    @Override
//    public void init() throws ServletException {
//        // Cấu hình Cloudinary
//        Map<String, String> config = new HashMap<>();
//        config.put("cloud_name", "dmkdqxqx6"); // thay bằng cloud_name của bạn
//        config.put("api_key", "813724666765833");
//        config.put("api_secret", "rE6HgCAE0wMLSB1naRnhhU2wAmk");
//
//        cloudinary = new Cloudinary(config);
//    }
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet CloudinaryUpload</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet CloudinaryUpload at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("cloudinary/cloudinaryUpload.jsp").forward(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        Part filePart = request.getPart("file"); // Lấy file từ form
//        if (filePart != null && filePart.getSize() > 0) {
//            InputStream inputStream = filePart.getInputStream(); // Đây là InputStream hợp lệ
//
//            Map uploadResult = cloudinary.uploader().upload(inputStream, ObjectUtils.asMap(
//                    "resource_type", "auto",
//                    "public_id", "your_folder/" + filePart.getSubmittedFileName(),
//                    "overwrite", true
//            ));
//
//            String imageUrl = (String) uploadResult.get("secure_url");
//            request.setAttribute("imageUrl", imageUrl);
//            request.getRequestDispatcher("result.jsp").forward(request, response);
//        }
//
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
