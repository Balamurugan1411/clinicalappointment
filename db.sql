CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    date DATE,
    time VARCHAR(20),
    status VARCHAR(50) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);


INSERT INTO doctors (name, specialization) VALUES ('Dr. Smith', 'General Physician');
INSERT INTO doctors (name, specialization) VALUES ('Dr. Adams', 'Cardiologist');
INSERT INTO doctors (name, specialization) VALUES ('Dr. Lee', 'Dermatologist');
