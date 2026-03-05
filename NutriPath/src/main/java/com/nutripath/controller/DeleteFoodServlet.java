package com.nutripath.controller;

import com.nutripath.model.DailyFoodDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteFood")
public class DeleteFoodServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                DailyFoodDAO dao = new DailyFoodDAO();
                dao.deleteDailyFood(id);  // Call your existing DAO
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("DailyTracker.jsp"); // Redirect back
    }
}
