/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.room;

import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "ViewRooms", urlPatterns = {"/ViewRooms"})
public class ViewRooms extends HttpServlet {

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
            out.println("<title>Servlet ListRooms</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListRooms at " + request.getContextPath() + "</h1>");
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
        RoomDao roomDao = new RoomDao();
        int totalCard = 0;
        int totalRooms = 0;
        int finalRooms = 0;

        if (request.getParameter("totalCard") != null && Boolean.parseBoolean(request.getParameter("firstSearchValues")) == false) {
            totalCard = Integer.parseInt(request.getParameter("totalCard"));
        }

        if ((request.getParameter("locationSearch") == null || request.getParameter("locationSearch").equals(""))
                && (Boolean.parseBoolean(request.getParameter("checkSearchValues")) == false || request.getParameter("checkSearchValues") == null)) {
            totalRooms = roomDao.getCountRooms();
            if (totalRooms > 6) {
                finalRooms = totalRooms - (totalCard + 6);
                if (finalRooms < 0) {
                    finalRooms = 0;
                }
            } else {
                finalRooms = 0;
            }
            List<Rooms> list2 = roomDao.getFullRooms(totalCard);
            if (request.getParameter("totalCard") == null) {
                request.setAttribute("list", list2);
                request.getRequestDispatcher("room/viewRooms.jsp").forward(request, response);
                HttpSession session = request.getSession();
                session.setAttribute("finalRooms", finalRooms);
            } else {
                // Trả dữ liệu cho AJAX
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                for (Rooms room : list2) {
                    out.println("  <article class=\"card\" role=\"listitem\" tabindex=\"0\" aria-label=\"\">\n"
                            + "    <a href=\"ViewRoomDetail?id=" + room.getRoomId() + "\" style=\"text-decoration: none;\">\n"
                            + "      <img src=\"" + room.getImageUrl() + "\" alt=\"\" />\n"
                            + "      <div class=\"card-content\">\n"
                            + "        <h2 class=\"room-title\">" + room.getRoomType() + "</h2>\n"
                            + "        <p class=\"room-desc\">" + room.getDescription() + "</p>\n"
                            + "        <div class=\"price\">" + room.getPrice() + " / Room</div>\n"
                            + "        <button class=\"btn-book\" aria-label=\"\">View Details</button>\n"
                            + "      </div>\n"
                            + "    </a>\n"
                            + "  </article>");
                }
                out.println("<div id='remaining-rooms' style='display:none;'>" + finalRooms + "</div>");
            }
        } else {
            String location = request.getParameter("locationSearch");
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkInSearch"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOutSearch"));
            int adults = Integer.parseInt(request.getParameter("adultsSearch"));
            int children = Integer.parseInt(request.getParameter("childrenSearch"));
            HttpSession session = request.getSession();
            session.setAttribute("location", location);
            session.setAttribute("checkIn", checkIn);
            session.setAttribute("checkOut", checkOut);
            session.setAttribute("adults", adults);
            session.setAttribute("children", children);
            int people = adults + children;
            List<Rooms> list1 = roomDao.getSearchRooms(location, checkIn, checkOut, people, totalCard);
            totalRooms = roomDao.getCountRoomsSearch(location, checkIn, checkOut, people);
            if (totalRooms > 6) {
                finalRooms = totalRooms - (totalCard + 6);
                if (finalRooms < 0) {
                    finalRooms = 0;
                }
            } else {
                finalRooms = 0;
            }

            // Trả dữ liệu cho AJAX
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            for (Rooms room : list1) {
                out.println("  <article class=\"card\" role=\"listitem\" tabindex=\"0\" aria-label=\"\">\n"
                        + "    <a href=\"ViewRoomDetail?id=" + room.getRoomId() + "\" style=\"text-decoration: none;\">\n"
                        + "      <img src=\"" + room.getImageUrl() + "\" alt=\"\" />\n"
                        + "      <div class=\"card-content\">\n"
                        + "        <h2 class=\"room-title\">" + room.getRoomType() + "</h2>\n"
                        + "        <p class=\"room-desc\">" + room.getDescription() + "</p>\n"
                        + "        <div class=\"price\">" + room.getPrice() + " / Room</div>\n"
                        + "        <button class=\"btn-book\" aria-label=\"\">View Details</button>\n"
                        + "      </div>\n"
                        + "    </a>\n"
                        + "  </article>");

            }
            out.println("<div id='remaining-rooms' style='display:none;'>" + finalRooms + "</div>");

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
        processRequest(request, response);
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
