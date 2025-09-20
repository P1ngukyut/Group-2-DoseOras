CREATE DATABASE doseoras;


CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    roles ENUM('Patient', 'Care Giver', 'Admin', 'User') DEFAULT 'User'
);

CREATE TABLE Devices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    device_name VARCHAR(255) NOT NULL,
    ip_address VARCHAR(255) NOT NULL,
    status ENUM('Connected', 'Disconnected'),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    quantity INT CHECK (quantity >= 0 AND quantity <= 50),
    dosage_amount INT NOT NULL
);

CREATE TABLE User_Medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    medicine_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(id)
);

CREATE TABLE Schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    medicine_id INT,
    frequency INT,
    dosage_time TIME,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(id)
);

CREATE TABLE Alarms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT,
    user_id INT,
    device_id INT,
    message VARCHAR(255) NOT NULL,
    warning_message VARCHAR(255) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES Schedules(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (device_id) REFERENCES Devices(id)
);

CREATE TABLE Logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT,
    usermedicine_id INT,
    alarm_id INT,
    action_type ENUM('Insert', 'Update', 'Delete'),
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_value TEXT,
    new_value TEXT,
    FOREIGN KEY (schedule_id) REFERENCES Schedules(id),
    FOREIGN KEY (usermedicine_id) REFERENCES User_Medicines(id),
    FOREIGN KEY (alarm_id) REFERENCES Alarms(id)
);
