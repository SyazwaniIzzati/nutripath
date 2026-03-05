package com.nutripath.model;

import com.nutripath.beans.User;
import java.sql.*;

public class DB {
    // Database connection details
    private final String DB_URL = "jdbc:mysql://localhost:3306/nutripath?serverTimezone=UTC";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "root"; // Change to your MySQL password

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Register/Signup a new user
    public boolean registerUser(User user) {
        boolean success = false;
        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(
                 "INSERT INTO users (username, password, fullname, phone_number, gender, weight, height, email, bmi, createdAt) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                 Statement.RETURN_GENERATED_KEYS)) {

            pst.setString(1, user.getUsername());
            pst.setString(2, user.getPassword()); // plain text for now
            pst.setString(3, user.getFullname());
            pst.setString(4, user.getPhone_number());
            pst.setString(5, user.getGender());
            pst.setDouble(6, user.getWeight());
            pst.setDouble(7, user.getHeight());
            pst.setString(8, user.getEmail());
            pst.setDouble(9, user.getBmi());
            pst.setTimestamp(10, new Timestamp(user.getCreatedAt().getTime()));

            int row = pst.executeUpdate();
            success = row > 0;

            if (success) {
                try (ResultSet rs = pst.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getInt(1));
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
        }
        return success;
    }

    // Validate user login
    public User validateUser(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, username);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setFullname(rs.getString("fullname"));
                    user.setPhone_number(rs.getString("phone_number"));
                    user.setGender(rs.getString("gender"));
                    user.setWeight(rs.getDouble("weight"));
                    user.setHeight(rs.getDouble("height"));
                    user.setBmi(rs.getDouble("bmi"));
                    user.setEmail(rs.getString("email"));
                    user.setCreatedAt(rs.getTimestamp("createdAt"));
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error validating user: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }

    // Check if email already exists
    public boolean isEmailExists(String email) {
        boolean exists = false;
        String sql = "SELECT id FROM users WHERE email = ?";

        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                exists = rs.next();
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error checking email: " + e.getMessage());
            e.printStackTrace();
        }
        return exists;
    }

    // Get user by ID (dashboard usage)
    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, userId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullname(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone_number(rs.getString("phone_number"));
                    user.setGender(rs.getString("gender"));
                    user.setWeight(rs.getDouble("weight"));
                    user.setHeight(rs.getDouble("height"));
                    user.setBmi(rs.getDouble("bmi"));
                    user.setCreatedAt(rs.getTimestamp("createdAt"));
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }

//Update user profile
public boolean updateUser(User user) {
 boolean success = false;
 String sql = "UPDATE users SET fullname=?, email=?, phone_number=?, gender=?, weight=?, height=?, bmi=? WHERE id=?";

 try (Connection conn = getConnection();
      PreparedStatement pst = conn.prepareStatement(sql)) {

     pst.setString(1, user.getFullname());
     pst.setString(2, user.getEmail());
     pst.setString(3, user.getPhone_number());
     pst.setString(4, user.getGender());
     pst.setDouble(5, user.getWeight());
     pst.setDouble(6, user.getHeight());
     pst.setDouble(7, user.getBmi());
     pst.setInt(8, user.getId());

     success = pst.executeUpdate() > 0;

 } catch (ClassNotFoundException | SQLException e) {
     e.printStackTrace();
 }

 return success;
}
}
