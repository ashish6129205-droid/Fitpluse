package com.fitpulse.service;

import com.fitpulse.dao.UserDao;
import com.fitpulse.dao.impl.UserDaoImpl;
import com.fitpulse.model.User;
import com.fitpulse.util.PasswordUtil;

import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class UserService {

    private static final Logger LOGGER = Logger.getLogger(UserService.class.getName());
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

        String cleanEmail = email.trim().toLowerCase();
        User user = userDao.findByEmail(cleanEmail);

        boolean found = (user != null);
        boolean active = found && user.isActive();
        boolean hashPassed = false;

        if (active) {
            hashPassed = PasswordUtil.verifyPassword(password, user.getPasswordHash());
            if (hashPassed) {
                LOGGER.info(String.format("Login attempt for email %s: found=%b, active=%b, hashCheckPassed=%b - SUCCESS", cleanEmail, found, active, hashPassed));
                return user;
            }
        }

        LOGGER.info(String.format("Login attempt for email %s: found=%b, active=%b, hashCheckPassed=%b - FAILED", cleanEmail, found, active, hashPassed));
        return null;
    }

    public User findByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        return userDao.findByEmail(email.trim().toLowerCase());
    }

    public void registerUser(User user, String plainPassword) {
        user.setEmail(user.getEmail().trim().toLowerCase());
        user.setPasswordHash(PasswordUtil.hashPassword(plainPassword));
        user.setRole("USER");
        user.setActive(true);
        userDao.create(user);
    }

    public void upsertUser(User user, String plainPassword) {
        String cleanEmail = user.getEmail().trim().toLowerCase();
        User existingUser = userDao.findByEmail(cleanEmail);
        String hashedPw = PasswordUtil.hashPassword(plainPassword);

        if (existingUser != null) {
            existingUser.setPasswordHash(hashedPw);
            existingUser.setRole(user.getRole());
            existingUser.setActive(true);
            userDao.updateSystemFields(existingUser);
        } else {
            user.setEmail(cleanEmail);
            user.setPasswordHash(hashedPw);
            user.setActive(true);
            userDao.create(user);
        }
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
