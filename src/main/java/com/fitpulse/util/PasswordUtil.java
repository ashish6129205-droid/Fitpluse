package com.fitpulse.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * BCrypt-based password hashing utility.
 */
public class PasswordUtil {

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty() ||
            hashedPassword == null || hashedPassword.trim().isEmpty()) {
            return false;
        }
        try {
            // jBCrypt supports $2a$. If the hash is $2b$ or $2y$ (common in other languages),
            // we replace the prefix with $2a$ so jBCrypt can verify it successfully.
            String normalizedHash = hashedPassword;
            if (normalizedHash.startsWith("$2b$") || normalizedHash.startsWith("$2y$")) {
                normalizedHash = "$2a$" + normalizedHash.substring(4);
            }
            return BCrypt.checkpw(plainPassword, normalizedHash);
        } catch (Exception e) {
            return false;
        }
    }
}
