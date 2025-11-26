package com.booking.dao;

import com.booking.model.*;



public interface UserDAO {
    User getUserByUsername(String username);
    User getUserById(int userId);
    User validateUser(String username, String password);
    int addUser(User user);
    int updateUser(User user);
    boolean isUsernameExists(String username);
    boolean isEmailExists(String email);
}