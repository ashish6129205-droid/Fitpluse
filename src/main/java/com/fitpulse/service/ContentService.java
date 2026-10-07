package com.fitpulse.service;

import com.fitpulse.dao.ContentDao;
import com.fitpulse.dao.impl.ContentDaoImpl;
import com.fitpulse.model.FitnessContent;

import java.util.List;

public class ContentService {

    private final ContentDao contentDao;

    public ContentService() {
        this.contentDao = new ContentDaoImpl();
    }

    public void createContent(FitnessContent content) {
        contentDao.createContent(content);
        ActivityLogService.getInstance().logActivityAsync(content.getUserId(), "CONTENT_SUBMITTED", "Submitted a new community tip");
    }

    public List<FitnessContent> getApprovedContent() {
        return contentDao.getApprovedContent();
    }

    public List<FitnessContent> getPendingContent() {
        return contentDao.getPendingContent();
    }

    public void updateContentStatus(int adminUserId, int contentId, String status) {
        contentDao.updateContentStatus(contentId, status);
        ActivityLogService.getInstance().logActivityAsync(adminUserId, "CONTENT_MODERATION", "Marked content ID " + contentId + " as " + status);
    }
}
