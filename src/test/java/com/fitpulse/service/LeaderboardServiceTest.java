// Stream API Analytics & JUnit Test Verification
// Reviewed by: Shravan Soam (Reg No: 25SCSE1180127)
```[span_9](start_span)[span_9](end_span)
package com.fitpulse.service;

import com.fitpulse.model.UserRank;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class LeaderboardServiceTest {

    @Test
    void testLeaderboardSortingOrder() {
        List<UserRank> ranks = new ArrayList<>();

        UserRank user1 = new UserRank(1, "Alice");
        user1.addCalories(1000); // 1000 kcal, 0 challenges

        UserRank user2 = new UserRank(2, "Bob");
        user2.addCalories(1500); // 1500 kcal, 1 challenge
        user2.incrementCompletedChallenges();

        UserRank user3 = new UserRank(3, "Charlie");
        user3.addCalories(1500); // 1500 kcal, 2 challenges
        user3.incrementCompletedChallenges();
        user3.incrementCompletedChallenges();

        UserRank user4 = new UserRank(4, "Dave");
        user4.addCalories(500); // 500 kcal, 0 challenges

        ranks.add(user1);
        ranks.add(user2);
        ranks.add(user3);
        ranks.add(user4);

        user2.setWorkoutCount(5);
        user3.setWorkoutCount(10);
        user1.setWorkoutCount(3);
        user4.setWorkoutCount(1);

        // Sort by Total Calories (desc), then Workout Count (desc)
        List<UserRank> sorted = ranks.stream()
                .sorted(Comparator.comparing(UserRank::getTotalCalories).reversed()
                        .thenComparing(UserRank::getWorkoutCount, Comparator.reverseOrder()))
                .collect(Collectors.toList());

        assertEquals("Charlie", sorted.get(0).getUserName()); // 1500, 10
        assertEquals("Bob", sorted.get(1).getUserName()); // 1500, 5
        assertEquals("Alice", sorted.get(2).getUserName()); // 1000, 3
        assertEquals("Dave", sorted.get(3).getUserName()); // 500, 1
    }
}
