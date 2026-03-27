package mahesh.project.FlightReservation.util;

import java.io.ByteArrayOutputStream;
import java.util.List;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.google.zxing.*;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.Flight;

public class TicketPDFGenerator {

	public static byte[] generate(Flight flight, List<Booking> bookings, double total) {

	    try {
	        ByteArrayOutputStream out = new ByteArrayOutputStream();

	        Document doc = new Document(PageSize.A4, 20, 20, 20, 20);
	        PdfWriter.getInstance(doc, out);
	        doc.open();

	        String pnr = bookings.get(0).getPnr();

	        Font whiteBold = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, BaseColor.WHITE);
	        Font bold = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
	        Font big = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD);
	        Font normal = new Font(Font.FontFamily.HELVETICA, 10);
	        Font small = new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.GRAY);

	        // ================= HEADER =================
	        PdfPTable header = new PdfPTable(2);
	        header.setWidthPercentage(100);

	        PdfPCell left = new PdfPCell(new Phrase("SKYBOOK", whiteBold));
	        left.setBackgroundColor(new BaseColor(0, 51, 153)); // Indigo Blue
	        left.setBorder(Rectangle.NO_BORDER);
	        left.setPadding(12);

	        PdfPCell right = new PdfPCell(new Phrase("BOARDING PASS\nPNR: " + pnr, whiteBold));
	        right.setHorizontalAlignment(Element.ALIGN_RIGHT);
	        right.setBackgroundColor(new BaseColor(0, 51, 153));
	        right.setBorder(Rectangle.NO_BORDER);
	        right.setPadding(12);

	        header.addCell(left);
	        header.addCell(right);

	        doc.add(header);
	        doc.add(new Paragraph("\n"));
	        doc.add(new Chunk(line()));
	        doc.add(space());

	        // ================= ROUTE =================
	        PdfPTable route = new PdfPTable(3);
	        route.setWidthPercentage(100);

	        route.addCell(centerBold(getCode(flight.getSource()), 26));
	        route.addCell(centerBold("✈", 20));
	        route.addCell(centerBold(getCode(flight.getDestination()), 26));

	        route.addCell(centerNormal(flight.getSource()));
	        route.addCell(centerNormal(flight.getFlightName()));
	        route.addCell(centerNormal(flight.getDestination()));

	        doc.add(route);
	        doc.add(space());
	        doc.add(new Chunk(line()));
	        doc.add(space());

	        // ================= TIMING =================
	        PdfPTable time = new PdfPTable(2);
	        time.setWidthPercentage(100);

	        time.addCell(infoBox("DEPARTURE", flight.getDepartureTime()));
	        time.addCell(infoBox("ARRIVAL", flight.getArrivalTime()));
	        doc.add(time);
	        doc.add(space());

	        // ================= BOARDING INFO =================
	        PdfPTable info = new PdfPTable(4);
	        info.setWidthPercentage(100);

	        info.addCell(info("DATE", flight.getFlightDate().toString()));
	        info.addCell(info("FLIGHT", flight.getFlightName()));
	        info.addCell(info("CLASS", "ECONOMY"));
	        info.addCell(info("STATUS", "CONFIRMED"));

	        doc.add(info);
	        doc.add(space());

	        // ================= PASSENGER =================
	        Paragraph p = new Paragraph("PASSENGER", bold);
	        p.setSpacingAfter(5);
	        doc.add(p);

	        PdfPTable table = new PdfPTable(4);
	        table.setWidthPercentage(100);

	        table.addCell(headerCell("Name"));
	        table.addCell(headerCell("Seat"));
	        table.addCell(headerCell("Age"));
	        table.addCell(headerCell("Gender"));

	        for (Booking b : bookings) {
	            table.addCell(cell(b.getPassengerName()));
	            table.addCell(cell(b.getSeatNumber()));
	            table.addCell(cell(String.valueOf(b.getPassengerAge())));
	            table.addCell(cell(b.getGender()));
	        }

	        doc.add(table);
	        doc.add(space());

	        // ================= QR + BOARDING =================
	        PdfPTable qrTable = new PdfPTable(2);
	        qrTable.setWidthPercentage(100);

	        PdfPCell leftInfo = new PdfPCell(new Phrase(
	                "GATE: A1\nBOARDING: 30 MIN BEFORE\nSEAT: " + bookings.get(0).getSeatNumber(),
	                bold));
	        leftInfo.setBorder(Rectangle.NO_BORDER);
	        leftInfo.setPadding(10);

	        String qrData = "PNR:" + pnr +
	                "|FROM:" + flight.getSource() +
	                "|TO:" + flight.getDestination() +
	                "|FLIGHT:" + flight.getFlightName() +
	                "|DATE:" + flight.getFlightDate();

	        BitMatrix matrix = new MultiFormatWriter()
	                .encode(qrData, BarcodeFormat.QR_CODE, 180, 180);

	        ByteArrayOutputStream png = new ByteArrayOutputStream();
	        MatrixToImageWriter.writeToStream(matrix, "PNG", png);

	        Image qr = Image.getInstance(png.toByteArray());
	        qr.scaleToFit(140, 140);

	        PdfPCell qrCell = new PdfPCell(qr);
	        qrCell.setBorder(Rectangle.NO_BORDER);
	        qrCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

	        qrTable.addCell(leftInfo);
	        qrTable.addCell(qrCell);

	        doc.add(qrTable);
	        doc.add(space());
	        
	        Paragraph fare = new Paragraph("TOTAL PAID: ₹" + total, bold);
	        fare.setAlignment(Element.ALIGN_RIGHT);
	        doc.add(fare);
	        
	        doc.add(space());

	        // ================= FOOTER =================
	        Paragraph footer = new Paragraph(
	                "This is a system generated ticket | No signature required\n" +
	                "Arrive at airport 2 hours before departure | www.skybook.com",
	                small);
	        footer.setAlignment(Element.ALIGN_CENTER);
	        doc.add(footer);

	        doc.close();
	        return out.toByteArray();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

    // 🔧 Helpers
    private static PdfPCell cell(String text) {
        PdfPCell c = new PdfPCell(new Phrase(text));
        c.setPadding(8);
        return c;
    }

    private static PdfPCell headerCell(String text) {
        PdfPCell c = new PdfPCell(new Phrase(text,
            new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.WHITE)));
        c.setBackgroundColor(new BaseColor(0, 102, 204)); // airline blue
        c.setPadding(10);
        return c;
    }

    private static PdfPCell infoCell(String title, String value) {
        PdfPCell c = new PdfPCell(new Phrase(title + "\n" + value));
        c.setPadding(10);
        return c;
    }

    private static PdfPCell centerCell(String text, int size, boolean bold) {
        Font f = new Font(Font.FontFamily.HELVETICA, size, bold ? Font.BOLD : Font.NORMAL);
        PdfPCell c = new PdfPCell(new Phrase(text, f));
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setBorder(Rectangle.NO_BORDER);
        return c;
    }
    private static Paragraph space() {
        return new Paragraph("\n");
    }

    private static PdfPCell centerBold(String text, int size) {
        Font f = new Font(Font.FontFamily.HELVETICA, size, Font.BOLD);
        PdfPCell c = new PdfPCell(new Phrase(text, f));
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setBorder(Rectangle.NO_BORDER);
        return c;
    }

    private static PdfPCell centerNormal(String text) {
        Font f = new Font(Font.FontFamily.HELVETICA, 10);
        PdfPCell c = new PdfPCell(new Phrase(text, f));
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setBorder(Rectangle.NO_BORDER);
        return c;
    }

    private static PdfPCell infoBox(String title, String value) {
        PdfPCell c = new PdfPCell(new Phrase(
                title + "\n" + value,
                new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD)
        ));
        c.setPadding(8);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        return c;
    }
    private static PdfPCell center(Font f, String text) {
        PdfPCell c = new PdfPCell(new Phrase(text, f));
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setBorder(Rectangle.NO_BORDER);
        return c;
    }
    private static PdfPCell info(String title, String value) {
        PdfPCell c = new PdfPCell(new Phrase(
                title + "\n" + value,
                new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD)
        ));
        c.setPadding(8);
        return c;
    }
    private static String getCode(String city) {
        return city.substring(0, 3).toUpperCase(); // PNQ, DEL style
    }
    private static LineSeparator line() {
        LineSeparator ls = new LineSeparator();
        ls.setLineWidth(1f);
        ls.setPercentage(100);
        return ls;
    }
}