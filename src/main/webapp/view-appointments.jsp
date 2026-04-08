<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Appointments - MedicalCare</title>
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
        <h2>All Appointments</h2>
        <div style="margin-bottom: 1rem;">
            <strong>Filter by Status: </strong>
            <a href="view-appointments.jsp" class="btn btn-small" style="background:var(--primary-color);">All</a>
            <a href="view-appointments.jsp?filter=Scheduled" class="btn btn-small" style="background:#b45309;">Scheduled</a>
            <a href="view-appointments.jsp?filter=Completed" class="btn btn-small" style="background:#15803d;">Completed</a>
            <a href="view-appointments.jsp?filter=Cancelled" class="btn btn-small" style="background:#b91c1c;">Cancelled</a>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient Name</th>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String filter = request.getParameter("filter");
                        String sql = "SELECT a.id, p.name as patient_name, d.name as doctor_name, a.date, a.time, a.status " +
                                     "FROM appointments a " +
                                     "JOIN patients p ON a.patient_id = p.id " +
                                     "JOIN doctors d ON a.doctor_id = d.id ";
                        if (filter != null && !filter.isEmpty()) {
                            sql += "WHERE a.status = ? ";
                        }
                        sql += "ORDER BY a.date DESC, a.time DESC";

                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement ps = conn.prepareStatement(sql)) {
                             
                            if (filter != null && !filter.isEmpty()) {
                                ps.setString(1, filter);
                            }
                            
                            try (ResultSet rs = ps.executeQuery()) {
                                while(rs.next()) {
                                String status = rs.getString("status");
                                String statusClass = "status-scheduled";
                                if("Completed".equals(status)) statusClass = "status-completed";
                                else if("Cancelled".equals(status)) statusClass = "status-cancelled";
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("patient_name") %></td>
                        <td>Dr. <%= rs.getString("doctor_name") %></td>
                        <td><%= rs.getDate("date") %></td>
                        <td><%= rs.getString("time") %></td>
                        <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                        <td>
                            <% if("Scheduled".equals(status)) { %>
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Completed">
                                <button type="submit" class="btn btn-small" style="background-color: #10b981;">Complete</button>
                            </form>
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Cancelled">
                                <button type="submit" class="btn btn-small" style="background-color: #ef4444;">Cancel</button>
                            </form>
                            <% } else { %>
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Scheduled">
                                <button type="submit" class="btn btn-small btn-outline" style="color: #64748b; border: 1px solid #64748b; background: transparent;">Undo Action</button>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                                }
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
