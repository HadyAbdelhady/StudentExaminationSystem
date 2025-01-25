

--------------------------------------------------------------------------------------
------------------------------- Instructor Course Tabel ------------------------------
--------------------------------------------------------------------------------------



-- Insert Course to Instructor
CREATE OR ALTER PROC insertCourseInstructor
    @courseID INT,
    @instructorID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course and instructor exist
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            PRINT 'Course with ID ' + CAST(@courseID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Insert the course-instructor relationship
        INSERT INTO Course_Instructor (courseID, instructorID)
        VALUES (@courseID, @instructorID);

        PRINT 'Course-Instructor relationship inserted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while inserting the Course-Instructor relationship.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO


CREATE OR ALTER PROC getInstructorsPerCourse
    @courseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists (regardless of deletion status)
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            PRINT 'Course with ID ' + CAST(@courseID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Retrieve active instructors with details for the course
        SELECT 
            CI.courseID,
            I.ID AS InstructorID,
            I.firstName,
            I.lastName,
            I.gender,
            I.SSN,
            I.email,
            I.phone,
            I.enrollmentDate,
            I.DateOfBirth,
            I.address
        FROM Course_Instructor CI
        INNER JOIN Instructor I ON CI.instructorID = I.ID
        WHERE CI.courseID = @courseID
          AND I.isDeleted = 0; -- Exclude deleted instructors

        PRINT 'Active instructors retrieved for course ID ' + CAST(@courseID AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error retrieving instructors: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- Delete Course Instructor
CREATE OR ALTER PROC deleteCourseInstructor
    @courseID INT,
    @instructorID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course-instructor relationship exists
        IF NOT EXISTS (SELECT 1 FROM Course_Instructor WHERE courseID = @courseID AND instructorID = @instructorID)
        BEGIN
            PRINT 'Course-Instructor relationship does not exist.';
            RETURN;
        END;

        -- Delete the course-instructor relationship
        DELETE FROM Course_Instructor
        WHERE courseID = @courseID
          AND instructorID = @instructorID;

        PRINT 'Course-Instructor relationship deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while deleting the Course-Instructor relationship.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

--Get All Instructors for a specific course by courseID
CREATE PROC getInstructorsPerCourse
    @courseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
        BEGIN
            PRINT 'Course with ID ' + CAST(@courseID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Retrieve instructors for the course, excluding deleted instructors
        SELECT 
            CI.courseID,
            CI.instructorID,
            I.firstName,
            I.lastName,
            I.gender,
            I.SSN,
            I.email,
            I.phone,
            I.enrollmentDate,
            I.DateOfBirth,
            I.address
        FROM Course_Instructor CI
        INNER JOIN Instructor I ON CI.instructorID = I.ID
        WHERE CI.courseID = @courseID
          AND I.isDeleted = 0; -- Ensure the instructor is not deleted

        PRINT 'Retrieved instructors for course ID ' + CAST(@courseID AS NVARCHAR) + ' successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving instructors for the course.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

--Get all the courses taught by a specific Instructor using InstructorID
CREATE OR ALTER PROC getCoursesPerInstructor
    @instructorID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID AND isDeleted = 0)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist or is deleted.';
            RETURN;
        END;

        -- Retrieve courses for the instructor, excluding deleted courses
        SELECT 
            CI.instructorID,
            C.ID AS courseID,
            C.Name AS courseName,
            C.creationDate
        FROM Course_Instructor CI
        INNER JOIN Course C ON CI.courseID = C.ID
        WHERE CI.instructorID = @instructorID 
          AND C.isDeleted = 0; -- Ensure the course is not deleted

        PRINT 'Retrieved courses for instructor ID ' + CAST(@instructorID AS NVARCHAR) + ' successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving courses for the instructor.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO