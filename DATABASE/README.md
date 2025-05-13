# Library Management System Database

## Project Description
This is a comprehensive Library Management System implemented using MySQL. The database is designed to handle all aspects of a library's operations, including member management, book inventory, loans, reservations, and fine calculations.

## Features
- Member registration and tracking
- Book catalog with authors, publishers, and categories
- Book loans and returns processing
- Reservation system
- Fine calculation for overdue books
- Staff management
- Audit logging for system actions
- Views for easy data access and reporting

## Database Schema

### Main Tables:
- **members**: Stores information about library members
- **books**: Contains the library's book inventory
- **authors**: Information about book authors
- **publishers**: Details about book publishers
- **categories**: Book genres and categories
- **loans**: Tracks borrowed books and return dates
- **reservations**: Manages book reservations
- **fines**: Records fines for overdue books
- **staff**: Information about library employees
- **audit_logs**: System activity tracking

### Relationship Tables:
- **book_authors**: Many-to-many relationship between books and authors
- **book_categories**: Many-to-many relationship between books and categories

## Entity Relationship Diagram (ERD)
![Library Management System ERD](https://drive.google.com/uc?id=1lqCDI-V-B9u_nCrqy3ZyUPVMbVNPpqQW)

## Setup Instructions

### Import the Database
1. Make sure you have MySQL server installed and running
2. Open your MySQL client or terminal
3. Run the following commands:

```sql
mysql -u your_username -p < library_management_system.sql
```

Alternatively, you can:
1. Open MySQL Workbench or phpMyAdmin
2. Create a new database named 'library_management_system'
3. Import the SQL file using the import feature

### Testing the Database
The SQL file includes sample data that you can use to test the functionality:
- 5 books with authors and categories
- 5 library members
- 5 sample loans (some current, some returned, some overdue)
- 2 sample reservations
- Staff records
- All necessary relationships

## SQL File Contents
The SQL file includes:
- Database and table creation with proper constraints
- Views for common operations
- Triggers for automated actions
- Sample data for testing

## Relationships Implemented
- One-to-Many: Publishers to Books
- Many-to-Many: Books to Authors, Books to Categories
- One-to-Many: Members to Loans, Books to Loans
- One-to-Many: Loans to Fines

## Future Enhancements
- Add stored procedures for common operations
- Implement more sophisticated fine calculation
- Add book inventory management features
- Create user roles and permissions
