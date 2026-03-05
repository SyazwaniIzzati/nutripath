package com.nutripath.beans;

import java.sql.Date;
import java.sql.Timestamp;

public class DailyFood {
    private int id;
    private int userId;
    private String foodName;
    private int quantity;
    private int caloriesPerUnit;
    private int totalCalories;
    private Date logDate;

    // Empty constructor
    public DailyFood() {}

    // Constructor with fields (optional)
    public DailyFood(int userId, String foodName, int quantity, int caloriesPerUnit, Date logDate) {
        this.userId = userId;
        this.foodName = foodName;
        this.quantity = quantity;
        this.caloriesPerUnit = caloriesPerUnit;
        this.totalCalories = quantity * caloriesPerUnit;
        this.logDate = logDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFoodName() {
        return foodName;
    }
    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        updateTotalCalories();
    }

    public int getCaloriesPerUnit() {
        return caloriesPerUnit;
    }
    public void setCaloriesPerUnit(int caloriesPerUnit) {
        this.caloriesPerUnit = caloriesPerUnit;
        updateTotalCalories();
    }

    public int getTotalCalories() {
        return totalCalories;
    }
    private void updateTotalCalories() {
        this.totalCalories = this.quantity * this.caloriesPerUnit;
    }

    public Date getLogDate() {
        return logDate;
    }
    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

	public void setTotalCalories(int int1) {
		// TODO Auto-generated method stub
		
	}

	public void setCreatedAt(Timestamp timestamp) {
		// TODO Auto-generated method stub
		
	}
}
