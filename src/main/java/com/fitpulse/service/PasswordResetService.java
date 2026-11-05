package com.fitpulse.service;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class PasswordResetService {

    // Simple in-memory token store for MVP
    private static final Map<String, String> tokenToEmailMap = new ConcurrentHashMap<>();

    public static String generateToken(String email) {
        String token = UUID.randomUUID().toString();
        tokenToEmailMap.put(token, email);
        return token;
    }

    public static String getEmailForToken(String token) {
        return tokenToEmailMap.get(token);
    }

    public static void removeToken(String token) {
        tokenToEmailMap.remove(token);
    }
}
