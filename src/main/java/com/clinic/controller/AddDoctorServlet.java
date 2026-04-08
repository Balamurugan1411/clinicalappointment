package com.clinic.controller;

import com.clinic.util.DBConnection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String name = req.getParameter("name"), spec = req.getParameter("specialization");
        
        if (name == null || spec == null || name.isEmpty() || spec.isEmpty()) {
            res.sendRedirect("add-doctor.jsp?error=InvalidInput"); 
            return;
        }

        try {
            DBConnection.executeUpdate("INSERT INTO doctors (name, specialization) VALUES (?, ?)", name, spec);
            res.sendRedirect("book-appointment.jsp?success=DoctorAdded");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("add-doctor.jsp?error=DatabaseError");
        }
    }
}
