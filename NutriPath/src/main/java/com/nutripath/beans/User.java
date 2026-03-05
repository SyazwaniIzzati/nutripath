package com.nutripath.beans;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {

    private int id;
    private String username;
    private String fullname;
    private String password;
    private String phone_number;
    private String gender;
    private double weight;
    private double height;
    private double bmi;
    private String email;
    private String role;
    private double dailyCalorieTarget; // target calories per day
    private Date createdAt;

    // No-arg constructor
    public User() {
        this.createdAt = new Date();
    }

    // Full constructor
    public User(int id, String username, String fullname, String password,
                String phone_number, String gender, double weight,
                double height, double bmi, String email, double dailyCalorieTarget, Date createdAt) {

        this.id = id;
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.phone_number = phone_number;
        this.gender = gender;
        this.weight = weight;
        this.height = height;
        this.bmi = bmi;
        this.email = email;
        this.dailyCalorieTarget = dailyCalorieTarget;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
        calculateBmi();
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
        calculateBmi();
    }

    public double getBmi() {
        return bmi;
    }

    public void setBmi(double bmi) {
        this.bmi = bmi;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public double getDailyCalorieTarget() {
        return dailyCalorieTarget;
    }

    public void setDailyCalorieTarget(double dailyCalorieTarget) {
        this.dailyCalorieTarget = dailyCalorieTarget;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // Auto BMI calculation (height in cm, weight in kg)
    private void calculateBmi() {
        if (height > 0 && weight > 0) {
            double heightMeters = height / 100.00; // convert cm to meters
            double rawBmi = weight / (heightMeters * heightMeters);
            this.bmi = Math.round(rawBmi * 100.00) / 100.00; // round to 2 decimal places
        }
    }

    @Override
    public String toString() {
        return "User [id=" + id +
               ", username=" + username +
               ", fullname=" + fullname +
               ", email=" + email +
               ", bmi=" + bmi + "]";
    }
}
