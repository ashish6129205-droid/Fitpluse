package com.fitpulse.dao;

import com.fitpulse.model.Challenge;
import java.util.List;

public interface ChallengeDao {
    Challenge findById(int id);
    List<Challenge> findAll();
    List<Challenge> findActiveChallenges();
    void create(Challenge challenge);
    void update(Challenge challenge);
    void delete(int id);
}
