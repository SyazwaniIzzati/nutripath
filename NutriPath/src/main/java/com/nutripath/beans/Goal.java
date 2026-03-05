package com.nutripath.beans;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class Goal implements Serializable {

    private int id;
    private int userId;

    private String goalType;
    private double startValue;
    private double targetValue;
    private Date startDate;
    private Date targetDate;
    private String notes;
    private Timestamp createdAt;

    // No-arg constructor
    public Goal() {
        // no status anymore
    }

    // Full constructor (status removed)
    public Goal(int id, int userId, String goalType,
                double startValue, double targetValue,
                Date startDate, Date targetDate,
                String notes,
                Timestamp createdAt) {

        this.id = id;
        this.userId = userId;
        this.goalType = goalType;
        this.startValue = startValue;
        this.targetValue = targetValue;
        this.startDate = startDate;
        this.targetDate = targetDate;
        this.notes = notes;
        this.createdAt = createdAt;
    }

    // Getters & Setters
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

    public String getGoalType() {
        return goalType;
    }

    public void setGoalType(String goalType) {
        this.goalType = goalType;
    }

    public double getStartValue() {
        return startValue;
    }

    public void setStartValue(double startValue) {
        this.startValue = startValue;
    }

    public double getTargetValue() {
        return targetValue;
    }

    public void setTargetValue(double targetValue) {
        this.targetValue = targetValue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Goal [id=" + id +
               ", userId=" + userId +
               ", goalType=" + goalType + "]";
    }
}
