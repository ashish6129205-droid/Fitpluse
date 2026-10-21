package com.fitpulse.util;

import java.sql.Date;
import java.time.LocalDate;
import java.util.regex.Pattern;

/**
 * Utility class for validating user input and domain rules.
 */
public class ValidationUtil {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    /**
     * Validates email format.
     * @param email The email to validate.
     * @return true if valid, false otherwise.
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.isBlank()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Validates password strength.
     * Requires at least 8 characters, one digit, and one uppercase letter.
     * @param password The password to validate.
     * @return true if valid, false otherwise.
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        boolean hasDigit = false;
        boolean hasUpper = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) hasDigit = true;
            if (Character.isUpperCase(c)) hasUpper = true;
        }
        return hasDigit && hasUpper;
    }

    /**
     * Validates workout input boundaries.
     * @param durationMin Duration in minutes.
     * @param calories Calories burned.
     * @param workoutDate Date of the workout.
     * @return true if valid, false otherwise.
     */
    public static boolean isValidWorkout(int durationMin, int calories, Date workoutDate) {
        if (durationMin <= 0 || durationMin > 1440) { // Max 24 hours
            return false;
        }
        if (calories < 0 || calories > 20000) {
            return false;
        }
        if (workoutDate == null) {
            return false;
        }
        // Cannot log a workout in the future
        if (workoutDate.toLocalDate().isAfter(LocalDate.now())) {
            return false;
        }
        return true;
    }
}
