package com.nutripath.controller;

import com.nutripath.beans.DailyExercise;
import com.nutripath.model.DailyExerciseDAO;
import com.nutripath.beans.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/addExercise")
public class DailyExerciseController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // handle UTF-8 input

        try {
            // 1️⃣ Get current logged-in user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = user.getId(); // get userId from session

            // 2️⃣ Get form data
            String exerciseName = request.getParameter("exerciseName");
            int duration = Integer.parseInt(request.getParameter("duration")); // in minutes
            Date logDate = Date.valueOf(request.getParameter("logDate")); // format: yyyy-mm-dd

            // 3️⃣ Create Bean
            DailyExercise exercise = new DailyExercise();
            exercise.setUserId(userId);
            exercise.setExerciseName(exerciseName);
            exercise.setDuration(duration);
            exercise.setLogDate(logDate);
            // ✅ Do NOT set caloriesBurned here. DAO will calculate automatically

            // 4️⃣ Insert into DB using DAO
            DailyExerciseDAO dao = new DailyExerciseDAO();
            boolean inserted = dao.addDailyExercise(exercise);

            // 5️⃣ Redirect back with message
            if (inserted) {
                response.sendRedirect("DailyTracker.jsp?success=exercise");
            } else {
                response.sendRedirect("DailyTracker.jsp?error=exercise");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DailyTracker.jsp?error=exercise");
        }
    }
}
