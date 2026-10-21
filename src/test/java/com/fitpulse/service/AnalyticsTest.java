package com.fitpulse.service;

import com.fitpulse.model.UserRank;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AnalyticsTest {

    @Test
    void testUserRankCalculations() {
        UserRank rank = new UserRank(1, "Test User");
        assertEquals(0, rank.getTotalCalories());
        assertEquals(0, rank.getCompletedChallenges());

        rank.addCalories(500);
        rank.addCalories(250);
        assertEquals(750, rank.getTotalCalories());

        rank.incrementCompletedChallenges();
        assertEquals(1, rank.getCompletedChallenges());
    }
}
