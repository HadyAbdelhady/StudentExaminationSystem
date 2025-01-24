

--------------------------------------------------------------------------------------
------------------------------- Instructor Course Tabel ------------------------------
--------------------------------------------------------------------------------------



-- Insert Course to Instructor
CREATE PROC insertCourseInstructor
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

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist.';
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


-- Get Course's Instructors
CREATE PROC getCourseInstructor
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

        -- Retrieve instructors for the course
        SELECT * FROM Course_Instructor
        WHERE courseID = @courseID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving instructors for the course.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO



-- Update Course Instructors
CREATE PROC updateCourseInstructors
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

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Update the instructor for the course
        UPDATE Course_Instructor
        SET instructorID = @instructorID
        WHERE courseID = @courseID;

        PRINT 'Course-Instructor relationship updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while updating the Course-Instructor relationship.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO

-- Update Instructor Courses 
CREATE PROC updateInstructorCourses
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

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE ID = @instructorID)
        BEGIN
            PRINT 'Instructor with ID ' + CAST(@instructorID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Update the course for the instructor
        UPDATE Course_Instructor
        SET courseID = @courseID
        WHERE instructorID = @instructorID;

        PRINT 'Instructor-Course relationship updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while updating the Instructor-Course relationship.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO



-- Delete Course Instructor
CREATE PROC deleteCourseInstructor
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