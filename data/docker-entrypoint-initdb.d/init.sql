-- Create database
CREATE DATABASE IF NOT EXISTS test_database;

-- Use the created database
USE test_database;

-- Create table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  age INT NOT NULL
);

-- Insert data
INSERT INTO users (name, age) VALUES
('John Doe', 30),
('Jane Doe', 28);
