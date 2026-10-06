package com.fitpulse.dao;

import com.fitpulse.model.User;
import java.util.List;

public interface UserDao {
    User findById(int id);
    User findByEmail(String email);
    List<User> findAll();
    void create(User user);
    void update(User user);
    void updateStatus(int userId, boolean active);
}
