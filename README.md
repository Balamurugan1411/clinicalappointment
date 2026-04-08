# Clinic Appointment Management System

A full-stack Clinic Appointment Management System built with Java Servlets, JSP, HTML/CSS, and a relational database. This application allows patients to register and book appointments with doctors while providing an intuitive interface for appointment management.

## Features

*   **Patient Management**: Register new patients with their details (name, age, phone).
*   **Doctor Directory**: View available doctors and their specializations.
*   **Appointment Booking**: Schedule appointments with specific doctors for a chosen date and time.
*   **Modern User Interface**: A clean, responsive frontend including a glassmorphism dark theme for better user experience.

## Technology Stack

*   **Backend**: Java 11, Java Servlets API 4.0, JSP
*   **Frontend**: HTML5, CSS3 
*   **Database**: JDBC, MySQL (or SQLite depending on environment configuration)
*   **Build Tool**: Maven
*   **Server**: Embedded Jetty Server / Apache Tomcat

## Prerequisites

*   **Java Development Kit (JDK) 11** or higher.
*   **Maven** 3.6+ installed.
*   **MySQL Server** (if using MySQL as the primary database).

## Database Setup

1. Make sure your database server is running.
2. Execute the provided `db.sql` script in your database client to create the schema and seed initial data:

```sql
source db.sql;
```

This script will create the `clinic_db` database, set up `patients`, `doctors`, and `appointments` tables, and insert sample doctors.

## Running the Application Locally

The application uses Maven and the Jetty plugin for an easy local development setup.

1. **Clone or download the repository.**
2. **Navigate to the project root directory** (where `pom.xml` is located).
3. **Build the project and start the Jetty server**:

```bash
mvn clean install
mvn jetty:run
```

4. **Access the application**:
   Open your web browser and navigate to:
   [http://localhost:8080/ClinicApp](http://localhost:8080/ClinicApp)

## Project Structure

*   `/src/main/java/` - Contains the Java backend source code (Servlets, Models, Utilities).
*   `/src/main/webapp/` - Contains the frontend assets (HTML, CSS), JSP files, and the `WEB-INF/web.xml` configuration.
*   `pom.xml` - Maven configuration and dependency management.
*   `db.sql` - Database schema and initialization script.
