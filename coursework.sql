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
-- Insert sample data into Borrower table
INSERT INTO Borrower VALUES
    ('BN1721', 'Ben Jones', '28 Low Road, Nottingham NG5 3PB', 0.00, 'Allowed'),
    ('BN1482', 'Sarah Smith', '14 High Street, Nottingham NG1 2AB', 5.50, 'Active'),
    ('BN1903', 'Mike Wilson', '7 Park Avenue, Nottingham NG2 5CD', 0.00, 'Active'),
    ('BN2045', 'Emma Thompson', '32 Queens Road, Nottingham NG3 7FE', 12.75, 'Suspended'),
    ('BN1563', 'James Brown', '9 River Street, Nottingham NG4 2GH', 0.00, 'Active');

-- Insert data into RentalCategory table
INSERT INTO RentalCategory (category_name, rental_duration, fine_charge_rate) VALUES
    ('Action', 7, 1.50),
    ('Adventure', 7, 1.50),
    ('Comedy', 3, 1.00),
    ('Drama', 3, 1.00),
    ('Superhero', 3, 1.75),
    ('Horror', 5, 1.25),
    ('Animation', 7, 1.00),
    ('Biography', 7, 1.25),
    ('Crime', 5, 1.50);

-- Insert data into DVD table
INSERT INTO DVD (dvd_no, dvd_title, category_id, starring_actor, dvd_year, rental_cost) VALUES
    ('DN050', 'Guardians of the Galaxy', 5, 'Chris Pratt', 2014, 4.50),
    ('DN0135', 'Prometheus', 2, 'Noomi Rapace', 2012, 3.50),
    ('DN0171', 'Split', 6, 'James McAvoy', 2016, 4.00),
    ('DN0102', 'Sing', 7, 'Matthew McConaughey', 2016, 3.50),
    ('DN0188', 'Suicide Squad', 5, 'Will Smith', 2016, 4.50),
    ('DN025', 'The Great Wall', 1, 'Matt Damon', 2016, 4.00),
    ('DN0157', 'La La Land', 3, 'Ryan Gosling', 2016, 4.50),
    ('DN0177', 'Mindhorn', 3, 'Essie Davis', 2016, 4.50),
    ('DN0129', 'The Lost City of Z', 1, 'Charlie Hunnam', 2016, 4.00),
    ('DN0114', 'Passengers', 2, 'Jennifer Lawrence', 2016, 3.50),
    ('DN087', 'Deadpool', 5, 'Ryan Reynolds', 2016, 4.50),
    ('DN0109', 'Doctor Strange', 5, 'Benedict Cumberbatch', 2016, 4.50),
    ('DN0116', 'The Avengers', 5, 'Robert Downey Jr.', 2012, 4.50),
    ('DN0179', 'Avengers: Age of Ultron', 5, 'Robert Downey Jr.', 2015, 4.50),
    ('DN073', 'The Dark Knight', 5, 'Christian Bale', 2008, 4.50);

-- Insert data into Supplier table
INSERT INTO Supplier (supplier_name, supplier_contact, supplier_phone) VALUES
    ('DVD Wholesale Ltd', 'John Manager', '01234567890'),
    ('Movie Supplies Co', 'Jane Director', '09876543210'),
    ('Cinema Warehouse', 'Bob Seller', '05678901234');

-- Insert data into DVDCopy table
INSERT INTO DVDCopy VALUES
    ('CN1099', 'DN050', 'SH001', 'On Loan', 1),
    ('CN8739', 'DN0135', 'AV002', 'On Loan', 1),
    ('CN2468', 'DN0171', 'HR003', 'Available', 2),
    ('CN1357', 'DN0102', 'AN004', 'Available', 3),
    ('CN5791', 'DN0188', 'SH005', 'Reserved', 2),
    ('CN3690', 'DN025', 'AC006', 'Missing', 3),
    ('CN4682', 'DN0157', 'CO007', 'On Loan', 1),
    ('CN7135', 'DN0177', 'CO008', 'Available', 2),
    ('CN9246', 'DN0129', 'AC009', 'On Loan', 3),
    ('CN8024', 'DN0114', 'AV010', 'Available', 1),
    ('CN6371', 'DN087', 'SH011', 'On Loan', 2),
    ('CN5793', 'DN0109', 'SH012', 'Available', 1),
    ('CN4681', 'DN0116', 'SH013', 'On Loan', 3),
    ('CN7134', 'DN0179', 'SH014', 'Available', 2),
    ('CN9245', 'DN073', 'SH015', 'Reserved', 1);

-- Insert data into Loan table
INSERT INTO Loan VALUES
    ('LN74857', 'BN1721', '2022-02-06', 8.00),
    ('LN74858', 'BN1482', '2022-02-10', 4.50),
    ('LN74859', 'BN1903', '2022-02-15', 6.50),
    ('LN74860', 'BN2045', '2022-03-01', 9.00),
    ('LN74861', 'BN1563', '2022-03-05', 4.00),
    ('LN74862', 'BN1721', '2022-03-12', 5.50),
    ('LN74863', 'BN1482', '2022-03-18', 3.50);

-- Insert data into LoanDetail table
INSERT INTO LoanDetail (loan_no, copy_no, return_due_date, actual_return_date, fine_amount) VALUES
    ('LN74857', 'CN1099', '2022-02-13', '2022-02-13', 0.00),
    ('LN74857', 'CN8739', '2022-02-13', '2022-02-15', 3.00),
    ('LN74858', 'CN3690', '2022-02-17', '2022-02-19', 2.00),
    ('LN74859', 'CN1357', '2022-02-18', '2022-02-18', 0.00),
    ('LN74859', 'CN5791', '2022-02-18', '2022-02-20', 2.00),
    ('LN74860', 'CN4682', '2022-03-04', NULL, 0.00),
    ('LN74860', 'CN9246', '2022-03-06', NULL, 0.00),
    ('LN74861', 'CN7135', '2022-03-08', '2022-03-07', 0.00),
    ('LN74862', 'CN6371', '2022-03-19', NULL, 0.00),
    ('LN74863', 'CN8024', '2022-03-21', '2022-03-25', 4.00);
