-- Create the database for DVD Loan Management System
CREATE DATABASE dvd_loan_system;
USE dvd_loan_system;

-- Create Borrower table
CREATE TABLE Borrower (
    borrower_no VARCHAR(10) PRIMARY KEY,
    borrower_name VARCHAR(50) NOT NULL,
    borrower_address VARCHAR(100),
    borrower_total_fine DECIMAL(6,2) DEFAULT 0.00,
    borrower_status VARCHAR(20) DEFAULT 'Active'
);

-- Create RentalCategory table
CREATE TABLE RentalCategory (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(30) NOT NULL,
    rental_duration INT NOT NULL,
    fine_charge_rate DECIMAL(4,2) NOT NULL
);

-- Create DVD table
CREATE TABLE DVD (
    dvd_no VARCHAR(10) PRIMARY KEY,
    dvd_title VARCHAR(100) NOT NULL,
    starring_actor VARCHAR(50),
    dvd_year INT,
    category_id INT,
    rental_cost DECIMAL(4,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES RentalCategory(category_id)
);

-- Create DVDCopy table
CREATE TABLE DVDCopy (
    copy_no VARCHAR(10) PRIMARY KEY,
    dvd_no VARCHAR(10) NOT NULL,
    shelf_position VARCHAR(10),
    dvd_status VARCHAR(20) DEFAULT 'Available',
    supplier_id INT,
    FOREIGN KEY (dvd_no) REFERENCES DVD(dvd_no)
);

-- Create Supplier table
CREATE TABLE Supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    supplier_contact VARCHAR(50),
    supplier_phone VARCHAR(15)
);

-- Create Loan table
CREATE TABLE Loan (
    loan_no VARCHAR(10) PRIMARY KEY,
    borrower_no VARCHAR(10) NOT NULL,
    loan_date DATE NOT NULL,
    total_loan_cost DECIMAL(6,2),
    FOREIGN KEY (borrower_no) REFERENCES Borrower(borrower_no)
);

-- Create LoanDetail table for many-to-many relationship
CREATE TABLE LoanDetail (
    loan_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_no VARCHAR(10) NOT NULL,
    copy_no VARCHAR(10) NOT NULL,
    return_due_date DATE NOT NULL,
    actual_return_date DATE,
    fine_amount DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no),
    FOREIGN KEY (copy_no) REFERENCES DVDCopy(copy_no)
);
