package com.nutripath.model;

import com.nutripath.beans.DailyExercise;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DailyExerciseDAO {

    private final String DB_URL = "jdbc:mysql://localhost:3306/nutripath?serverTimezone=UTC";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "root";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Add a new exercise
    public boolean addDailyExercise(DailyExercise ex) {
        String sql = "INSERT INTO exercise (user_id, exercise_name, duration, calories_burned, log_date, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, ex.getUserId());
            stmt.setString(2, ex.getExerciseName());
            stmt.setInt(3, ex.getDuration());

            // Default 5 calories per minute
            int caloriesBurned = ex.getDuration() * 5;
            stmt.setInt(4, caloriesBurned);

            stmt.setDate(5, ex.getLogDate());
            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Fetch exercises for a specific day
    public List<DailyExercise> getDailyExercises(int userId, Date logDate) {
        List<DailyExercise> exerciseList = new ArrayList<>();
        String sql = "SELECT * FROM exercise WHERE user_id = ? AND DATE(log_date) = ? ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setDate(2, logDate);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                DailyExercise ex = new DailyExercise();
                ex.setId(rs.getInt("id"));
                ex.setUserId(rs.getInt("user_id"));
                ex.setExerciseName(rs.getString("exercise_name"));
                ex.setDuration(rs.getInt("duration"));
                ex.setCaloriesBurned(rs.getInt("calories_burned"));
                ex.setLogDate(rs.getDate("log_date"));
                ex.setCreatedAt(rs.getTimestamp("created_at"));
                exerciseList.add(ex);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return exerciseList;
    }

    // Delete exercise
    public boolean deleteDailyExercise(int id) {
        String sql = "DELETE FROM exercise WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get total calories burned by a user
    public int getTotalCaloriesBurned(int userId) {
        int total = 0;
        String sql = "SELECT SUM(calories_burned) AS total FROM exercise WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return total;
    }
}
