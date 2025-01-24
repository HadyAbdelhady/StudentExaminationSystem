BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 2;  -- Set Instructor ID to 2
    DECLARE @CourseID INT = 5;      -- Set Course ID to 5
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 1: SQL Basics
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'SELECT',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL command is used to retrieve data from a database?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'SELECT';
    EXEC insertQuestionBankChoice @QuestionID, 'INSERT';
    EXEC insertQuestionBankChoice @QuestionID, 'UPDATE';
    EXEC insertQuestionBankChoice @QuestionID, 'DELETE';

    -- Question 2: Data Types
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'VARCHAR',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL data type is used to store variable-length strings?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'VARCHAR';
    EXEC insertQuestionBankChoice @QuestionID, 'INT';
    EXEC insertQuestionBankChoice @QuestionID, 'DATE';
    EXEC insertQuestionBankChoice @QuestionID, 'BOOLEAN';

    -- Question 3: Primary Key
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'UNIQUE and NOT NULL',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What are the two main properties of a primary key?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'UNIQUE and NOT NULL';
    EXEC insertQuestionBankChoice @QuestionID, 'UNIQUE and NULL';
    EXEC insertQuestionBankChoice @QuestionID, 'NOT NULL and INDEXED';
    EXEC insertQuestionBankChoice @QuestionID, 'INDEXED and FOREIGN';

    -- Question 4: Joins
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'INNER JOIN',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which type of join returns only the rows with matching values in both tables?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'INNER JOIN';
    EXEC insertQuestionBankChoice @QuestionID, 'LEFT JOIN';
    EXEC insertQuestionBankChoice @QuestionID, 'RIGHT JOIN';
    EXEC insertQuestionBankChoice @QuestionID, 'FULL JOIN';

    -- Question 5: Transactions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'COMMIT',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL command is used to save the changes made during a transaction?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'COMMIT';
    EXEC insertQuestionBankChoice @QuestionID, 'ROLLBACK';
    EXEC insertQuestionBankChoice @QuestionID, 'SAVEPOINT';
    EXEC insertQuestionBankChoice @QuestionID, 'BEGIN';

    -- Question 6: Indexes
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Improve query performance',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of creating an index in a database?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Improve query performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Reduce storage space';
    EXEC insertQuestionBankChoice @QuestionID, 'Enforce data integrity';
    EXEC insertQuestionBankChoice @QuestionID, 'Automate backups';

    -- Question 7: Normalization
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Reduce data redundancy',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the main goal of database normalization?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Reduce data redundancy';
    EXEC insertQuestionBankChoice @QuestionID, 'Increase data redundancy';
    EXEC insertQuestionBankChoice @QuestionID, 'Improve query performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Simplify data entry';

    -- Question 8: Foreign Key
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Enforce referential integrity',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of a foreign key in a database?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Enforce referential integrity';
    EXEC insertQuestionBankChoice @QuestionID, 'Improve query performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Reduce storage space';
    EXEC insertQuestionBankChoice @QuestionID, 'Automate backups';

    -- Question 9: Views
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Virtual table based on the result-set of an SQL statement',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is a view in SQL?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Virtual table based on the result-set of an SQL statement';
    EXEC insertQuestionBankChoice @QuestionID, 'A physical table in the database';
    EXEC insertQuestionBankChoice @QuestionID, 'A type of index';
    EXEC insertQuestionBankChoice @QuestionID, 'A backup of a table';

    -- Question 10: Stored Procedures
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Precompiled collection of SQL statements',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is a stored procedure in SQL?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Precompiled collection of SQL statements';
    EXEC insertQuestionBankChoice @QuestionID, 'A type of index';
    EXEC insertQuestionBankChoice @QuestionID, 'A backup of a table';
    EXEC insertQuestionBankChoice @QuestionID, 'A virtual table';

    COMMIT TRANSACTION;
    PRINT 'All database questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
------------------------------------------------------------------

BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @InstructorID INT = 2;  -- Set Instructor ID to 2
    DECLARE @CourseID INT = 5;      -- Set Course ID to 5
    DECLARE @Type NVARCHAR(50) = 'Multiple Choice';
    DECLARE @QuestionID INT;

    -- Question 11: Aggregation Functions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'COUNT',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL function is used to count the number of rows in a table?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'COUNT';
    EXEC insertQuestionBankChoice @QuestionID, 'SUM';
    EXEC insertQuestionBankChoice @QuestionID, 'AVG';
    EXEC insertQuestionBankChoice @QuestionID, 'MAX';

    -- Question 12: Group By
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'GROUP BY',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL clause is used to group rows that have the same values in specified columns?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'GROUP BY';
    EXEC insertQuestionBankChoice @QuestionID, 'ORDER BY';
    EXEC insertQuestionBankChoice @QuestionID, 'HAVING';
    EXEC insertQuestionBankChoice @QuestionID, 'WHERE';

    -- Question 13: Constraints
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'NOT NULL',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL constraint ensures that a column cannot have NULL values?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'NOT NULL';
    EXEC insertQuestionBankChoice @QuestionID, 'UNIQUE';
    EXEC insertQuestionBankChoice @QuestionID, 'PRIMARY KEY';
    EXEC insertQuestionBankChoice @QuestionID, 'CHECK';

    -- Question 14: Subqueries
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'A query inside another query',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is a subquery in SQL?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'A query inside another query';
    EXEC insertQuestionBankChoice @QuestionID, 'A type of join';
    EXEC insertQuestionBankChoice @QuestionID, 'A backup of a table';
    EXEC insertQuestionBankChoice @QuestionID, 'A virtual table';

    -- Question 15: Transactions
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'ACID',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What property ensures that database transactions are processed reliably?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'ACID';
    EXEC insertQuestionBankChoice @QuestionID, 'BASE';
    EXEC insertQuestionBankChoice @QuestionID, 'CAP';
    EXEC insertQuestionBankChoice @QuestionID, 'CRUD';

    -- Question 16: Triggers
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Automatically execute in response to certain events',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the purpose of a trigger in SQL?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Automatically execute in response to certain events';
    EXEC insertQuestionBankChoice @QuestionID, 'Improve query performance';
    EXEC insertQuestionBankChoice @QuestionID, 'Enforce data integrity';
    EXEC insertQuestionBankChoice @QuestionID, 'Create backups';

    -- Question 17: Database Backup
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'To restore data in case of loss',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'What is the primary purpose of a database backup?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'To restore data in case of loss';
    EXEC insertQuestionBankChoice @QuestionID, 'To improve query performance';
    EXEC insertQuestionBankChoice @QuestionID, 'To enforce data integrity';
    EXEC insertQuestionBankChoice @QuestionID, 'To reduce storage space';

    -- Question 18: Database Normalization
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'Third Normal Form (3NF)',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which normal form ensures that there are no transitive dependencies?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'Third Normal Form (3NF)';
    EXEC insertQuestionBankChoice @QuestionID, 'First Normal Form (1NF)';
    EXEC insertQuestionBankChoice @QuestionID, 'Second Normal Form (2NF)';
    EXEC insertQuestionBankChoice @QuestionID, 'Boyce-Codd Normal Form (BCNF)';

    -- Question 19: Database Indexes
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'B-tree',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which data structure is commonly used for database indexes?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'B-tree';
    EXEC insertQuestionBankChoice @QuestionID, 'Linked List';
    EXEC insertQuestionBankChoice @QuestionID, 'Hash Table';
    EXEC insertQuestionBankChoice @QuestionID, 'Array';

    -- Question 20: Database Security
    EXEC InsertQuestion 
        @Type = @Type,
        @CorrectChoice = 'GRANT',
        @InstructorID = @InstructorID,
        @CourseID = @CourseID,
        @QuestionText = 'Which SQL command is used to give specific privileges to a user?',
        @QuestionID = @QuestionID OUTPUT;
    
    EXEC insertQuestionBankChoice @QuestionID, 'GRANT';
    EXEC insertQuestionBankChoice @QuestionID, 'REVOKE';
    EXEC insertQuestionBankChoice @QuestionID, 'DENY';
    EXEC insertQuestionBankChoice @QuestionID, 'ALLOW';

    COMMIT TRANSACTION;
    PRINT 'Additional database questions inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred while inserting the questions.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;