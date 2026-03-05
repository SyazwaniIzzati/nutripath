package com.nutripath.model;

import com.nutripath.beans.Goal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GoalDAO {

    private final String DB_URL = "jdbc:mysql://localhost:3306/nutripath?serverTimezone=UTC";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "root"; // your MySQL password

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Get all goals by user_id
    public List<Goal> getGoalsByUser(int userId) {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM goals WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Goal goal = new Goal();
                goal.setId(rs.getInt("id"));
                goal.setUserId(rs.getInt("user_id"));
                goal.setGoalType(rs.getString("goal_type"));
                goal.setStartValue(rs.getDouble("start_value"));
                goal.setTargetValue(rs.getDouble("target_value"));
                goal.setStartDate(rs.getDate("start_date"));
                goal.setTargetDate(rs.getDate("target_date"));
                goal.setNotes(rs.getString("notes"));
                goal.setCreatedAt(rs.getTimestamp("created_at"));
                goals.add(goal);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return goals;
    }

    // Add a new goal
    public boolean addGoal(Goal goal) {
        String sql = "INSERT INTO goals (user_id, goal_type, start_value, target_value, start_date, target_date, notes) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, goal.getUserId());
            stmt.setString(2, goal.getGoalType());
            stmt.setDouble(3, goal.getStartValue());
            stmt.setDouble(4, goal.getTargetValue());
            stmt.setDate(5, new java.sql.Date(goal.getStartDate().getTime()));
            stmt.setDate(6, new java.sql.Date(goal.getTargetDate().getTime()));
            stmt.setString(7, goal.getNotes());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
