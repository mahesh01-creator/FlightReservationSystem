package mahesh.project.FlightReservation.util;

import java.io.ByteArrayOutputStream;
import java.util.Base64;

import com.google.zxing.*;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

public class QRCodeGenerator {

    public static String generateBase64QR(String text) {
        try {
            BitMatrix matrix = new MultiFormatWriter().encode(
                    text,
                    BarcodeFormat.QR_CODE,
                    200,
                    200
            );

            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(matrix, "PNG", stream);

            return Base64.getEncoder().encodeToString(stream.toByteArray());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}