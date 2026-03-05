package com.nutripath.controller;

import com.nutripath.beans.User;
import com.nutripath.model.DB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private DB db = new DB();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        // Update values
        user.setFullname(request.getParameter("fullname"));
        user.setEmail(request.getParameter("email"));
        user.setPhone_number(request.getParameter("phone_number"));
        user.setGender(request.getParameter("gender"));
        user.setWeight(Double.parseDouble(request.getParameter("weight")));
        user.setHeight(Double.parseDouble(request.getParameter("height")));

        boolean updated = db.updateUser(user);

        if (updated) {
            // IMPORTANT: update session user
            session.setAttribute("currentUser", user);
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
