package com.nutripath.controller;

import com.nutripath.beans.User;
import com.nutripath.model.DB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class Signup extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String phone = request.getParameter("phone_number");
        String gender = request.getParameter("gender");

        double weight = parseDouble(request.getParameter("weight"));
        double height = parseDouble(request.getParameter("height"));

        DB db = new DB();

        // Validation
        String error = validateInput(username, fullname, email, password,
                                     confirmPassword, phone, weight, height, db);

        if (error != null) {
            response.sendRedirect("signup.jsp?error=" + error);
            return;
        }

        // Create User object
        User user = new User();
        user.setUsername(username.trim());
        user.setFullname(fullname.trim());
        user.setEmail(email.trim());
        user.setPassword(password); // ⚠ hash later
        user.setPhone_number(phone.trim());
        user.setGender(gender);
        user.setWeight(weight);
        user.setHeight(height); // BMI auto-calculated in bean

        // Save user (no role needed)
        boolean success = db.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?signup=success");
        } else {
            response.sendRedirect("signup.jsp?error=Registration failed");
        }
    }

    // ================= VALIDATION =================
    private String validateInput(String username, String fullname, String email,
                                 String password, String confirmPassword,
                                 String phone, double weight, double height, DB db) {

        if (username == null || username.trim().isEmpty())
            return "Username is required";

        if (fullname == null || fullname.trim().isEmpty())
            return "Full name is required";

        if (email == null || email.trim().isEmpty())
            return "Email is required";

        if (db.isEmailExists(email))
            return "Email already registered";

        if (password == null || password.trim().isEmpty())
            return "Password is required";

        if (!password.equals(confirmPassword))
            return "Passwords do not match";

        if (phone == null || phone.trim().isEmpty())
            return "Phone number is required";

        if (weight <= 0)
            return "Invalid weight";

        if (height <= 0)
            return "Invalid height";

        return null;
    }

    // Safe double parsing
    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("signup.jsp");
    }
}
