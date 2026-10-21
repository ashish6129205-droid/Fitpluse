package com.fitpulse.util;

import org.junit.jupiter.api.Test;
import java.sql.Date;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

class ValidationUtilTest {

    @Test
    void testValidEmail() {
        assertTrue(ValidationUtil.isValidEmail("user@example.com"));
        assertTrue(ValidationUtil.isValidEmail("admin.name+tag@fitpulse.demo"));
        assertFalse(ValidationUtil.isValidEmail("invalid-email"));
        assertFalse(ValidationUtil.isValidEmail(""));
        assertFalse(ValidationUtil.isValidEmail(null));
    }

    @Test
    void testPasswordStrength() {
        assertTrue(ValidationUtil.isValidPassword("StrongPass123"));
        assertFalse(ValidationUtil.isValidPassword("weak")); // Too short
        assertFalse(ValidationUtil.isValidPassword("alllowercase123")); // No uppercase
        assertFalse(ValidationUtil.isValidPassword("NO_NUMBERS_HERE")); // No numbers
        assertFalse(ValidationUtil.isValidPassword(null));
    }

    @Test
    void testWorkoutBoundaries() {
        Date today = Date.valueOf(LocalDate.now());
        Date tomorrow = Date.valueOf(LocalDate.now().plusDays(1));

        assertTrue(ValidationUtil.isValidWorkout(60, 500, today));

        // Negative duration
        assertFalse(ValidationUtil.isValidWorkout(-10, 500, today));
        // Zero duration
        assertFalse(ValidationUtil.isValidWorkout(0, 500, today));
        // Negative calories
        assertFalse(ValidationUtil.isValidWorkout(60, -50, today));
        // Future date
        assertFalse(ValidationUtil.isValidWorkout(60, 500, tomorrow));
        // Null date
        assertFalse(ValidationUtil.isValidWorkout(60, 500, null));
    }
}
