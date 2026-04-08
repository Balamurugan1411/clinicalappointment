<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<%
    Integer doctorId = (Integer) session.getAttribute("doctorId");
    if (doctorId == null) {
        response.sendRedirect("doctor-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Dashboard - MedicalCare</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container nav">
            <div class="logo"><a href="index.html">MedicalCare Portal</a></div>
            <div class="nav-links">
                <a href="doctor-dashboard.jsp">My Appointments</a>
                <a href="LogoutServlet">Logout</a>
            </div>
        </div>
    </header>

    <main class="container">
        <h2>My Schedule</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th><th>Patient Name</th><th>Date</th><th>Time</th><th>Status</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement ps = conn.prepareStatement(
                                 "SELECT a.id, p.name as patient_name, a.date, a.time, a.status " +
                                 "FROM appointments a JOIN patients p ON a.patient_id = p.id " +
                                 "WHERE a.doctor_id = ? ORDER BY a.date DESC, a.time DESC")) {
                             ps.setInt(1, doctorId);
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
                        <td><%= rs.getDate("date") %></td>
                        <td><%= rs.getString("time") %></td>
                        <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                        <td>
                            <% if("Scheduled".equals(status)) { %>
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Completed">
                                <input type="hidden" name="redirect" value="doctor-dashboard.jsp">
                                <button type="submit" class="btn btn-small" style="background-color: #10b981;">Complete</button>
                            </form>
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Cancelled">
                                <input type="hidden" name="redirect" value="doctor-dashboard.jsp">
                                <button type="submit" class="btn btn-small" style="background-color: #ef4444;">Cancel</button>
                            </form>
                            <% } else { %> 
                            <form action="UpdateStatusServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="status" value="Scheduled">
                                <input type="hidden" name="redirect" value="doctor-dashboard.jsp">
                                <button type="submit" class="btn btn-small btn-outline" style="color: #64748b; border: 1px solid #64748b; background: transparent;">Undo Action</button>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                                }
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
