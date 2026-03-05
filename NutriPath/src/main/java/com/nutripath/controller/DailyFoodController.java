package com.nutripath.controller;

import com.nutripath.beans.DailyFood;
import com.nutripath.model.DailyFoodDAO;
import com.nutripath.beans.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/addFood")
public class DailyFoodController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Handle UTF-8 input

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = user.getId();
            String foodName = request.getParameter("foodName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int caloriesPerUnit = Integer.parseInt(request.getParameter("caloriesPerUnit"));
            Date logDate = Date.valueOf(request.getParameter("logDate")); // yyyy-mm-dd

            // Create DailyFood bean
            DailyFood food = new DailyFood();
            food.setUserId(userId);
            food.setFoodName(foodName);
            food.setQuantity(quantity);
            food.setCaloriesPerUnit(caloriesPerUnit);
            food.setLogDate(logDate);

            // Insert into database using DAO
            DailyFoodDAO dao = new DailyFoodDAO();
            boolean inserted = dao.addDailyFood(food);

            // Redirect back with status
            if (inserted) {
                response.sendRedirect("DailyTracker.jsp?success=food");
            } else {
                response.sendRedirect("DailyTracker.jsp?error=food");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DailyTracker.jsp?error=food");
        }
    }
}
