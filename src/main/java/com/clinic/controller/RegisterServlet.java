package com.clinic.controller;

import com.clinic.util.DBConnection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String name = req.getParameter("name");
        String age = req.getParameter("age");
        String phone = req.getParameter("phone");
        String doctorId = req.getParameter("doctor_id");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        
        if (name == null || age == null || phone == null || name.isEmpty() || age.isEmpty() || phone.isEmpty()) {
            res.sendRedirect("register.jsp?error=InvalidInput"); 
            return;
        }

        try {
            int pId = DBConnection.executeInsertAndGetId("INSERT INTO patients (name, age, phone) VALUES (?, ?, ?)", name, Integer.parseInt(age), phone);
            
            if (doctorId != null && !doctorId.isEmpty() && date != null && !date.isEmpty() && time != null && !time.isEmpty()) {
                DBConnection.executeUpdate("INSERT INTO appointments (patient_id, doctor_id, date, time, status) VALUES (?, ?, ?, ?, 'Scheduled')", 
                    pId, Integer.parseInt(doctorId), date, time);
                res.sendRedirect("view-appointments.jsp?success=RegistrationAndAppointmentBooked");
            } else {
                res.sendRedirect("book-appointment.jsp?success=RegistrationSuccessful");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=DatabaseError");
        }
    }
}
