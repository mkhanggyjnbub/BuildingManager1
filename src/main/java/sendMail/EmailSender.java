/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sendMail;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class EmailSender {

    private final String fromEmail = "prokhang66@gmail.com";
    private final String password = "xtqoxbwttfcxwqgt";
    private Session session;

    public EmailSender() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
    }

    // Gửi email đơn giản
    public void sendSimpleEmail(String toEmail, String subject, String body) throws MessagingException {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(body);
        Transport.send(message);
    }

    // Gửi email HTML
    public void sendHTMLEmail(String toEmail, String subject,
            String fullName, int bookingId,
            LocalDateTime startDate, LocalDateTime endDate) throws MessagingException {

        try {
            String htmlContent = String.format(
                    "<div style='font-family:Segoe UI, sans-serif; background-color:#f2f2f2; padding:30px;'>"
                    + "  <div style='max-width:600px; margin:auto; background-color:#fff; border-radius:10px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.1);'>"
                    // HEADER
                    + "    <div style='background-color:#1A5276; color:white; padding:20px 30px; text-align: center;'>"
                    + "      <h1 style='margin:0; font-size:24px;'>Big Resort</h1>"
                    + "      <p style='margin:0; font-size:14px;'>Confirm booking</p>"
                    + "    </div>"
                    // BODY
                    + "    <div style='padding:30px;'>"
                    + "      <p style='font-size:16px;'>Hello <strong style='color:#1A5276;'>%s</strong>,</p>"
                    + "      <p>Thank you for choosing <strong>Big Resort</strong> for your vacation.</p>"
                    // BOOKING INFO
                    + "      <h3 style='color:#1A5276; border-bottom:1px solid #ddd; padding-bottom:5px;'>Reservation information</h3>"
                    + "      <table style='width:100%%; margin-top:10px; font-size:15px;'>"
                    + "        <tr><td style='padding:8px 0;'><strong>Reservation code:</strong></td><td>#%d</td></tr>"
                    + "        <tr><td style='padding:8px 0;'><strong>Start date:</strong></td><td>%s</td></tr>"
                    + "        <tr><td style='padding:8px 0;'><strong>End date:</strong></td><td>%s</td></tr>"
                    + "      </table>"
                    // POLICIES
                    + "      <h3 style='color:#1A5276; margin-top:30px;'>Policy note</h3>"
                    + "      <ul style='padding-left:20px; font-size:14px;'>"
                    + "        <li>Check-in requires ID card/CCCD or passport.</li>"
                    + "        <li>Cancellation 24 hours in advance is free of charge.</li>"
                    + "        <li>Children under 6 years old are free to sleep with parents.</li>"
                    + "      </ul>"
                    // CONTACT
                    + "      <p style='margin-top:30px;'>For any questions please contact: "
                    + "<a href='http://localhost:8080/Index' style='color:#1A5276;'>http://localhost:8080/Index</a></p>"
                    + "      <p>Best regards,<br/><strong>Big Resort team</strong></p>"
                    + "    </div>"
                    // FOOTER
                    + "    <div style='background-color:#f4f4f4; text-align:center; padding:15px; font-size:12px; color:#888;'>"
                    + "      © 2025 Big Resort. All rights reserved."
                    + "    </div>"
                    + "  </div>"
                    + "</div>",
                    fullName,
                    bookingId,
                    startDate.toLocalDate().toString(),
                    endDate.toLocalDate().toString()
            );

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "BigResort.Group6"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Gửi email có file đính kèm (tùy chọn thêm)
    public void sendEmailWithAttachment(String toEmail, String subject, String textBody, String filePath) throws MessagingException {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // Body part
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(textBody);

            // Attachment part
            MimeBodyPart attachmentPart = new MimeBodyPart();
            attachmentPart.attachFile(filePath);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);
            Transport.send(message);
        } catch (IOException ex) {
            Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
