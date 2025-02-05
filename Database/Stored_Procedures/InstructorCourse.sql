

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
        -- Check if the course exists
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
            RETURN;
        END;

        -- Check if the instructor exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID AND isDeleted = 0)
        BEGIN
            RAISERROR('Instructor with ID %d does not exist or is deleted.', 16, 1, @instructorID);
            RETURN;
        END;

        -- Insert the course-instructor relationship
        INSERT INTO Course_Instructor (courseID, instructorID)
        VALUES (@courseID, @instructorID);

        PRINT 'Course-Instructor relationship inserted successfully.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while inserting the Course-Instructor relationship. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO

--Get All Instructors for a specific course by courseID
CREATE OR ALTER PROC getInstructorsPerCourse
    @courseID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the course exists and is not deleted
        IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID AND isDeleted = 0)
        BEGIN
            RAISERROR('Course with ID %d does not exist or is deleted.', 16, 1, @courseID);
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
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while retrieving instructors for the course. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
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
            RAISERROR('Course-Instructor relationship does not exist.', 16, 1);
            RETURN;
        END;

        -- Delete the course-instructor relationship
        DELETE FROM Course_Instructor
        WHERE courseID = @courseID
          AND instructorID = @instructorID;

        PRINT 'Course-Instructor relationship deleted successfully.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(
            'An error occurred while deleting the Course-Instructor relationship. Error: %s',
            16,
            1,
            @ErrorMessage
        );
    END CATCH;
END;
GO
