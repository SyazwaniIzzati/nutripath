<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up - NutriPath</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="css/signup.css">
</head>
<body>
<div class="signup-container">
    <div class="signup-visual">
        <div class="logo"><div class="logo-icon">N</div><div class="logo-text">NutriPath</div></div>
        <h1>Join NutriPath Today</h1>
        <p>Create your account and start tracking your health and nutrition goals.</p>
        <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=600&h=400&fit=crop" alt="Healthy Food">
    </div>

    <div class="signup-form">
        <h2>Sign Up</h2>

        <%-- Error/Success Messages --%>
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("signup");
            if(error != null){ %>
            <div class="error-message"><i class="fas fa-exclamation-circle"></i> <%= java.net.URLDecoder.decode(error, "UTF-8") %></div>
        <% } %>
        <% if(success != null && success.equals("success")){ %>
            <div class="success-message"><i class="fas fa-check-circle"></i> Registration successful! Please login.</div>
        <% } %>

        <form id="signupForm" method="post" action="signup">
            <div class="input-group"><i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>

            <div class="input-group"><i class="fas fa-user"></i>
                <input type="text" name="fullname" placeholder="Full Name" required>
            </div>

            <div class="input-group"><i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="Email Address" required>
            </div>

            <div class="input-group"><i class="fas fa-phone"></i>
                <input type="text" name="phone_number" placeholder="Phone Number">
            </div>

            <div class="input-group"><i class="fas fa-venus-mars"></i>
                <select name="gender" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
            </div>

            <div class="input-group"><i class="fas fa-weight"></i>
                <input type="number" name="weight" step="0.1" placeholder="Weight (kg)" required>
            </div>

            <div class="input-group"><i class="fas fa-ruler-vertical"></i>
                <input type="number" name="height" step="1" placeholder="Height (cm)" required>
            </div>

            <div class="input-group"><i class="fas fa-lock"></i>
                <input type="password" name="password" id="password" placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword('password')"><i class="fas fa-eye"></i></span>
            </div>
            <div class="password-strength" id="passwordStrength"></div>

            <div class="input-group"><i class="fas fa-lock"></i>
                <input type="password" name="confirm_password" id="confirmPassword" placeholder="Confirm Password" required>
                <span class="toggle-password" onclick="togglePassword('confirmPassword')"><i class="fas fa-eye"></i></span>
            </div>
            <div class="password-match" id="passwordMatch"></div>

            <div class="terms">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">I agree to the <a href="#">Terms & Conditions</a> and <a href="#">Privacy Policy</a></label>
            </div>

            <button type="submit" class="signup-btn"><i class="fas fa-user-plus"></i> Sign Up</button>

            <p class="login-link">Already have an account? <a href="login.jsp">Login here</a></p>
        </form>
    </div>
</div>

<script src="js/signup.js"></script>
</body>
</html>
