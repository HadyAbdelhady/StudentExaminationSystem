-----------------------------------------------------
--------------------- ExamModel ---------------------
-----------------------------------------------------
CREATE OR ALTER PROCEDURE InsertExamModel
    @date DATE,
    @startTime TIME,
    @endTime TIME,
    @CourseID INT,
    @instructorID INT,
    @examModelID INT OUTPUT
-- New output parameter to return the identity value
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the instructor ID is valid
        IF NOT EXISTS (SELECT 1
    FROM Instructor
    WHERE ID = @instructorID AND isDeleted = 0)
        BEGIN
        RAISERROR('The Instructor ID does not exist. Maybe it has been deleted or invalid.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM ExamModel
        WHERE CourseID = @CourseID
            AND instructorID = @instructorID
            AND date = @date
            AND (
                    (startTime <= @endTime AND endTime >= @startTime)
                )
            AND isDeleted = 0
    )
    BEGIN
        RAISERROR('An overlapping exam exists for the same course and instructor.', 16, 1);
        RETURN;
    END;

        -- Check if the course ID is valid
        IF NOT EXISTS (SELECT 1
    FROM Course
    WHERE ID = @CourseID And isDeleted = 0)
        BEGIN
        RAISERROR('The Course ID does not exist. Maybe it has been deleted or invalid.', 16, 1);
        RETURN;
    END

        -- Check if the end time is after the start time
        IF @endTime <= @startTime
        BEGIN
        RAISERROR('The end time must be after the start time.', 16, 1);
        RETURN;
    END;

        -- Check if date is valid
        IF @date < CAST(GETDATE() AS DATE)
        BEGIN
        RAISERROR('The date entered must be today or a future date.', 16, 1);
        RETURN;
    END;

        -- Insert into ExamModel table
        INSERT INTO ExamModel
        (date, startTime, endTime, CourseID, instructorID)
    VALUES
        (@date, @startTime, @endTime, @CourseID, @instructorID);

        -- Set the output parameter to the last inserted identity value
        SET @examModelID = SCOPE_IDENTITY();

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

CREATE OR ALTER PROCEDURE DeleteExamModel
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages

    BEGIN TRY
    BEGIN TRANSACTION; -- Start a transaction
        -- Check if the exam model ID exists
    IF NOT EXISTS (SELECT 1
        FROM ExamModel
        WHERE ID = @examModelID AND isDeleted = 0)
    BEGIN
        RAISERROR('The Exam Model with ID %d does not exist or may be it is already deleted.', 16, 1, @examModelID);
        RETURN;
    END

    -- check if the exam time has come so you can't edit it
        DECLARE @startTime TIME; 
        DECLARE @endTime TIME; 
        DECLARE @date DATE; 
    
        SELECT @startTime = startTime, @endTime = endTime , @date = date FROM ExamModel Where ID = @examModelID;
    
        IF CONVERT(TIME, GETDATE()) > @startTime AND CONVERT(TIME, GETDATE()) < @endTime AND GETDATE() = @date 
            BEGIN
                RAISERROR('You can not edit this exam because is available to students right now!', 16, 1);
                RETURN;
            END;
    

    IF EXISTS (SELECT 1 FROM StudentSubmit WHERE examModelID = @examModelID)
    BEGIN
        RAISERROR('You can not delete this exam because it has been answered by at least one student', 16, 1, @examModelID);
    RETURN;

        -- Soft Delete the exam model questions first
        Delete FROM ExamModel_Question
        WHERE examModelID = @examModelID;

        -- Soft Delete the exam model
        Update ExamModel
        SET isDeleted = 1
        WHERE ID = @examModelID;

        -- Student Submitions won't be affected on purpose
        COMMIT TRANSACTION; -- Commit the transaction if successful
        -- Return success message
        SELECT 'Exam Model and its questions were deleted successfully.' AS Message;
    END
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
CREATE OR ALTER PROCEDURE UpdateExamModelDateAndTime
    @examModelId INT,
    @date DATE,
    @startTime TIME,
    @endTime TIME
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages
    BEGIN TRY
        -- check for avilability for change
        IF CONVERT(TIME, GETDATE()) > @startTime AND CONVERT(TIME, GETDATE()) < @endTime AND GETDATE() = @date 
            BEGIN
                RAISERROR('You cannot edit this exam because is available to students right now!', 16, 1);
                RETURN;
            END;
        -- Validate input parameters
        IF @examModelId IS NULL OR @date IS NULL OR @startTime IS NULL OR @endTime IS NULL
        BEGIN
            RAISERROR('None of the input parameters can be NULL.', 16, 1);
            RETURN;
        END;

    BEGIN
        RAISERROR('An overlapping exam exists for the same course and instructor.', 16, 1);
        RETURN;
    END;

        IF @date < CAST(GETDATE() AS DATE)
        BEGIN
            RAISERROR('The date entered must be today or a future date.', 16, 1);
            RETURN;
        END;


        -- Check if the exam model ID exists
        IF NOT EXISTS (SELECT 1
    FROM ExamModel
    WHERE ID = @examModelId AND isDeleted = 0)
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
CREATE OR ALTER PROCEDURE GetExamModel
    @ExamModelID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @ExamModelID IS NULL
    BEGIN
        RAISERROR('The ExamModelID cannot be NULL.', 16, 1);
        RETURN;
    END;

    SELECT EM.ID,EM.date, EM.startTime, EM.endTime, EM.CreationDate ,EM.CourseID, EM.instructorID, C.Name AS CourseName , Inst.firstName, Inst.lastName
    FROM ExamModel EM
    INNER JOIN Instructor Inst ON EM.instructorID = Inst.ID
    INNER JOIN Course C ON C.ID = EM.CourseID
    WHERE EM.ID = @ExamModelID AND EM.isDeleted = 0;
END;
GO

CREATE OR ALTER PROCEDURE GetAllExamModels
AS 
BEGIN
    SELECT EM.ID,EM.date, EM.startTime, EM.endTime, EM.CreationDate ,EM.CourseID, EM.instructorID, C.Name AS CourseName , Inst.firstName, Inst.lastName
    FROM ExamModel EM
    INNER JOIN Instructor Inst ON EM.instructorID = Inst.ID
    INNER JOIN Course C ON C.ID = EM.CourseID
    WHERE EM.isDeleted = 0;
END
EXEC GetAllExamModels;
GO


go
CREATE OR ALTER PROCEDURE GetExamModelQuestionsWithOptionsWithAnswer
    @ExamModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Common Table Expression (CTE) to retrieve questions and their options
    WITH QuestionOptions AS
    (
        SELECT 
            EMQ.examModelID,
            QB.ID AS QuestionID,
            QB.questionText AS QuestionText,
            QB.type AS QuestionType,
            QB.correctChoice AS ModelAnswer,
            QC.Choice AS OptionChoice,
            ROW_NUMBER() OVER (PARTITION BY QB.ID ORDER BY QC.Choice) AS ChoiceNumber
        FROM 
            ExamModel_Question EMQ
        INNER JOIN 
            QuestionBank QB ON EMQ.questionID = QB.ID
        LEFT JOIN 
            QuestionBank_Choice QC ON QB.ID = QC.questionID
        WHERE 
            EMQ.examModelID = @ExamModelID
    )

    -- Pivot the options for each question
    SELECT 
        QuestionText,
        QuestionID,
        MAX(CASE WHEN ChoiceNumber = 1 THEN OptionChoice END) AS OptionOne,
        MAX(CASE WHEN ChoiceNumber = 2 THEN OptionChoice END) AS OptionTwo,
        MAX(CASE WHEN ChoiceNumber = 3 THEN OptionChoice END) AS OptionThree,
        MAX(CASE WHEN ChoiceNumber = 4 THEN OptionChoice END) AS OptionFour,
        ModelAnswer
    FROM 
        QuestionOptions
    GROUP BY 
        QuestionText, ModelAnswer, QuestionID
    ORDER BY 
        QuestionText;
END;
GO

CREATE OR ALTER PROCEDURE GetExamModelQuestionsWithOptionsWithoutAnswer
    @ExamModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Common Table Expression (CTE) to retrieve questions and their options
    WITH QuestionOptions AS
    (
        SELECT 
            EMQ.examModelID,
            QB.ID AS QuestionID,
            QB.questionText AS QuestionText,
            QB.type AS QuestionType,
            QC.Choice AS OptionChoice,
            ROW_NUMBER() OVER (PARTITION BY QB.ID ORDER BY QC.Choice) AS ChoiceNumber
        FROM 
            ExamModel_Question EMQ
        INNER JOIN 
            QuestionBank QB ON EMQ.questionID = QB.ID
        LEFT JOIN 
            QuestionBank_Choice QC ON QB.ID = QC.questionID
        WHERE 
            EMQ.examModelID = @ExamModelID
    )

    -- Pivot the options for each question
    SELECT 
        QuestionText,
        QuestionID,
        MAX(CASE WHEN ChoiceNumber = 1 THEN OptionChoice END) AS OptionOne,
        MAX(CASE WHEN ChoiceNumber = 2 THEN OptionChoice END) AS OptionTwo,
        MAX(CASE WHEN ChoiceNumber = 3 THEN OptionChoice END) AS OptionThree,
        MAX(CASE WHEN ChoiceNumber = 4 THEN OptionChoice END) AS OptionFour
    FROM 
        QuestionOptions
    GROUP BY 
        QuestionText, QuestionID
    ORDER BY 
        QuestionText;
END;