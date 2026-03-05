package com.nutripath.controller;

import com.nutripath.model.DailyExerciseDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteExercise")
public class DeleteExerciseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                DailyExerciseDAO dao = new DailyExerciseDAO();
                dao.deleteDailyExercise(id);  // Call your existing DAO
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("DailyTracker.jsp"); // Redirect back
    }
}
