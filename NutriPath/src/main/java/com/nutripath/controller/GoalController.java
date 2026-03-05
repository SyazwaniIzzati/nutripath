package com.nutripath.controller;

import com.nutripath.beans.Goal;
import com.nutripath.beans.User;
import com.nutripath.model.GoalDAO;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/goal")
public class GoalController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private GoalDAO goalDao;

    @Override
    public void init() throws ServletException {
        goalDao = new GoalDAO();
    }

    // Display the goals page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch goals for this user
        List<Goal> goals = goalDao.getGoalsByUser(user.getId());
        request.setAttribute("goals", goals);

        // Forward to goal.jsp
        request.getRequestDispatcher("goal.jsp").forward(request, response);
    }

    // Handle form submission to add new goal
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String goalType = request.getParameter("goal_type");
        String startValueStr = request.getParameter("start_value");
        String targetValueStr = request.getParameter("target_value");
        String startDateStr = request.getParameter("start_date");
        String targetDateStr = request.getParameter("target_date");
        String notes = request.getParameter("notes");

        try {
            double startValue = Double.parseDouble(startValueStr);
            double targetValue = Double.parseDouble(targetValueStr);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDateUtil = sdf.parse(startDateStr);   // java.util.Date
            Date targetDateUtil = sdf.parse(targetDateStr); // java.util.Date

            // Convert to java.sql.Date
            java.sql.Date startDate = new java.sql.Date(startDateUtil.getTime());
            java.sql.Date targetDate = new java.sql.Date(targetDateUtil.getTime());

            // Create Goal object
            Goal goal = new Goal();
            goal.setUserId(user.getId());
            goal.setGoalType(goalType);
            goal.setStartValue(startValue);
            goal.setTargetValue(targetValue);
            goal.setStartDate(startDate);
            goal.setTargetDate(targetDate);
            goal.setNotes(notes);

            // Save goal
            goalDao.addGoal(goal);

        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check the values.");
        }

        response.sendRedirect("goal");
    }
}
