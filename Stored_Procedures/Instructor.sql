
--------------------------------------------------------------------------------------
---------------------------------- Instructor Tabel ----------------------------------
--------------------------------------------------------------------------------------

-- view instructor
CREATE OR ALTER PROCEDURE selectInstructor
    @inputID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @inputID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@inputID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Select the instructor
        SELECT *
        FROM Instructor
        WHERE ID = @inputID AND isDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- update instructor
CREATE OR ALTER PROC updateInstructorData
    @instId INT,
    @fName VARCHAR(20),
    @lName VARCHAR(20),
    @Gender VARCHAR(1),
    @ssn NVARCHAR(20),
    @mail VARCHAR(100),
    @mobilePhone NVARCHAR(15),
    @enrollDate DATETIME,
    @DOB DATETIME,
    @homeAt VARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instId AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instId AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Update the instructor
        UPDATE Instructor 
        SET DateOfBirth = @DOB,
            firstName = @fName,
            lastName = @lName,
            gender = @Gender,
            SSN = @ssn,
            email = @mail,
            phone = @mobilePhone,
            enrollmentDate = @enrollDate,
            address = @homeAt
        WHERE ID = @instId AND isDeleted = 0;

        PRINT 'Instructor data updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while updating the instructor data.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- delete instructor
CREATE OR ALTER PROC deleteInstructor
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    -- Check if the instructor exists and is not already deleted
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID AND isDeleted = 0)
    BEGIN
        PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist or is already deleted.';
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete records from tables that reference the Instructor table
        DELETE FROM Course_Instructor
        WHERE instructorID = @instID;

        DELETE FROM Department_Instructor
        WHERE instructorID = @instID;

        -- Mark the instructor as deleted
        UPDATE Instructor
        SET isDeleted = 1
        WHERE ID = @instID;

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Print success message
        PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' has been marked as deleted. All references have been updated to instructorID = 0.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of an error
        ROLLBACK TRANSACTION;
        PRINT 'An error occurred while deleting the instructor. Changes have been rolled back.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END
GO

-- Insert Instructor
CREATE OR ALTER PROC insertInstructor
    @fName VARCHAR(20),
    @lName VARCHAR(20),
    @Gender VARCHAR(1),
    @ssn NVARCHAR(20),
    @mail VARCHAR(100),
    @mobilePhone NVARCHAR(15),
    @enrollDate DATETIME,
    @DOB DATETIME,
    @homeAt VARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the SSN already exists and is not deleted
        IF EXISTS (SELECT 1 FROM Instructor WHERE SSN = @ssn AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with SSN ' + CAST(@ssn AS NVARCHAR) + ' already exists and is active.';
            RETURN;
        END;

        -- Check if the instructor was previously deleted
        IF EXISTS (SELECT 1 FROM Instructor WHERE SSN = @ssn AND isDeleted = 1)
        BEGIN
            -- Reactivate the instructor by updating isDeleted to 0
            UPDATE Instructor
            SET 
                firstName = @fName,
                lastName = @lName,
                gender = @Gender,
                email = @mail,
                phone = @mobilePhone,
                enrollmentDate = @enrollDate,
                DateOfBirth = @DOB,
                address = @homeAt,
                isDeleted = 0
            WHERE SSN = @ssn;

            PRINT 'Instructor with SSN ' + CAST(@ssn AS NVARCHAR) + ' was previously deleted and has been reactivated.';
            RETURN;
        END;

        -- Insert the instructor if they don't exist
        INSERT INTO Instructor
            (firstName, lastName, gender, SSN, email, phone, enrollmentDate, DateOfBirth, address, isDeleted)
        VALUES
            (@fName, @lName, @Gender, @ssn, @mail, @mobilePhone, @enrollDate, @DOB, @homeAt, 0);

        PRINT 'Instructor inserted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while inserting the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- get the number of student in each course that the instructor teach
CREATE OR ALTER PROC GetInstructorCoursesWithStudentCount
    @instructorID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor 
            WHERE ID = @instructorID AND isDeleted = 0
        )
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Get course names and student counts
        SELECT 
            C.Name AS CourseName,
            COUNT(DISTINCT S.ID) AS StudentCount  -- Distinct to avoid duplicates
        FROM 
            Course_Instructor CI
        INNER JOIN 
            Course C ON CI.courseID = C.ID AND C.isDeleted = 0
        LEFT JOIN 
            Course_Student_Instructor CSI 
            ON CI.courseID = CSI.courseID 
            AND CI.instructorID = CSI.instructorID
        LEFT JOIN 
            Student S 
            ON CSI.studentID = S.ID 
            AND S.isDeleted = 0  -- Only count active students
        WHERE 
            CI.instructorID = @instructorID
        GROUP BY 
            C.ID, C.Name;  -- Group by ID to handle duplicate course names

        PRINT 'Courses and student counts retrieved successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH;
END;
GO

-- get how many course does an instructor teach
CREATE OR ALTER PROC getInstructorCoursesCount
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Get the number of courses taught by the instructor
        SELECT COUNT(*) AS courseCount
        FROM Course_Instructor
        WHERE instructorID = @instID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the course count for the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- get the names of the courses that the instructor teach
CREATE OR ALTER PROC getInstructorCourses
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Get the names of the courses taught by the instructor
        SELECT Course.Name AS courseName
        FROM Course
        WHERE ID IN (SELECT courseID FROM Course_Instructor WHERE instructorID = @instID) AND isDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the courses taught by the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- get the number of the exams that the instructor created
CREATE OR ALTER PROC getInstructorExamsCount
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Get the number of exams created by the instructor
        SELECT COUNT(*) AS examCount
        FROM ExamModel
        WHERE instructorID = @instID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the exam count for the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- Get All the Deleted Instructors
CREATE OR ALTER PROC getDeletedInstructors
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Select all instructors where isDeleted = 1
        SELECT 
            ID,
            firstName,
            lastName,
            gender,
            SSN,
            email,
            phone,
            enrollmentDate,
            DateOfBirth,
            address
        FROM Instructor
        WHERE isDeleted = 1;

        PRINT 'Retrieved all deleted instructors successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving deleted instructors.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

--Retrieve All the Current Instructors (that are not deleted)
CREATE OR ALTER PROC GetAllInstructors
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Retrieve all instructors who are not deleted
        SELECT 
            ID,
            firstName,
            lastName,
            gender,
            SSN,
            email,
            phone,
            enrollmentDate,
            DateOfBirth,
            address
        FROM Instructor
        WHERE isDeleted = 0; -- Only retrieve active instructors

        PRINT 'Retrieved all active instructors successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving instructors.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO