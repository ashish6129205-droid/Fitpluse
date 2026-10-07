package com.fitpulse.dao;

import com.fitpulse.model.ActivityLog;
import java.util.List;

public interface ActivityLogDao {
    void create(ActivityLog log);
    List<ActivityLog> getLatestLogs(int limit);
}
