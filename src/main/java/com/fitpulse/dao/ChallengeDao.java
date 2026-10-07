package com.fitpulse.dao;

import com.fitpulse.model.Challenge;
import com.fitpulse.model.ChallengeParticipant;
import java.util.List;

public interface ChallengeDao {
    Challenge findById(int id);
    List<Challenge> findAll();
    List<Challenge> findActiveChallenges();
    void create(Challenge challenge);
    void update(Challenge challenge);
    void delete(int id);
    void joinChallenge(int userId, int challengeId);
    List<Integer> getJoinedChallengeIds(int userId);
    List<ChallengeParticipant> getJoinedChallenges(int userId);
    List<ChallengeParticipant> findAllParticipants();
}
