package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityUtil {
    public String encryptSHA256(String str) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(str.getBytes());
            byte[] byteData = messageDigest.digest();
            StringBuilder sb = new StringBuilder();

            for (byte byteDatum : byteData) {
                sb.append(Integer.toString((byteDatum & 0xFF) + 0x100, 16).substring(1));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return null;
    }
}
