
package com.mycompany.jv24_spring_project_final.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PasswordUtil {
    public static String hashPassword(String password) {
        StringBuilder sb = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            
            byte[] bytes = md.digest();
            
            sb = new StringBuilder();
            
            for(byte b : bytes) {
                int v = b & 0xff;   //he nhi phan gom 8 so 1
                if (v < 16) {
                    sb.append('0');
                }
                sb.append(Integer.toHexString(v));
            }

            
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(PasswordUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sb.toString();
    }
    
    public static String saltPassword(String password) throws NoSuchAlgorithmException {
        Random r = new SecureRandom();
        byte[] saltBytes = new byte[32];
        
        r.nextBytes(saltBytes);
        
        String salt = Base64.getEncoder().encodeToString(saltBytes);
        return hashPassword(salt+password);
    }
}
