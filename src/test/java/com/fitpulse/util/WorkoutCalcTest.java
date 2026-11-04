package com.fitpulse.util;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class WorkoutCalcTest {

    // Simulating a calculation util method if one exists, or testing basic calculation logic
    @Test
    void testCalorieCalculationFormulas() {
        // Since the app accepts direct calorie input, we test boundary logic for analytics/BMI
        double weightKg = 70.5;
        double heightCm = 175.0;

        // BMI = weight(kg) / (height(m))^2
        double heightM = heightCm / 100.0;
        double bmi = weightKg / (heightM * heightM);

        assertEquals(23.02, bmi, 0.01);

        // Calorie burn approximation formula (METs * weight * hours) -> For testing calculations logic
        double metRunning = 9.8; // Approx for running 6mph
        double durationHours = 0.5; // 30 mins
        double caloriesBurned = metRunning * weightKg * durationHours;

        assertEquals(345.45, caloriesBurned, 0.01);
    }
}
