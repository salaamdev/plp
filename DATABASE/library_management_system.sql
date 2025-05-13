-- Library Management System Database

-- Drop database if it exists to start fresh
DROP DATABASE IF EXISTS library_management_system;

-- Create database
CREATE DATABASE library_management_system;

-- Use the database
USE library_management_system;

-- Create Members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    date_of_birth DATE,
    membership_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    membership_status ENUM('active', 'expired', 'suspended') DEFAULT 'active',
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Create Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    biography TEXT
);

-- Create Publishers table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    website VARCHAR(100)
);

-- Create Categories table (for book genres)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Create Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    publication_date DATE,
    edition VARCHAR(20),
    pages INT CHECK (pages > 0),
    language VARCHAR(50) DEFAULT 'English',
    availability_status ENUM('available', 'borrowed', 'reserved', 'lost') DEFAULT 'available',
    shelf_location VARCHAR(50),
    added_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL
);

-- Create book_authors (Many-to-Many relationship between books and authors)
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Create book_categories (Many-to-Many relationship between books and categories)
CREATE TABLE book_categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Create Loans table (for tracking book borrowing)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('borrowed', 'returned', 'overdue', 'lost') DEFAULT 'borrowed',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (due_date >= borrow_date AND (return_date IS NULL OR return_date >= borrow_date))
);

-- Create Reservations table
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    expiry_date DATE NOT NULL,
    status ENUM('active', 'completed', 'cancelled', 'expired') DEFAULT 'active',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_reservation_dates CHECK (expiry_date > reservation_date)
);

-- Create Fines table (for tracking overdue fines)
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    member_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    date_imposed DATE NOT NULL DEFAULT (CURRENT_DATE),
    payment_date DATE,
    status ENUM('pending', 'paid', 'waived') DEFAULT 'pending',
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Create Staff table
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    position VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- Create Audit_Logs table (for tracking changes in the system)
CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    action_type ENUM('insert', 'update', 'delete') NOT NULL,
    record_id INT NOT NULL,
    staff_id INT,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- Create Views
-- View for books currently on loan
CREATE VIEW books_on_loan AS
SELECT b.book_id, b.title, b.isbn, 
       CONCAT(a.first_name, ' ', a.last_name) AS author_name,
       CONCAT(m.first_name, ' ', m.last_name) AS borrower_name,
       l.borrow_date, l.due_date, 
       DATEDIFF(CURRENT_DATE, l.due_date) AS days_overdue
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id
JOIN loans l ON b.book_id = l.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.status IN ('borrowed', 'overdue')
ORDER BY days_overdue DESC;

-- View for member activity
CREATE VIEW member_activity AS
SELECT m.member_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name,
       COUNT(DISTINCT l.loan_id) AS total_loans,
       SUM(CASE WHEN l.status = 'overdue' THEN 1 ELSE 0 END) AS current_overdue_items,
       COUNT(DISTINCT r.reservation_id) AS total_reservations,
       SUM(CASE WHEN f.status = 'pending' THEN f.amount ELSE 0 END) AS pending_fines
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
LEFT JOIN reservations r ON m.member_id = r.member_id
LEFT JOIN fines f ON m.member_id = f.member_id
GROUP BY m.member_id, member_name;

-- View for book availability
CREATE VIEW book_availability AS
SELECT b.book_id, b.title, b.isbn, 
       GROUP_CONCAT(DISTINCT CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS authors,
       GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories,
       b.availability_status,
       b.shelf_location
FROM books b
LEFT JOIN book_authors ba ON b.book_id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.author_id
LEFT JOIN book_categories bc ON b.book_id = bc.book_id
LEFT JOIN categories c ON bc.category_id = c.category_id
GROUP BY b.book_id, b.title, b.isbn, b.availability_status, b.shelf_location;

-- Triggers
-- Update book availability status when a book is borrowed
DELIMITER //
CREATE TRIGGER update_book_status_on_loan
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books
    SET availability_status = 'borrowed'
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;

-- Update book availability status when a book is returned
DELIMITER //
CREATE TRIGGER update_book_status_on_return
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF NEW.status = 'returned' AND OLD.status != 'returned' THEN
        UPDATE books
        SET availability_status = 'available'
        WHERE book_id = NEW.book_id;
    END IF;
END //
DELIMITER ;

-- Auto-generate fine for overdue books
DELIMITER //
CREATE TRIGGER generate_fine_for_overdue
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    DECLARE fine_amount DECIMAL(10, 2);
    
    IF NEW.status = 'overdue' AND OLD.status != 'overdue' THEN
        -- Calculate fine amount (e.g., $1 per day overdue)
        SET fine_amount = DATEDIFF(CURRENT_DATE, NEW.due_date) * 1.00;
        
        IF fine_amount > 0 THEN
            INSERT INTO fines (loan_id, member_id, amount, date_imposed, status)
            VALUES (NEW.loan_id, NEW.member_id, fine_amount, CURRENT_DATE, 'pending');
        END IF;
    END IF;
END //
DELIMITER ;

-- Sample data for testing (optional)
-- Insert sample categories
INSERT INTO categories (name, description) VALUES 
('Fiction', 'Literary works based on imagination'),
('Non-Fiction', 'Informational and factual writing'),
('Science Fiction', 'Fiction based on scientific discoveries or advanced technology'),
('Fantasy', 'Fiction with magical or supernatural elements'),
('Mystery', 'Fiction dealing with the solution of a crime or puzzle'),
('Biography', 'Account of someone\'s life written by someone else'),
('History', 'Study of past events'),
('Self-Help', 'Books aimed at helping readers solve personal problems'),
('Technology', 'Books about computer science, engineering, etc.'),
('Philosophy', 'Study of fundamental questions about existence, knowledge, values, etc.');

-- Insert sample publishers
INSERT INTO publishers (name, address, phone_number, email, website) VALUES 
('Penguin Random House', '1745 Broadway, New York, NY', '212-782-9000', 'info@penguinrandomhouse.com', 'www.penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY', '212-207-7000', 'info@harpercollins.com', 'www.harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY', '212-698-7000', 'contact@simonandschuster.com', 'www.simonandschuster.com'),
('Macmillan Publishers', '120 Broadway, New York, NY', '646-307-5151', 'info@macmillan.com', 'www.macmillan.com'),
('Oxford University Press', 'Great Clarendon Street, Oxford, OX2 6DP, UK', '+44-1865-556767', 'contact@oup.com', 'www.oup.com');

-- Insert sample authors
INSERT INTO authors (first_name, last_name, birth_date, nationality, biography) VALUES 
('J.K.', 'Rowling', '1965-07-31', 'British', 'British author best known for the Harry Potter series'),
('Stephen', 'King', '1947-09-21', 'American', 'American author of horror, supernatural fiction, suspense, and fantasy novels'),
('Jane', 'Austen', '1775-12-16', 'British', 'English novelist known primarily for her six major novels'),
('George', 'Orwell', '1903-06-25', 'British', 'English novelist, essayist, journalist, and critic'),
('Agatha', 'Christie', '1890-09-15', 'British', 'English writer known for her detective novels');

-- Insert sample members
INSERT INTO members (first_name, last_name, email, phone_number, address, date_of_birth, membership_date) VALUES 
('John', 'Doe', 'john.doe@email.com', '555-123-4567', '123 Main St, Anytown', '1985-05-15', '2023-01-10'),
('Jane', 'Smith', 'jane.smith@email.com', '555-234-5678', '456 Oak Ave, Somewhere', '1990-08-21', '2023-02-15'),
('Robert', 'Johnson', 'robert.j@email.com', '555-345-6789', '789 Pine Rd, Nowhere', '1978-11-30', '2023-03-20'),
('Sarah', 'Williams', 'sarah.w@email.com', '555-456-7890', '101 Maple Dr, Everywhere', '1995-04-12', '2023-04-25'),
('Michael', 'Brown', 'michael.b@email.com', '555-567-8901', '202 Cedar Ln, Anywhere', '1982-07-07', '2023-05-30');

-- Insert sample books
INSERT INTO books (isbn, title, publisher_id, publication_date, edition, pages, language, shelf_location) VALUES 
('9780747532743', 'Harry Potter and the Philosopher\'s Stone', 1, '1997-06-26', '1st', 223, 'English', 'A1-001'),
('9780307743657', 'The Shining', 2, '1977-01-28', '1st', 447, 'English', 'A2-003'),
('9780141439518', 'Pride and Prejudice', 3, '1813-01-28', 'Modern', 432, 'English', 'B1-005'),
('9780451524935', '1984', 4, '1949-06-08', 'Reprint', 328, 'English', 'B2-007'),
('9780062073501', 'Murder on the Orient Express', 5, '1934-01-01', 'Reissue', 274, 'English', 'C1-009');

-- Link books with authors
INSERT INTO book_authors (book_id, author_id) VALUES 
(1, 1), -- Harry Potter - J.K. Rowling
(2, 2), -- The Shining - Stephen King
(3, 3), -- Pride and Prejudice - Jane Austen
(4, 4), -- 1984 - George Orwell
(5, 5); -- Murder on the Orient Express - Agatha Christie

-- Link books with categories
INSERT INTO book_categories (book_id, category_id) VALUES 
(1, 4), -- Harry Potter - Fantasy
(1, 1), -- Harry Potter - Fiction
(2, 1), -- The Shining - Fiction
(3, 1), -- Pride and Prejudice - Fiction
(4, 1), -- 1984 - Fiction
(4, 3), -- 1984 - Science Fiction
(5, 5); -- Murder on the Orient Express - Mystery

-- Insert sample staff
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, salary, username, password_hash) VALUES 
('Admin', 'User', 'admin@library.com', '555-111-2222', 'System Administrator', '2022-01-01', 75000.00, 'admin', 'hashed_password_here'),
('Librarian', 'One', 'librarian1@library.com', '555-222-3333', 'Senior Librarian', '2022-02-15', 60000.00, 'librarian1', 'hashed_password_here'),
('Clerk', 'One', 'clerk1@library.com', '555-333-4444', 'Library Clerk', '2022-03-20', 40000.00, 'clerk1', 'hashed_password_here');

-- Insert sample loans
INSERT INTO loans (book_id, member_id, borrow_date, due_date, status) VALUES 
(1, 1, '2023-07-01', '2023-07-15', 'borrowed'),
(2, 2, '2023-07-05', '2023-07-19', 'borrowed'),
(3, 3, '2023-06-15', '2023-06-29', 'returned'),
(4, 4, '2023-06-20', '2023-07-04', 'overdue'),
(5, 5, '2023-07-10', '2023-07-24', 'borrowed');

-- Update the return date for the returned book
UPDATE loans SET return_date = '2023-06-28' WHERE book_id = 3 AND member_id = 3;

-- Insert sample reservations
INSERT INTO reservations (book_id, member_id, reservation_date, expiry_date, status) VALUES 
(3, 1, '2023-07-10', '2023-07-17', 'active'),
(5, 3, '2023-07-12', '2023-07-19', 'active');

-- This completes the library management system database schema with sample data
