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
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Goals - NutriPath</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Inline CSS specific to goals page */
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

/* User info cards */
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

/* Goal Form */
.goal-form-container {
    background-color: #f9f9f9;
    padding: 30px;
    border-radius: 1rem;
    max-width: 600px;
    margin: 0 auto 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.goal-form-container h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #4CAF50;
}

.goal-form-container .form-group {
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
}

.goal-form-container label {
    margin-bottom: 5px;
    font-weight: 500;
    color: #333;
}

.goal-form-container input,
.goal-form-container textarea {
    padding: 12px 15px;
    border: 2px solid #ccc;
    border-radius: 12px;
    font-size: 14px;
    background-color: #fff;
    color: #333;
    transition: all 0.3s;
}
/* Improved Select (Dropdown) Design */
.goal-form-container select {
    appearance: none;              /* remove default arrow */
    -webkit-appearance: none;
    -moz-appearance: none;

    padding: 12px 45px 12px 15px;
    border: 2px solid #ccc;
    border-radius: 12px;
    font-size: 14px;
    background-color: #fff;
    color: #333;
    cursor: pointer;

    background-image: 
        linear-gradient(45deg, transparent 50%, #D87F3A 50%),
        linear-gradient(135deg, #D87F3A 50%, transparent 50%);
    background-position:
        calc(100% - 22px) calc(50% - 3px),
        calc(100% - 16px) calc(50% - 3px);
    background-size: 6px 6px;
    background-repeat: no-repeat;

    transition: all 0.3s ease;
}

.goal-form-container select:hover {
    border-color: #D87F3A;
}

.goal-form-container select:focus {
    outline: none;
    border-color: #D87F3A;
    box-shadow: 0 0 8px rgba(216, 127, 58, 0.35);
}

/* Disabled placeholder option */
.goal-form-container select option[disabled] {
    color: #999;
}


.goal-form-container input:focus,
.goal-form-container textarea:focus {
    outline: none;
    border-color: #4CAF50;
    box-shadow: 0 0 8px rgba(76,175,80,0.3);
}

.goal-form-container textarea {
    resize: vertical;
    min-height: 80px;
}

.btn-submit {
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #D87F3A 0%, #FFA057 100%);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(76,175,80,0.3);
}

/* Goals Table */
.goals-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
}

.goals-table th,
.goals-table td {
    border: 1px solid #ddd;
    padding: 12px 10px;
    text-align: center;
    font-size: 14px;
}

.goals-table th {
    background-color: #4CAF50;
    color: white;
    font-weight: 600;
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
        <li><a href="goal" class="active">Goals</a></li>
        <li><a href="DailyTracker.jsp">Daily Tracker</a></li>
        <li><a href="#">Progress Review</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<div class="dashboard-container">

    <h2 class="dashboard-title">Welcome, <%= user.getFullname() %></h2>
    <p class="dashboard-subtitle">Here you can manage your health goals.</p>

    <!-- GOAL FORM -->
    <div class="goal-form-container">
        <h2>Add New Goal</h2>
        <form method="post" action="goal">
            <div class="form-group">
    			<label for="goal_type">Goal Type</label>
    				<select name="goal_type" id="goal_type" required>
        			<option value="" disabled selected>Select goal type</option>
        			<option value="Weight Loss">Weight Loss</option>
        			<option value="Maintain Weight">Maintain Weight</option>
        			<option value="Gain Weight">Gain Weight</option>
    				</select>
			</div>
            <div class="form-group">
                <label for="start_value">Start Value</label>
                <input type="number" step="0.01" name="start_value" id="start_value" required>
            </div>
            <div class="form-group">
                <label for="target_value">Target Value</label>
                <input type="number" step="0.01" name="target_value" id="target_value" required>
            </div>
            <div class="form-group">
                <label for="start_date">Start Date</label>
                <input type="date" name="start_date" id="start_date" required>
            </div>
            <div class="form-group">
                <label for="target_date">Target Date</label>
                <input type="date" name="target_date" id="target_date" required>
            </div>
            <div class="form-group">
                <label for="notes">Notes</label>
                <textarea name="notes" id="notes"></textarea>
            </div>
            <button type="submit" class="btn-submit">Add Goal</button>
        </form>
    </div>

    <!-- EXISTING GOALS TABLE -->
    <table class="goals-table">
        <thead>
            <tr>
                <th>Goal Type</th>
                <th>Start</th>
                <th>Target</th>
                <th>Start Date</th>
                <th>Target Date</th>
                <th>Notes</th>
            </tr>
        </thead>
        <tbody>
            <% if (goals != null) { 
                   for (Goal goal : goals) { %>
                <tr>
                    <td><%= goal.getGoalType() %></td>
                    <td><%= goal.getStartValue() %></td>
                    <td><%= goal.getTargetValue() %></td>
                    <td><%= goal.getStartDate() %></td>
                    <td><%= goal.getTargetDate() %></td>
                    <td><%= goal.getNotes() %></td>
                </tr>
            <%   } 
               } %>
        </tbody>
    </table>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-text">All rights reserved | NutriPath © 2025</div>
</footer>
</body>
</html>
