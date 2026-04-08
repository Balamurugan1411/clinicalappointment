<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - MedicalCare</title>
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
                <a href="book-appointment.jsp">Book Appointment</a>
                <a href="view-appointments.jsp">Appointments</a>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="card">
            <h2>Book Appointment</h2>
            <form action="BookAppointmentServlet" method="POST">
                
                <div class="form-group">
                    <label for="patient_id">Select Patient</label>
                    <select id="patient_id" name="patient_id" class="form-control" required>
                        <option value="">-- Select Patient --</option>
                        <%
                            try (Connection conn = DBConnection.getConnection();
                                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM patients");
                                 ResultSet rs = ps.executeQuery()) {
                                while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %> (Phone: <%= rs.getString("phone") %>)</option>
                        <% 
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

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
                    <label for="time">Time</label>
                    <input type="time" id="time" name="time" class="form-control" required>
                </div>

                <button type="submit" class="btn">Book Now</button>
            </form>
        </div>
    </main>
</body>
</html>
