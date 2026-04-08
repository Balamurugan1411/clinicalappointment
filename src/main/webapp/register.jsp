<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration & Booking - MedicalCare</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container nav">
            <div class="logo">
                <a href="index.html">MedicalCare</a>
            </div>
            <div class="nav-links">
                <a href="index.html">Home</a>
                <a href="register.jsp">Register & Book</a>
                <a href="book-appointment.jsp">Returning Patients</a>
                <a href="view-appointments.jsp">Appointments</a>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="card">
            <h2>Register & Book Appointment</h2>
            <form action="RegisterServlet" method="POST">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" required placeholder="John Doe">
                </div>
                <div class="form-group">
                    <label for="age">Age</label>
                    <input type="number" id="age" name="age" class="form-control" required placeholder="30">
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="form-control" required placeholder="+1 234 567 8900">
                </div>
                
                <hr style="border: 1px solid var(--border); margin: 2rem 0;">
                
                <div class="form-group">
                    <label for="doctor_id">Select Doctor</label>
                    <select id="doctor_id" name="doctor_id" class="form-control" required>
                        <option value="">-- Select Doctor --</option>
                        <%
                            try (Connection conn = DBConnection.getConnection();
                                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM doctors");
                                 ResultSet rs = ps.executeQuery()) {
                                while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id") %>">Dr. <%= rs.getString("name") %> - <%= rs.getString("specialization") %></option>
                        <% 
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="date">Appointment Date</label>
                    <input type="date" id="date" name="date" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="time">Time Slot</label>
                    <select id="time" name="time" class="form-control" required>
                        <option value="">-- Select Time Slot --</option>
                        <option value="09:00 AM">09:00 AM</option>
                        <option value="10:00 AM">10:00 AM</option>
                        <option value="11:00 AM">11:00 AM</option>
                        <option value="01:00 PM">01:00 PM</option>
                        <option value="02:00 PM">02:00 PM</option>
                        <option value="03:00 PM">03:00 PM</option>
                        <option value="04:00 PM">04:00 PM</option>
                    </select>
                </div>

                <button type="submit" class="btn">Register & Book Now</button>
            </form>
        </div>
    </main>
</body>
</html>
