-- Create Database
CREATE DATABASE movie;

-- Use the movie database
USE movie;

CREATE TABLE users (
    phone_number VARCHAR(10) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    phone_number VARCHAR(10) NOT NULL,  -- Taken from session
    language VARCHAR(50) NOT NULL,
    show_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL,
    movie VARCHAR(100) NOT NULL,
    theater VARCHAR(100) NOT NULL,
    seats TEXT NOT NULL,  -- Stores seat numbers as a comma-separated string (e.g., "A1,A2,A3")
    total_amount DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    final_price DECIMAL(10,2) NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (phone_number) REFERENCES users(phone_number) ON DELETE CASCADE
);