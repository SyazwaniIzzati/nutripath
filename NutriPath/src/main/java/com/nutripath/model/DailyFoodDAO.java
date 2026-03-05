package com.nutripath.model;

import com.nutripath.beans.DailyFood;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DailyFoodDAO {

    private final String DB_URL = "jdbc:mysql://localhost:3306/nutripath?serverTimezone=UTC";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "root";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Add new food
    public boolean addDailyFood(DailyFood food) {
        String sql = "INSERT INTO food (user_id, food_name, quantity, calories_per_unit, total_calories, log_date, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, food.getUserId());
            stmt.setString(2, food.getFoodName());
            stmt.setInt(3, food.getQuantity());
            stmt.setInt(4, food.getCaloriesPerUnit());

            // calculate total calories
            int totalCalories = food.getQuantity() * food.getCaloriesPerUnit();
            stmt.setInt(5, totalCalories);

            stmt.setDate(6, food.getLogDate());
            stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));

            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Fetch food by user & date
    public List<DailyFood> getDailyFoods(int userId, Date logDate) {
        List<DailyFood> foodList = new ArrayList<>();
        String sql = "SELECT * FROM food WHERE user_id = ? AND DATE(log_date) = ? ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setDate(2, logDate);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                DailyFood food = new DailyFood();
                food.setId(rs.getInt("id"));
                food.setUserId(rs.getInt("user_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setQuantity(rs.getInt("quantity"));
                food.setCaloriesPerUnit(rs.getInt("calories_per_unit"));
                food.setTotalCalories(rs.getInt("total_calories"));
                food.setLogDate(rs.getDate("log_date"));
                food.setCreatedAt(rs.getTimestamp("created_at"));
                foodList.add(food);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return foodList;
    }

    // Delete food
    public boolean deleteDailyFood(int id) {
        String sql = "DELETE FROM food WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // New: Get total calories consumed by user
    public int getTotalCaloriesConsumed(int userId) {
        int total = 0;
        String sql = "SELECT SUM(total_calories) AS total FROM food WHERE user_id = ?";

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
