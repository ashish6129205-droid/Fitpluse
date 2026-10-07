package com.fitpulse.dao;

import com.fitpulse.model.FitnessContent;
import java.util.List;

public interface ContentDao {
    void createContent(FitnessContent content);
    List<FitnessContent> getApprovedContent();
    List<FitnessContent> getPendingContent();
    void updateContentStatus(int contentId, String status);
}
