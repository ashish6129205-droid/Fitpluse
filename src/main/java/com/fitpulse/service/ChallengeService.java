package com.fitpulse.service;

import com.fitpulse.dao.ChallengeDao;
import com.fitpulse.dao.impl.ChallengeDaoImpl;
import com.fitpulse.model.Challenge;
import com.fitpulse.model.ChallengeParticipant;

import java.util.List;

public class ChallengeService {

    private final ChallengeDao challengeDao;

    public ChallengeService() {
        this.challengeDao = new ChallengeDaoImpl();
    }

    public void addChallenge(Challenge challenge) {
        challengeDao.create(challenge);
    }

    public List<Challenge> getAllChallenges() {
        return challengeDao.findAll();
    }

    public List<Challenge> getActiveChallenges() {
        return challengeDao.findActiveChallenges();
    }

    public Challenge getChallengeById(int id) {
        return challengeDao.findById(id);
    }

    public void updateChallenge(Challenge challenge) {
        challengeDao.update(challenge);
    }

    public void deleteChallenge(int id) {
        challengeDao.delete(id);
    }

    public void joinChallenge(int userId, int challengeId) {
        challengeDao.joinChallenge(userId, challengeId);
    }

    public List<Integer> getJoinedChallengeIds(int userId) {
        return challengeDao.getJoinedChallengeIds(userId);
    }

    public List<ChallengeParticipant> getJoinedChallengesHistory(int userId) {
        return challengeDao.getJoinedChallenges(userId);
    }
}
