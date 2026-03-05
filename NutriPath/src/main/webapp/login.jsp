<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NutriPath - Your Path to Healthy Living</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <!-- Top Navigation -->
    <nav class="top-navbar">
        <div class="top-logo">
            <div class="top-logo-icon">N</div>
            <div class="top-logo-text">NUTRIPATH</div>
        </div>
        <ul class="top-nav-links">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Goal</a></li>
            <li><a href="#">Daily Tracker</a></li>
            <li><a href="#">Progress review</a></li>
            <li><a href="#">Profile</a></li>
            <li><a href="login.jsp" class="active">Home</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <!-- Right Image Section -->
        <div class="image-section">
            <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=1200&h=1000&fit=crop" 
                 alt="Healthy Food" class="hero-image">
            <div class="image-overlay">
                <h2>Nutrients important for growth and repair.</h2>
                <p>Your path to a healthier self starts here. Thoughtful tracking and consistent progress make the journey achievable.</p>
            </div>
        </div>

        <!-- Left Login Section -->
        <div class="login-section">
            <div class="login-content">
                <div class="login-header">
                    <h2>Welcome Back</h2>
                    <p>Sign in to continue your health journey</p>
                </div>

                <% if (error != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> 
                        <%= java.net.URLDecoder.decode(error, "UTF-8") %>
                    </div>
                <% } %>

                <!-- Login Form -->
                <form id="loginForm" method="post" action="login">
                    <div class="input-group">
                        <i class="fas fa-user"></i>
                        <input type="text" class="form-input" name="username" placeholder="Username" required>
                    </div>

                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" class="form-input" name="password" placeholder="Password" required>
                    </div>

                    <div class="remember-forgot">
                        <label>
                            <input type="checkbox" name="rememberMe" checked> Remember me
                        </label>
                    </div>

                    <button type="submit" class="login-btn">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>

                    <div class="divider">OR</div>

                    <div class="signup-link">
                        Don't have an account? <a href="signup.jsp">Sign up here</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-text">All rights reserved | NutriTrack © 2025</div>
        <div class="social-links">
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
    </footer>
</body>
</html>
