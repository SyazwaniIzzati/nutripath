<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nutripath.beans.User, com.nutripath.beans.DailyFood, com.nutripath.beans.DailyExercise, com.nutripath.model.*, java.sql.*, java.util.*" %>
<%
    // 1️⃣ Login check (like dashboard.jsp)
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = user.getId(); // use session userId

 // Today's date in Malaysia timezone
    java.time.LocalDate localToday = java.time.LocalDate.now(java.time.ZoneId.of("Asia/Kuala_Lumpur"));
    java.sql.Date today = java.sql.Date.valueOf(localToday);

    // 3️⃣ DAOs (self-contained, no connection from JSP)
    DailyFoodDAO foodDAO = new DailyFoodDAO();
    DailyExerciseDAO exerciseDAO = new DailyExerciseDAO();

    List<DailyFood> foodList = new ArrayList<>();
    List<DailyExercise> exerciseList = new ArrayList<>();
    int totalCaloriesEaten = 0;
    int totalCaloriesBurned = 0;

    try {
        foodList = foodDAO.getDailyFoods(userId, today);
        exerciseList = exerciseDAO.getDailyExercises(userId, today);

        for (DailyFood f : foodList) totalCaloriesEaten += f.getTotalCalories();
        for (DailyExercise e : exerciseList) totalCaloriesBurned += e.getCaloriesBurned();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Daily Tracker - NutriPath</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background: #ffffff;
        min-height: 100vh;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 30px 20px;
    }
    
    .page-header {
        background: white;
        border-radius: 15px;
        padding: 25px 30px;
        margin-bottom: 30px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .page-header h2 {
        color: #4CAF50;
        margin: 0 0 10px 0;
        font-size: 28px;
    }
    
    .page-header p {
        margin: 0;
        color: #666;
        font-size: 16px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        text-align: center;
        transition: transform 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
    }
    
    .stat-card .icon {
        font-size: 40px;
        margin-bottom: 15px;
    }
    
    .stat-card.eaten .icon { color: #FF6B6B; }
    .stat-card.burned .icon { color: #4ECDC4; }
    .stat-card.net .icon { color: #95E1D3; }
    
    .stat-card h4 {
        margin: 0 0 10px 0;
        color: #666;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .stat-card .value {
        font-size: 32px;
        font-weight: bold;
        color: #333;
    }
    
    .stat-card .unit {
        font-size: 16px;
        color: #999;
    }
    
    .main-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(600px, 1fr));
        gap: 30px;
        margin-bottom: 30px;
    }
    
    .section-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .section-card h3 {
        color: #4CAF50;
        margin: 0 0 20px 0;
        font-size: 22px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .section-card h3 i {
        font-size: 24px;
    }
    
    form {
        display: grid;
        gap: 15px;
    }
    
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }
    
    label {
        font-weight: 600;
        color: #555;
        font-size: 14px;
    }
    
    input[type=text], 
    input[type=number], 
    input[type=date] { 
        padding: 12px;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        font-size: 14px;
        transition: border-color 0.3s ease;
    }
    
    input[type=text]:focus, 
    input[type=number]:focus, 
    input[type=date]:focus {
        outline: none;
        border-color: #4CAF50;
    }
    
    button[type=submit] {
        padding: 12px 30px;
        background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        margin-top: 10px;
    }
    
    button[type=submit]:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
    }
    
    table { 
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    
    th, td { 
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #f0f0f0;
    }
    
    th { 
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        color: #333;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 12px;
        letter-spacing: 1px;
    }
    
    tr:hover {
        background-color: #f8f9fa;
    }
    
    .delete-btn { 
        color: #FF6B6B;
        text-decoration: none;
        font-weight: 600;
        padding: 6px 15px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
        display: inline-block;
    }
    
    .delete-btn:hover {
        background-color: #ffe0e0;
    }
    
    .empty-state {
        text-align: center;
        padding: 40px;
        color: #999;
    }
    
    .empty-state i {
        font-size: 50px;
        margin-bottom: 15px;
        opacity: 0.3;
    }
    
    @media (max-width: 1200px) {
        .main-grid {
            grid-template-columns: 1fr;
        }
    }
    
    @media (max-width: 768px) {
        .form-row {
            grid-template-columns: 1fr;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>

<!-- Navbar SAME as dashboard.jsp -->
<nav class="top-navbar">
    <div class="top-logo">
        <div class="top-logo-icon">N</div>
        <div class="top-logo-text">NUTRIPATH</div>
    </div>
    <ul class="top-nav-links">
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="goal.jsp">Goals</a></li>
        <li><a href="DailyTracker.jsp" class="active">Daily Tracker</a></li>
        <li><a href="progressReview.jsp">Progress Review</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h2><i class="fas fa-calendar-day"></i> Daily Tracker - <%= today %></h2>
        <p>Welcome back, <strong><%= user.getFullname() %></strong>! Track your nutrition and fitness journey.</p>
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card eaten">
            <div class="icon"><i class="fas fa-utensils"></i></div>
            <h4>Calories Eaten</h4>
            <div class="value"><%= totalCaloriesEaten %> <span class="unit">kcal</span></div>
        </div>
        <div class="stat-card burned">
            <div class="icon"><i class="fas fa-fire"></i></div>
            <h4>Calories Burned</h4>
            <div class="value"><%= totalCaloriesBurned %> <span class="unit">kcal</span></div>
        </div>
        <div class="stat-card net">
            <div class="icon"><i class="fas fa-calculator"></i></div>
            <h4>Net Calories</h4>
            <div class="value"><%= (totalCaloriesEaten - totalCaloriesBurned) %> <span class="unit">kcal</span></div>
        </div>
    </div>

    <!-- Main Grid -->
    <div class="main-grid">
        <!-- Food Section -->
        <div class="section-card">
            <h3><i class="fas fa-apple-alt"></i> Food Log</h3>
            
            <!-- Food Form -->
            <form action="addFood" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Food Name</label>
                        <input type="text" name="foodName" placeholder="e.g., Chicken Breast" required />
                    </div>
                    <div class="form-group">
                        <label>Quantity</label>
                        <input type="number" name="quantity" min="1" placeholder="e.g., 2" required />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Calories per Unit</label>
                        <input type="number" name="caloriesPerUnit" min="0" placeholder="e.g., 150" required />
                    </div>
                    <div class="form-group">
                        <label>Date</label>
                        <input type="date" name="logDate" value="<%= today %>" required />
                    </div>
                </div>
                <button type="submit"><i class="fas fa-plus"></i> Add Food</button>
            </form>

            <!-- Food Table -->
            <% if (foodList.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-utensils"></i>
                    <p>No food logged today. Start tracking your meals!</p>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Food Name</th>
                            <th>Qty</th>
                            <th>Cal/Unit</th>
                            <th>Total Cal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DailyFood f : foodList) { %>
                        <tr>
                            <td><strong><%= f.getFoodName() %></strong></td>
                            <td><%= f.getQuantity() %></td>
                            <td><%= f.getCaloriesPerUnit() %> kcal</td>
                            <td><strong><%= f.getTotalCalories() %> kcal</strong></td>
                            <td><a class="delete-btn" href="deleteFood?id=<%= f.getId() %>"><i class="fas fa-trash"></i> Delete</a></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

        <!-- Exercise Section -->
        <div class="section-card">
            <h3><i class="fas fa-dumbbell"></i> Exercise Log</h3>
            
            <!-- Exercise Form -->
            <form action="addExercise" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Exercise Name</label>
                        <input type="text" name="exerciseName" placeholder="e.g., Running" required />
                    </div>
                    <div class="form-group">
                        <label>Duration (minutes)</label>
                        <input type="number" name="duration" min="1" placeholder="e.g., 30" required />
                    </div>
                </div>
                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="logDate" value="<%= today %>" required />
                </div>
                <button type="submit"><i class="fas fa-plus"></i> Add Exercise</button>
            </form>

            <!-- Exercise Table -->
            <% if (exerciseList.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-dumbbell"></i>
                    <p>No exercise logged today. Get moving!</p>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Exercise Name</th>
                            <th>Duration</th>
                            <th>Calories Burned</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (DailyExercise e : exerciseList) { %>
                        <tr>
                            <td><strong><%= e.getExerciseName() %></strong></td>
                            <td><%= e.getDuration() %> min</td>
                            <td><strong><%= e.getCaloriesBurned() %> kcal</strong></td>
                            <td><a class="delete-btn" href="deleteExercise?id=<%= e.getId() %>"><i class="fas fa-trash"></i> Delete</a></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="footer-text">All rights reserved | NutriPath © 2025</div>
</footer>
</body>
</html>