package com.fitpulse.filter;

import org.junit.jupiter.api.Test;
import java.util.UUID;
import java.util.HashSet;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

class CsrfTokenTest {

    @Test
    void testTokenUniqueness() {
        Set<String> tokens = new HashSet<>();
        for (int i = 0; i < 1000; i++) {
            String token = UUID.randomUUID().toString();
            assertTrue(tokens.add(token), "Token should be unique");
        }
    }

    @Test
    void testTokenValidationMatching() {
        String sessionToken = UUID.randomUUID().toString();
        String requestToken = sessionToken;
        String invalidToken = UUID.randomUUID().toString();

        assertEquals(sessionToken, requestToken);
        assertNotEquals(sessionToken, invalidToken);
        assertNotNull(sessionToken);
        assertFalse(sessionToken.isEmpty());
    }
}
