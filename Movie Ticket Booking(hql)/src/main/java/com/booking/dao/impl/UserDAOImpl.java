package com.booking.dao.impl;

import com.booking.dao.UserDAO;
import com.booking.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    // ✅ Get User by Username
    @Override
    public User getUserByUsername(String username) {
        Session session = sessionFactory.openSession();
        User user = null;
        try {
            String hql = "FROM User WHERE username = :username";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("username", username);
            user = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }

    // ✅ Get User by ID
    @Override
    public User getUserById(int userId) {
        Session session = sessionFactory.openSession();
        User user = null;
        try {
            user = session.get(User.class, userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }

    // ✅ Validate User (username + password)
    @Override
    public User validateUser(String username, String password) {
        Session session = sessionFactory.openSession();
        User user = null;
        try {
            String hql = "FROM User WHERE username = :username AND password = :password";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            user = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }

    // ✅ Add New User
    @Override
    public int addUser(User user) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        int id = 0;
        try {
            tx = session.beginTransaction();
            id = (int) session.save(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return id;
    }

    // ✅ Update Existing User
    @Override
    public int updateUser(User user) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        int result = 0;
        try {
            tx = session.beginTransaction();
            session.update(user);
            tx.commit();
            result = 1;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    // ✅ Check Username Exists
    @Override
    public boolean isUsernameExists(String username) {
        Session session = sessionFactory.openSession();
        boolean exists = false;
        try {
            String hql = "SELECT COUNT(u) FROM User u WHERE u.username = :username";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("username", username);
            Long count = query.uniqueResult();
            exists = (count != null && count > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return exists;
    }

    // ✅ Check Email Exists
    @Override
    public boolean isEmailExists(String email) {
        Session session = sessionFactory.openSession();
        boolean exists = false;
        try {
            String hql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("email", email);
            Long count = query.uniqueResult();
            exists = (count != null && count > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return exists;
    }
}
