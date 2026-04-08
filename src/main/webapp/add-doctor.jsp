<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Doctor - MedicalCare</title>
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
                <a href="add-doctor.jsp">Add Doctor</a>
                <a href="book-appointment.jsp">Book Appointment</a>
                <a href="view-appointments.jsp">Appointments</a>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="card">
            <h2>Add New Doctor</h2>
            <form action="AddDoctorServlet" method="POST">
                <div class="form-group">
                    <label for="name">Doctor Name (without 'Dr.' prefix)</label>
                    <input type="text" id="name" name="name" class="form-control" required placeholder="Jane Smith">
                </div>
                <div class="form-group">
                    <label for="specialization">Specialization</label>
                    <input type="text" id="specialization" name="specialization" class="form-control" required placeholder="Neurologist">
                </div>
                <button type="submit" class="btn">Add Doctor</button>
            </form>
        </div>
    </main>
</body>
</html>
