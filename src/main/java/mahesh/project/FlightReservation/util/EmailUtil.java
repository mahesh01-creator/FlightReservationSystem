package mahesh.project.FlightReservation.util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.mail.util.ByteArrayDataSource;
import jakarta.activation.*;

public class EmailUtil {

    public static void sendTicketEmail(String toEmail, String subject, String htmlContent, byte[] pdfBytes) {

        final String fromEmail = "mayurlohar293@gmail.com";
        final String password = "ixthnhkeiyvygrql";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // 🔥 PART 1: HTML BODY
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(htmlContent, "text/html");

            // 🔥 PART 2: PDF ATTACHMENT
            MimeBodyPart attachmentPart = new MimeBodyPart();
            DataSource source = new ByteArrayDataSource(pdfBytes, "application/pdf");
            attachmentPart.setDataHandler(new DataHandler(source));
            attachmentPart.setFileName("SkyBook-Ticket.pdf");

            // 🔥 COMBINE BOTH
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            Transport.send(message);

            System.out.println("✅ Ticket Email Sent Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
    }
    public static String generateEmailTemplate(
            String pnr,
            String[] names,
            String seats,
            double total,
            String from,
            String to,
            String date
    ) {

        String qrText = "PNR: " + pnr + ", Route: " + from + " to " + to;
        String qrBase64 = QRCodeGenerator.generateBase64QR(qrText);

        return "<div style='font-family:Poppins;background:#0f172a;padding:30px;color:white;'>"

                + "<div style='max-width:650px;margin:auto;background:#1e293b;padding:25px;border-radius:20px;'>"

                + "<h2 style='text-align:center;color:#38bdf8;'>SkyBook Boarding Pass</h2>"

                + "<hr style='border:1px dashed #334155'/>"

                // ROUTE
                + "<h3 style='text-align:center;color:#22c55e;'>"
                 + from + " TO " + to + "</h3>"

                + "<p style='text-align:center;color:#94a3b8;'> " + date + "</p>"

                // DETAILS
                + "<p> <b>PNR:</b> " + pnr + "</p>"
                + "<p> <b>Passengers:</b><br>" + String.join("<br> ", names) + "</p>"
                + "<p> <b>Seats:</b> " + seats + "</p>"
                + "<p> <b>Total:</b> ₹" + total + "</p>"

                // QR CODE
                + "<div style='text-align:center;margin-top:20px;'>"
                + "<img src='data:image/png;base64," + qrBase64 + "' width='150'/>"
                + "<p style='font-size:12px;color:#94a3b8;'>Scan for ticket</p>"
                + "</div>"

                + "<hr style='border:1px dashed #334155;margin-top:20px'/>"

                + "<p style='text-align:center;color:#94a3b8;'> Have a safe journey</p>"

                + "</div></div>";
    }
}