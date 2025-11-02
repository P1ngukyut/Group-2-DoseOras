CREATE DATABASE IF NOT EXISTS medicine_dispenser_db;
USE medicine_dispenser_db;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('admin', 'user') DEFAULT 'user'
);


CREATE TABLE Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    device_name VARCHAR(100) NOT NULL,
    ip_address VARCHAR(45),
    status ENUM('Connected', 'Disconnected') DEFAULT 'Disconnected',
    last_active DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
);


CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,         -- total pills in dispenser
    dosage_amount INT NOT NULL     -- number of pills to intake
);


CREATE TABLE Schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    medicine_id INT NOT NULL,
    frequency INT NOT NULL,         -- times per day
    dosage_time TIME NOT NULL,      -- specific time for intake of pills
    wait_time TIME NOT NULL,        -- interval between doses
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
        ON DELETE CASCADE
);


CREATE TABLE Alarms (
    alarm_id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    alarm_type ENUM('Initial', 'Snooze') DEFAULT 'Initial',
    message VARCHAR(255),
    FOREIGN KEY (schedule_id) REFERENCES Schedules(schedule_id)
        ON DELETE CASCADE
);
