package mainpackage.Utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class Encryption {
    // We need a bytesToHex method first. So, from -
    // http://stackoverflow.com/a/9855338/2970947
    final protected static char[] hexArray = "0123456789ABCDEF"
            .toCharArray();

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        int v;
        for (int j = 0; j < bytes.length; j++) {
            v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }

    // Change this to something else.


    // A password hashing method.
    public static String hashPassword(String in) {
        Random random = new Random();
        //Salt secret keycode
        String SALT = "109876543210";
        try {
            MessageDigest md = MessageDigest
                    .getInstance("SHA-256");
            md.update(SALT.getBytes());        // <-- Prepend SALT.
            md.update(in.getBytes());
            // md.update(SALT.getBytes());     // <-- Or, append SALT.

            byte[] out = md.digest();
            return bytesToHex(out);            // <-- Return the Hex Hash.
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }
}
