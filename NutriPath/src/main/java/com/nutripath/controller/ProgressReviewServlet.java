package com.nutripath.controller;

import com.nutripath.beans.Goal;
import com.nutripath.model.DailyExerciseDAO;
import com.nutripath.model.DailyFoodDAO;
import com.nutripath.model.GoalDAO;
import com.nutripath.beans.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/progressReview")
public class ProgressReviewServlet extends HttpServlet {

    private GoalDAO goalDAO = new GoalDAO();
    private DailyFoodDAO foodDAO = new DailyFoodDAO();
    private DailyExerciseDAO exerciseDAO = new DailyExerciseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get current user from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        // Fetch user's goals
        List<Goal> goals = goalDAO.getGoalsByUser(userId);
        request.setAttribute("goals", goals);

        // Fetch total calories consumed and burned
        int totalCaloriesConsumed = foodDAO.getTotalCaloriesConsumed(userId);
        int totalCaloriesBurned = exerciseDAO.getTotalCaloriesBurned(userId);

        request.setAttribute("totalCaloriesConsumed", totalCaloriesConsumed);
        request.setAttribute("totalCaloriesBurned", totalCaloriesBurned);

        // Calculate net calories (consumed - burned)
        int netCalories = totalCaloriesConsumed - totalCaloriesBurned;
        request.setAttribute("netCalories", netCalories);

        // Forward to JSP page
        request.getRequestDispatcher("progressReview.jsp").forward(request, response);
    }
}
