package com.nutripath.beans;

import java.sql.Date;
import java.sql.Timestamp;

public class DailyExercise {
    private int id;
    private int userId;
    private String exerciseName;
    private int duration; // in minutes
    private int caloriesBurned;
    private Date logDate;

    // Empty constructor
    public DailyExercise() {}

    // Constructor with fields (optional)
    public DailyExercise(int userId, String exerciseName, int duration, int caloriesBurned, Date logDate) {
        this.userId = userId;
        this.exerciseName = exerciseName;
        this.duration = duration;
        this.caloriesBurned = caloriesBurned;
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

    public String getExerciseName() {
        return exerciseName;
    }
    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }

    public int getDuration() {
        return duration;
    }
    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getCaloriesBurned() {
        return caloriesBurned;
    }
    public void setCaloriesBurned(int caloriesBurned) {
        this.caloriesBurned = caloriesBurned;
    }

    public Date getLogDate() {
        return logDate;
    }
    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

	public void setCreatedAt(Timestamp timestamp) {
		// TODO Auto-generated method stub
		
	}
}
