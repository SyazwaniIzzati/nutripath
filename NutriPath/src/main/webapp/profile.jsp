<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nutripath.beans.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile - NutriPath</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Inline CSS specific to profile page */
.dashboard-container {
    padding: 20px;
    max-width: 700px;
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

.profile-form-container {
    background-color: #f9f9f9;
    padding: 30px;
    border-radius: 1rem;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.profile-form-container h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #4CAF50;
}

.profile-form-container .form-group {
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
}

.profile-form-container label {
    margin-bottom: 5px;
    font-weight: 500;
    color: #333;
}

.profile-form-container input,
.profile-form-container select {
    padding: 12px 15px;
    border: 2px solid #ccc;
    border-radius: 12px;
    font-size: 14px;
    background-color: #fff;
    color: #333;
    transition: all 0.3s;
}

.profile-form-container select {
    appearance: none;
    cursor: pointer;
    background-image: 
        linear-gradient(45deg, transparent 50%, #D87F3A 50%),
        linear-gradient(135deg, #D87F3A 50%, transparent 50%);
    background-position:
        calc(100% - 22px) calc(50% - 3px),
        calc(100% - 16px) calc(50% - 3px);
    background-size: 6px 6px;
    background-repeat: no-repeat;
}

.profile-form-container input:focus,
.profile-form-container select:focus {
    outline: none;
    border-color: #4CAF50;
    box-shadow: 0 0 8px rgba(76,175,80,0.3);
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

.message {
    text-align: center;
    margin-bottom: 20px;
    font-weight: 500;
}

.message.success {
    color: green;
}

.message.error {
    color: red;
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
        <li><a href="goal">Goals</a></li>
        <li><a href="DailyTracker.jsp">Daily Tracker</a></li>
        <li><a href="progressReview.jsp">Progress Review</a></li>
        <li><a href="profile.jsp" class="active">Profile</a></li>
        <li>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<div class="dashboard-container">

    <h2 class="dashboard-title">My Profile</h2>
    <p class="dashboard-subtitle">View and update your personal information.</p>

    <div class="profile-form-container">
        <% if(request.getAttribute("success") != null) { %>
            <div class="message success"><%= request.getAttribute("success") %></div>
        <% } else if(request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form method="post" action="profile">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" name="fullname" id="fullname" value="<%= user.getFullname() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" name="email" id="email" value="<%= user.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
                <input type="text" name="phone_number" id="phone_number" value="<%= user.getPhone_number() %>" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <select name="gender" id="gender" required>
                    <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="weight">Weight (kg)</label>
                <input type="number" step="0.1" name="weight" id="weight" value="<%= user.getWeight() %>" required>
            </div>
            <div class="form-group">
                <label for="height">Height (cm)</label>
                <input type="number" step="0.1" name="height" id="height" value="<%= user.getHeight() %>" required>
            </div>
            <div class="form-group">
                <label for="bmi">BMI</label>
                <input type="text" id="bmi" value="<%= user.getBmi() %>" readonly>
            </div>
            <button type="submit" class="btn-submit">Save Profile</button>
        </form>
    </div>

</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-text">All rights reserved | NutriPath © 2025</div>
</footer>

</body>
</html>
