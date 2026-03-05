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
<title>Dashboard - NutriPath</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .dashboard-title {
        text-align: center;
        color: #333;
        margin-bottom: 10px;
    }

    .dashboard-subtitle {
        text-align: center;
        color: #666;
        margin-bottom: 30px;
    }

    .user-stats {
        display: flex;
        justify-content: center;
        gap: 30px;
        margin-bottom: 40px;
        flex-wrap: wrap;
    }

    .stat {
        background: #f8f9fa;
        padding: 15px 30px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        font-size: 16px;
    }

    .stat i {
        color: #4CAF50;
        margin-right: 8px;
    }

    /* Slideshow Container */
    .slideshow-wrapper {
        position: relative;
        width: 100%;
        max-width: 1000px;
        margin: 0 auto;
        overflow: hidden;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    .slideshow-container {
        position: relative;
        width: 100%;
        height: 600px;
    }

    .slide {
        position: absolute;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 1.5s ease-in-out;
    }

    .slide.active {
        opacity: 1;
    }

    .slide img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* Motivation Text Overlay */
    .motivation-overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
        padding: 50px 30px 30px;
        color: white;
        text-align: center;
    }

    .motivation-text {
        font-size: 28px;
        font-weight: bold;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        margin: 0;
        animation: fadeInUp 1s ease-out;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Slide Indicators */
    .slide-indicators {
        position: absolute;
        bottom: 80px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 10px;
        z-index: 10;
    }

    .indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255,255,255,0.5);
        cursor: pointer;
        transition: all 0.3s;
    }

    .indicator.active {
        background: white;
        width: 30px;
        border-radius: 6px;
    }
</style>
</head>

<body>

<!-- Header -->
<nav class="top-navbar">
    <div class="top-logo">
        <div class="top-logo-icon">N</div>
        <div class="top-logo-text">NUTRIPATH</div>
    </div>
    <ul class="top-nav-links">
        <li><a href="#" class="active">Dashboard</a></li>
        <li><a href="goal.jsp">Goals</a></li>
        <li><a href="DailyTracker.jsp">Daily Tracker</a></li>
        <li><a href="progressReview.jsp">Progress Review</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<!-- MAIN CONTENT -->
<div class="dashboard-container">

    <h2 class="dashboard-title">Health Overview</h2>
    <p class="dashboard-subtitle">
        Welcome, <strong><%= user.getFullname() %></strong>
    </p>

    <!-- USER INFO -->
    <div class="user-stats">
        <div class="stat">
            <i class="fas fa-weight"></i>
            Weight: <strong><%= user.getWeight() %> kg</strong>
        </div>
        <div class="stat">
            <i class="fas fa-ruler-vertical"></i>
            Height: <strong><%= user.getHeight() %> cm</strong>
        </div>
        <div class="stat">
            <i class="fas fa-heartbeat"></i>
            BMI: <strong><%= user.getBmi() %></strong>
        </div>
    </div>

    <!-- SLIDESHOW -->
    <div class="slideshow-wrapper">
        <div class="slideshow-container">
            <div class="slide active">
                <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061" alt="Healthy Food">
                <div class="motivation-overlay">
                    <p class="motivation-text">Every healthy choice brings you closer to your goals!</p>
                </div>
            </div>
            <div class="slide">
                <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836" alt="Nutritious Meal">
                <div class="motivation-overlay">
                    <p class="motivation-text">Fuel your body with nutrition and watch yourself thrive!</p>
                </div>
            </div>
            <div class="slide">
                <img src="https://images.unsplash.com/photo-1540189549336-e6e99c3679fe" alt="Delicious Food">
                <div class="motivation-overlay">
                    <p class="motivation-text">Small steps today lead to big transformations tomorrow!</p>
                </div>
            </div>
        </div>
        
        <!-- Slide Indicators -->
        <div class="slide-indicators">
            <span class="indicator active" onclick="goToSlide(0)"></span>
            <span class="indicator" onclick="goToSlide(1)"></span>
            <span class="indicator" onclick="goToSlide(2)"></span>
        </div>
    </div>

</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-text">All rights reserved | NutriPath © 2025</div>
</footer>

<script>
let currentSlide = 0;
const slides = document.querySelectorAll('.slide');
const indicators = document.querySelectorAll('.indicator');
let slideInterval;

function showSlide(index) {
    // Remove active class from all slides and indicators
    slides.forEach(slide => slide.classList.remove('active'));
    indicators.forEach(indicator => indicator.classList.remove('active'));
    
    // Add active class to current slide and indicator
    slides[index].classList.add('active');
    indicators[index].classList.add('active');
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
    showSlide(currentSlide);
}

function goToSlide(index) {
    currentSlide = index;
    showSlide(currentSlide);
    // Reset interval when manually changing slides
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

// Auto-advance slides every 5 seconds
slideInterval = setInterval(nextSlide, 5000);
</script>

</body>
</html>