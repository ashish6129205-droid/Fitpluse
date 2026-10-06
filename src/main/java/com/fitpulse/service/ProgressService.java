package com.fitpulse.service;

import com.fitpulse.dao.ProgressEntryDao;
import com.fitpulse.dao.impl.ProgressEntryDaoImpl;
import com.fitpulse.model.ProgressEntry;

import java.util.List;

public class ProgressService {

    private final ProgressEntryDao progressDao;

    public ProgressService() {
        this.progressDao = new ProgressEntryDaoImpl();
    }

    public void addProgress(ProgressEntry entry) {
        progressDao.create(entry);
    }

    public List<ProgressEntry> getProgressForUser(int userId) {
        return progressDao.findByUserId(userId);
    }

    public ProgressEntry getProgressById(int id) {
        return progressDao.findById(id);
    }

    public void updateProgress(ProgressEntry entry) {
        progressDao.update(entry);
    }

    public void deleteProgress(int id) {
        progressDao.delete(id);
    }
}
