package com.clinic.controller;

import com.clinic.util.DBConnection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String pId = req.getParameter("patient_id"), dId = req.getParameter("doctor_id"), date = req.getParameter("date"), time = req.getParameter("time");
        
        if (pId == null || dId == null || date == null || time == null || pId.isEmpty() || dId.isEmpty() || date.isEmpty() || time.isEmpty()) {
            res.sendRedirect("book-appointment.jsp?error=InvalidInput"); 
            return;
        }

        try {
            DBConnection.executeUpdate("INSERT INTO appointments (patient_id, doctor_id, date, time, status) VALUES (?, ?, ?, ?, 'Scheduled')", 
                Integer.parseInt(pId), Integer.parseInt(dId), date, time);
            res.sendRedirect("view-appointments.jsp?success=AppointmentBooked");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("book-appointment.jsp?error=DatabaseError");
        }
    }
}
