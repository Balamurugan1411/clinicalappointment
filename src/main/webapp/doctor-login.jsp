<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Login - MedicalCare</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container nav">
            <div class="logo"><a href="index.html">MedicalCare</a></div>
            <div class="nav-links">
                <a href="index.html">Home</a>
                <a href="register.jsp">Register & Book</a>
                <a href="doctor-login.jsp">Doctor Login</a>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="card">
            <h2>Doctor Portal Login</h2>
            <form action="LoginServlet" method="POST">
                <div class="form-group">
                    <label for="doctor_id">Select Doctor Profile</label>
                    <select id="doctor_id" name="doctor_id" class="form-control" required>
                        <option value="">-- Choose Profile --</option>
                        <%
                            try (Connection conn = DBConnection.getConnection();
                                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM doctors");
                                 ResultSet rs = ps.executeQuery()) {
                                while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id") %>">Dr. <%= rs.getString("name") %></option>
                        <% 
                                }
                            } catch(Exception e) {}
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="password">Password (Default: 1234)</label>
                    <input type="password" id="password" name="password" class="form-control" required value="1234">
                </div>
                <button type="submit" class="btn">Login Securely</button>
            </form>
        </div>
    </main>
</body>
</html>
