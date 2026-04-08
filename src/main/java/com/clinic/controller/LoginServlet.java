package com.clinic.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String doctorId = req.getParameter("doctor_id");
        String password = req.getParameter("password");
        
        if (doctorId != null && "1234".equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("doctorId", Integer.parseInt(doctorId));
            res.sendRedirect("doctor-dashboard.jsp");
        } else {
            res.sendRedirect("doctor-login.jsp?error=InvalidCredentials");
        }
    }
}
