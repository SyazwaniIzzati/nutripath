package com.nutripath.controller;

import com.nutripath.beans.User;
import com.nutripath.model.DB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2️⃣ Basic input validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            response.sendRedirect("login.jsp?error=Username+and+password+are+required");
            return;
        }

        username = username.trim();

        // 3️⃣ Authenticate user from DB
        DB db = new DB();
        User user = db.validateUser(username, password);

        if (user == null) {
            // Invalid username/password
            response.sendRedirect("login.jsp?error=Invalid+username+or+password");
            return;
        }

        // 4️⃣ Store user in session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);  // Use "currentUser" consistently

        // 5️⃣ Redirect to user dashboard (no role distinction)
        response.sendRedirect("dashboard.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect("login.jsp");
    }
}
