
--------------------------------------------------------------------------------------
---------------------------------- Instructor Tabel ----------------------------------
--------------------------------------------------------------------------------------

-- view instructor
CREATE PROCEDURE selectInstructor
    @inputID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @inputID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@inputID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Select the instructor
        SELECT *
        FROM Instructor
        WHERE ID = @inputID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- update instructor
CREATE PROC updateInstructorData
    @instId INT,
    @fName VARCHAR(10),
    @lName VARCHAR(10),
    @Gender VARCHAR(1),
    @ssn INT,
    @mail VARCHAR(100),
    @mobilePhone INT,
    @enrollDate DATETIME,
    @DOB DATETIME,
    @homeAt VARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instId)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instId AS NVARCHAR) + ' does not exist.';
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
        WHERE ID = @instId;

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
CREATE PROC deleteInstructor
	@instID INT
WITH
	ENCRYPTION
AS
BEGIN
	-- Check if the instructor exists
	IF NOT EXISTS (SELECT 1
	FROM Instructor
	WHERE ID = @instID)
    BEGIN
		PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
		RETURN;
	END;

	-- Update all tables that reference the Instructor table
	BEGIN TRY
        BEGIN TRANSACTION;

        -- Update QuestionBank
        UPDATE QuestionBank
        SET instructorID = 0
        WHERE instructorID = @instID;

        -- Update ExamModel
        UPDATE ExamModel
        SET instructorID = 0
        WHERE instructorID = @instID;

        -- Update Course_Instructor
        UPDATE Course_Instructor
        SET instructorID = 0
        WHERE instructorID = @instID;

        -- Update Department_Instructor
        UPDATE Department_Instructor
        SET instructorID = 0
        WHERE instructorID = @instID;

        -- Delete the instructor
        DELETE FROM Instructor
        WHERE ID = @instID;

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Print success message
        PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' has been deleted. All references have been updated to instructorID = 0.';
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
CREATE PROC insertInstructor
    @fName VARCHAR(10),
    @lName VARCHAR(10),
    @Gender VARCHAR(1),
    @ssn INT,
    @mail VARCHAR(100),
    @mobilePhone INT,
    @enrollDate DATETIME,
    @DOB DATETIME,
    @homeAt VARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the SSN already exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE SSN = @ssn)
        BEGIN
            PRINT 'Instructor with SSN ' + CAST(@ssn AS NVARCHAR) + ' already exists.';
            RETURN;
        END;

        -- Insert the instructor
        INSERT INTO Instructor
            (firstName, lastName, gender, SSN, email, phone, enrollmentDate, DateOfBirth, address)
        VALUES
            (@fName, @lName, @Gender, @ssn, @mail, @mobilePhone, @enrollDate, @DOB, @homeAt);

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
CREATE PROC getInstructorCoursesStudentCount
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Get the number of students in each course taught by the instructor
        SELECT COUNT(*) AS studentCount, courseID
        FROM Student
        WHERE courseID IN (SELECT courseID FROM Course_Instructor WHERE instructorID = @instID)
        GROUP BY courseID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the student count for courses taught by the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- get how many course does an instructor teach
CREATE PROC getInstructorCoursesCount
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
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
CREATE PROC getInstructorCourses
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Get the names of the courses taught by the instructor
        SELECT Course.Name AS courseName
        FROM Course
        WHERE ID IN (SELECT courseID FROM Course_Instructor WHERE instructorID = @instID);
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the courses taught by the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- get the number of the exams that the instructor created
CREATE PROC getInstructorExamsCount
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
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

-- get success rate per course for the instructor
CREATE PROC getAvgRatePerCourseCreatedByInstructor
    @instID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Get the success rate per course created by the instructor
        SELECT
            Course.Name AS CourseName,
            ROUND(AVG(grade), 2) AS successRate,
            Instructor.firstName + ' ' + Instructor.lastName AS InstructorName
        FROM
            StudentSubmit
            JOIN ExamModel ON StudentSubmit.examModelID = ExamModel.ID
            JOIN Course ON ExamModel.courseID = Course.ID
            JOIN Instructor ON ExamModel.instructorID = Instructor.ID
        WHERE 
            ExamModel.instructorID = @instID
        GROUP BY 
            Course.Name, Instructor.firstName, Instructor.lastName;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving the success rate per course for the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO