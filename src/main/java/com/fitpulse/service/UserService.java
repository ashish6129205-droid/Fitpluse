package com.fitpulse.service;

import com.fitpulse.dao.UserDao;
import com.fitpulse.dao.impl.UserDaoImpl;
import com.fitpulse.model.User;
import com.fitpulse.util.PasswordUtil;

import java.util.List;

public class UserService {

    private final UserDao userDao;

    public UserService() {
        this.userDao = new UserDaoImpl();
    }

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public User authenticate(String email, String password) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            return null;
        }

        User user = userDao.findByEmail(email);

        if (user != null && user.isActive()) {
            if (PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }

    public void registerUser(User user, String plainPassword) {
        user.setPasswordHash(PasswordUtil.hashPassword(plainPassword));
        user.setRole("USER");
        user.setActive(true);
        userDao.create(user);
    }

    public User getUserById(int id) {
        return userDao.findById(id);
    }

    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    public void updateUserStatus(int userId, boolean active) {
        userDao.updateStatus(userId, active);
    }

    public void updateProfile(User user) {
        userDao.update(user);
    }
}
