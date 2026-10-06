package com.fitpulse.dao;

import com.fitpulse.model.ProgressEntry;
import java.util.List;

public interface ProgressEntryDao {
    ProgressEntry findById(int id);
    List<ProgressEntry> findByUserId(int userId);
    void create(ProgressEntry entry);
    void update(ProgressEntry entry);
    void delete(int id);
}
