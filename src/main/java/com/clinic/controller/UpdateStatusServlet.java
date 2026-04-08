package com.clinic.controller;

import com.clinic.util.DBConnection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id"), status = req.getParameter("status");
        String redirect = req.getParameter("redirect");
        
        if (id == null || status == null || id.isEmpty() || status.isEmpty()) {
            res.sendRedirect(redirect != null ? redirect + "?error=InvalidInput" : "view-appointments.jsp?error=InvalidInput"); 
            return;
        }

        try {
            DBConnection.executeUpdate("UPDATE appointments SET status = ? WHERE id = ?", status, Integer.parseInt(id));
            res.sendRedirect(redirect != null ? redirect + "?success=StatusUpdated" : "view-appointments.jsp?success=StatusUpdated");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(redirect != null ? redirect + "?error=DatabaseError" : "view-appointments.jsp?error=DatabaseError");
        }
    }
}
