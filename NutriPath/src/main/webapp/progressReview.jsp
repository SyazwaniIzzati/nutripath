<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nutripath.beans.User, com.nutripath.beans.Goal" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Goal> goals = (List<Goal>) request.getAttribute("goals");
    Integer totalCaloriesConsumed = (Integer) request.getAttribute("totalCaloriesConsumed");
    Integer totalCaloriesBurned = (Integer) request.getAttribute("totalCaloriesBurned");
    Integer netCalories = (Integer) request.getAttribute("netCalories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Progress Review - NutriPath</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.dashboard-container {
    padding: 20px;
    max-width: 1000px;
    margin: 0 auto;
}
.dashboard-title {
    text-align: center;
    font-size: 28px;
    margin-bottom: 10px;
    color: #4CAF50;
}
.dashboard-subtitle {
    text-align: center;
    font-size: 16px;
    margin-bottom: 30px;
    color: #555;
}
.user-stats {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 30px;
}
.user-stats .stat {
    display: flex;
    align-items: center;
    gap: 10px;
    background-color: #f1f1f1;
    padding: 12px 20px;
    border-radius: 1rem;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    font-weight: 500;
    color: #333;
}
.goals-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
}
.goals-table th, .goals-table td {
    border: 1px solid #ddd;
    padding: 12px 10px;
    text-align: center;
}
.goals-table th {
    background-color: #4CAF50;
    color: white;
}
.goals-table tr:nth-child(even) {
    background-color: #f9f9f9;
}
.goals-table tr:hover {
    background-color: #f1f1f1;
}
</style>
</head>
<body>

<!-- HEADER SAME AS DASHBOARD -->
<nav class="top-navbar">
    <div class="top-logo">
        <div class="top-logo-icon">N</div>
        <div class="top-logo-text">NUTRIPATH</div>
    </div>
    <ul class="top-nav-links">
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="goal.jsp">Goals</a></li>
        <li><a href="DailyTracker.jsp">Daily Tracker</a></li>
        <li><a href="progressReview" class="active">Progress Review</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<div class="dashboard-container">
    <h2 class="dashboard-title">Progress Review</h2>
    <p class="dashboard-subtitle">Here’s your progress summary</p>

    <!-- USER STATS -->
    <div class="user-stats">
        <div class="stat"><i class="fas fa-utensils"></i> Calories Consumed: <strong><%= totalCaloriesConsumed %> kcal</strong></div>
        <div class="stat"><i class="fas fa-burn"></i> Calories Burned: <strong><%= totalCaloriesBurned %> kcal</strong></div>
        <div class="stat"><i class="fas fa-chart-line"></i> Net Calories: <strong><%= netCalories %> kcal</strong></div>
    </div>

    <!-- GOALS TABLE -->
    <table class="goals-table">
        <thead>
            <tr>
                <th>Goal Type</th>
                <th>Start Value (kg)</th>
                <th>Target Value (kg)</th>
                <th>Start Date</th>
                <th>Target Date</th>
                <th>Progress (%)</th>
            </tr>
        </thead>
        <tbody>
            <% if (goals != null) {
                for (Goal goal : goals) {
                    double progress = ((user.getWeight() - goal.getStartValue()) / 
                                       (goal.getTargetValue() - goal.getStartValue())) * 100;
                    if (progress < 0) progress = 0;
                    if (progress > 100) progress = 100;
            %>
            <tr>
                <td><%= goal.getGoalType() %></td>
                <td><%= goal.getStartValue() %></td>
                <td><%= goal.getTargetValue() %></td>
                <td><%= goal.getStartDate() %></td>
                <td><%= goal.getTargetDate() %></td>
                <td><%= String.format("%.1f", progress) %> %</td>
            </tr>
            <% } } %>
        </tbody>
    </table>

    <!-- WEIGHT PROGRESS CHART -->
    <div class="graph-container">
        <canvas id="weightChart"></canvas>
    </div>

</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-text">All rights reserved | NutriPath © 2025</div>
</footer>

<script>
const ctx = document.getElementById('weightChart');
new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Start','Current','Target'],
        datasets: [{
            label: 'Weight Progress',
            data: [
                <%= goals != null && goals.size() > 0 ? goals.get(0).getStartValue() : user.getWeight() %>,
                <%= user.getWeight() %>,
                <%= goals != null && goals.size() > 0 ? goals.get(0).getTargetValue() : user.getWeight() %>
            ],
            borderColor: '#4CAF50',
            backgroundColor: 'rgba(76,175,80,0.15)',
            fill: true,
            tension: 0.4
        }]
    },
    options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: false } } }
});
</script>

</body>
</html>
