/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.room;

import dao.BookingDao;
import dao.RoomDao;
import dao.RoomReviewDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Amenities;
import models.RoomReviews;
import models.Rooms;

import models.Amenities;
import models.RoomReviews;
import models.Rooms;

/**
 *
 * @author dodan
 */
@WebServlet("/ViewRoomDetail")

public class ViewRoomDetail extends HttpServlet {

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
            out.println("<title>Servlet ViewRoomDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRoomDetail at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        session.removeAttribute("voucherId");
        session.removeAttribute("voucherCode");
        session.removeAttribute("voucherdiscountPercent1");

        int id = Integer.parseInt(request.getParameter("id"));
        float totalRating = 0;
        RoomDao roomDao = new RoomDao();

        Rooms room = roomDao.getRoomDetail(id);
        request.setAttribute("room", room);

        int numberOfReview = roomDao.getNumberOfReview(id);
        request.setAttribute("numberOfReview", numberOfReview);
        if (numberOfReview > 0) {
            totalRating = roomDao.getTotalRating(id, numberOfReview);

        } else {
            totalRating = 0;
        }
        request.setAttribute("totalRating", totalRating);

        List<Amenities> listAmenites = roomDao.getAmenities(id);
        request.setAttribute("listAmenites", listAmenites);

        List<RoomReviews> customerReview = roomDao.getCustomerReviews(id);
        request.setAttribute("customerReview", customerReview);

        request.getRequestDispatcher("room/viewRoomDetail.jsp").forward(request, response);

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
        Object cusObj = session.getAttribute("customerId");

        if (cusObj == null) {
            response.sendRedirect("Login");
            return;
        }

        int customerId = Integer.parseInt(cusObj.toString());
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        BookingDao bookingDao = new BookingDao();
        RoomReviewDao reviewDao = new RoomReviewDao();

        int bookingCount = bookingDao.countBookingsByRoomAndCustomer(roomId, customerId);
        System.out.println("bookingCount" + bookingCount);

        int reviewCount = reviewDao.countReviewsByRoomAndCustomer(roomId, customerId);
        System.out.println("reviewCount" + reviewCount);
        if (bookingCount > reviewCount) {
            int cnt = reviewDao.addReview(roomId, customerId, rating, comment);
            response.sendRedirect("ViewRoomDetail?id=" + roomId);
        } else {
            // Không cho gửi review, quay lại trang và gán lỗi
            request.setAttribute("roomId", roomId); // gửi lại roomId
            request.setAttribute("reviewError", "You have not booked this room or have rated it enough times.");

            // Lấy lại dữ liệu phòng và review để hiển thị
            RoomDao roomDao = new RoomDao();
            Rooms room = roomDao.getRoomDetail(roomId);
            List<RoomReviews> customerReview = reviewDao.getReviewsByRoomId(roomId);
            request.setAttribute("room", room);
            request.setAttribute("customerReview", customerReview);
            request.getRequestDispatcher("room/viewRoomDetail.jsp").forward(request, response);
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
