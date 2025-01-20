-----------------------------------------------------
--------------------- ExamModel ---------------------
-----------------------------------------------------
CREATE PROCEDURE InsertExamModel
    @date DATE,
    @startTime TIME,
    @endTime TIME,
    @CourseID INT,
    @instructorID INT,
    @NewExamModelID INT OUTPUT
-- New output parameter to return the identity value
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the instructor ID is valid
        IF NOT EXISTS (SELECT 1
    FROM Instructor
    WHERE ID = @instructorID)
        BEGIN
        RAISERROR('The Instructor ID is not valid.', 16, 1);
        RETURN;
    END

        -- Check if the course ID is valid
        IF NOT EXISTS (SELECT 1
    FROM Course
    WHERE ID = @CourseID)
        BEGIN
        RAISERROR('The Course ID is not valid.', 16, 1);
        RETURN;
    END

        -- Check if the end time is after the start time
        IF @endTime <= @startTime
        BEGIN
        RAISERROR('The end time must be after the start time.', 16, 1);
        RETURN;
    END

        -- Insert into ExamModel table
        INSERT INTO ExamModel
        (date, startTime, endTime, CourseID, instructorID)
    VALUES
        (@date, @startTime, @endTime, @CourseID, @instructorID);

        -- Set the output parameter to the last inserted identity value
        SET @NewExamModelID = SCOPE_IDENTITY();

        -- Return success message
        SELECT 'Exam model inserted successfully.' AS Message;
    END TRY
    BEGIN CATCH
        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        -- Optionally, log the error or re-throw it
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

CREATE PROCEDURE DeleteExamModel
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages

    BEGIN TRY
        -- Check if the exam model ID exists
        IF NOT EXISTS (SELECT 1
    FROM ExamModel
    WHERE ID = @examModelID)
        BEGIN
        RAISERROR('The Exam Model with ID %d does not exist or may already be deleted.', 16, 1, @examModelID);
        RETURN;
    END

        BEGIN TRANSACTION; -- Start a transaction

        -- Delete the exam model questions first
        DELETE FROM ExamModel_Question
        WHERE examModelID = @examModelID;

        -- Delete the exam model
        DELETE FROM ExamModel
        WHERE ID = @examModelID;

        COMMIT TRANSACTION; -- Commit the transaction if successful

        -- Return success message
        SELECT 'Exam Model and its questions deleted successfully.' AS Message;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        -- Optionally, log the error or re-throw it
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO
-- update 
-- update the timing of the exam
CREATE PROCEDURE UpdateExamModelDateAndTime
    @examModelId INT,
    @date DATE,
    @startTime TIME,
    @endTime TIME
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages

    BEGIN TRY
        -- Validate input parameters
        IF @examModelId IS NULL OR @date IS NULL OR @startTime IS NULL OR @endTime IS NULL
        BEGIN
        RAISERROR('None of the input parameters can be NULL.', 16, 1);
        RETURN;
    END

        -- Check if the exam model ID exists
        IF NOT EXISTS (SELECT 1
    FROM ExamModel
    WHERE ID = @examModelId)
        BEGIN
        RAISERROR('The Exam Model with ID %d does not exist.', 16, 1, @examModelId);
        RETURN;
    END

        -- Validate that end time is after start time
        IF @endTime <= @startTime
        BEGIN
        RAISERROR('The end time must be after the start time.', 16, 1);
        RETURN;
    END

        BEGIN TRANSACTION; -- Start a transaction

        -- Update the exam model's date, start time, and end time
        UPDATE ExamModel
        SET 
            date = @date,
            startTime = @startTime,
            endTime = @endTime
        WHERE ID = @examModelId;

        COMMIT TRANSACTION; -- Commit the transaction if successful

        -- Return success message
        SELECT 'Exam Model date and time updated successfully.' AS Message;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        -- Optionally, log the error or re-throw it
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END; 

GO
-- Read 
CREATE PROCEDURE GetExamModel
    @ExamModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ExamModel
    WHERE ID = @ExamModelID;
END;
GO