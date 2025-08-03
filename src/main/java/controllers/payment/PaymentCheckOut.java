/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.payment;

import dao.BookingDao;
import dao.ExtraChargeDao;
import dao.InvoiceDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Bookings;
import models.ExtraCharge;
import models.Invoices;

/**
 *
 * @author dodan
 */
@WebServlet(name = "PaymentCheckOut", urlPatterns = {"/PaymentCheckOut"})
public class PaymentCheckOut extends HttpServlet {

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
            out.println("<title>Servlet PaymentCheckOut</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentCheckOut at " + request.getContextPath() + "</h1>");
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
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // Lấy booking
            BookingDao bookingDao = new BookingDao();
            Bookings booking = bookingDao.getBookingById(bookingId);
            request.setAttribute("booking", booking);

            // Tính tổng phụ thu (price)
            ExtraChargeDao extraChargeDao = new ExtraChargeDao();
            List<ExtraCharge> extraCharges = extraChargeDao.getByBookingId(bookingId);

            long price = 0;
            for (ExtraCharge ec : extraCharges) {
                price += ec.getUnitPrice() * ec.getQuantity();
            }
            request.setAttribute("price", price);

            // Lấy hóa đơn
            InvoiceDao invoiceDao = new InvoiceDao();
            Invoices invoice = invoiceDao.getByBookingId(bookingId);
            if (invoice != null) {
                System.out.println("invoice k null");
            }
            request.setAttribute("invoice", invoice);

            // Chuyển tiếp sang JSP
            request.getRequestDispatcher("payment/paymentCheckOut.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int totalPayable = Integer.parseInt(request.getParameter("totalPayable"));

            InvoiceDao invoiceDao = new InvoiceDao();
            Invoices invoice = invoiceDao.getByBookingId(bookingId);

            if (invoice == null) {
                request.setAttribute("error", "Invoice not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            invoiceDao.updatePayment(invoice.getInvoiceId(), totalPayable);

            BookingDao daoB = new BookingDao();
            daoB.updateStatusCheckOut(bookingId);
            // Chuyển về trang thông báo hoặc dashboard
            request.setAttribute("message", "Payment Successfully");
            response.sendRedirect("ViewAllCheckInOutDashboard");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid data.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
