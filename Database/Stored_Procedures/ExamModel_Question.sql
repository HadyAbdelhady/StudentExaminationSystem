-----------------------------------------------------
----------------- ExamModel_Question ----------------
-----------------------------------------------------
GO
-- create
CREATE OR ALTER PROCEDURE InsertIntoExamModel_Question
    @examModelID INT,
    @questionId INT,
    @mark INT
AS
BEGIN
    -- To show the number of the affected rows
    SET NOCOUNT ON;
    
    BEGIN TRY
        IF (@mark < 1)
        BEGIN
            RAISERROR('mark can not be less than 1 ',5,6 );
            RETURN;
        END;

    -- Validate input parameters
    IF @examModelID IS NULL OR @questionId IS NULL OR @mark IS NULL
    BEGIN
        RAISERROR('Exam Model ID, Question ID and mark can not be NULL.', 16, 1);
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
        
        -- Check if there is someone who has submitted the exam 
        IF EXISTS (SELECT 1 FROM StudentSubmit WHERE examModelID = @examModelID )
            BEGIN
                RAISERROR('You can not edit this exam because it has been answered by at least one student', 16, 1);
                RETURN;
            END;

        -- Check if the question exists in the QuestionBank table
        IF NOT EXISTS (SELECT 1
        FROM QuestionBank
        WHERE ID = @questionId AND isDeleted = 0)
        BEGIN
            RAISERROR('The specified Question ID does not exist in the QuestionBank.', 16, 1);
            RETURN;
        END

        BEGIN TRANSACTION; -- Start a transaction
        -- Retrieve the correct choice for the question
        DECLARE @Correct_Choice NVARCHAR(200);
        SELECT @Correct_Choice = correctChoice
        FROM QuestionBank
        WHERE ID = @questionId;

        -- Insert into ExamModel_Question table
        INSERT INTO ExamModel_Question
        (examModelID, questionID, correctChoice, mark)
    VALUES
        (@examModelId, @questionId, @Correct_Choice, @mark);

        COMMIT TRANSACTION; -- Commit the transaction if successful
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

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO

-- Delete
CREATE OR ALTER PROCEDURE DeleteQuestionFromExamModel
    @examModelID INT,
    @questionID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages

    BEGIN TRY
        IF @examModelID IS NULL OR @questionID is NULL
            BEGIN
                RAISERROR('Parameters can not be null', 16, 1);
            END;
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
        
        -- Check if there is someone who has submitted the exam 
        IF EXISTS (SELECT 1 FROM StudentSubmit WHERE examModelID = @examModelID )
            BEGIN
                RAISERROR('You can not edit this exam because it has been answered by at least one student', 16, 1);
                RETURN;
            END;

        -- check if the question already exists in the exam model
        IF NOT EXISTS (SELECT 1 FROM ExamModel_Question WHERE examModelID = @examModelID and questionID = @questionID)
            BEGIN
                RAISERROR('The Question ID you entered is invalid or this question doesnot exist in this exam', 16, 1);
            END;
        -- Delete questions associated with the exam model
        DELETE FROM ExamModel_Question
        WHERE examModelID = @examModelID
        AND questionID = @questionID;

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

-- Read 
CREATE OR ALTER PROCEDURE GetTotalMarkOfExamModel
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the exam model ID exists in the ExamModel_Question table
        IF NOT EXISTS (SELECT 1
    FROM ExamModel_Question
    WHERE examModelID = @examModelID) -- No check for isDeleted It is a generic helper procedure
        BEGIN
        RAISERROR('The provided Exam Model ID does not exist or has no questions.', 16, 1);
        RETURN;
    END

        -- Calculate the total marks for the exam model
        SELECT ISNULL(SUM(mark), 0) AS TotalMarks
    FROM ExamModel_Question
    WHERE examModelID = @examModelID;
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

CREATE OR ALTER PROCEDURE UpdateMarkOfExamModelQuestion
    @examModelID INT,
    @questionID INT,
    @mark INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Validate input parameters
        IF @ExamModelID IS NULL OR @questionId IS NULL OR @mark IS NULL
        BEGIN
            RAISERROR('Exam Model ID, Question ID and mark can not be NULL.', 16, 1);
            RETURN;
        END

        -- Check if the record exists
        IF NOT EXISTS (
                SELECT 1
                FROM ExamModel_Question
                WHERE examModelID = @examModelID
                AND questionID = @questionID
            )
        BEGIN
            RAISERROR('The specified exam model ID and question ID combination does not exist.', 16, 1);
            RETURN;
        END;


    IF @mark < 1
        BEGIN
            RAISERROR('mark can not be less than 1', 16, 1 );
            RETURN;
        END;

        -- Update the record
        UPDATE ExamModel_Question
        SET 
            mark = @mark
        WHERE 
            examModelID = @examModelID
        AND questionID = @questionID;

        -- Return success message
        SELECT 'The question mark has been updated successfully.' AS Message;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO

CREATE OR ALTER PROCEDURE GetExamModelAnswers 
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the exam model ID exists
        IF NOT EXISTS (
            SELECT 1
    FROM ExamModel
    WHERE ID = @examModelID
        )
        BEGIN
        RAISERROR('The specified exam model ID does not exist.', 16, 1);
        RETURN;
    END

        -- Retrieve all questions with its answer for the given exam model ID with answers
        SELECT
        eq.questionID,
        q.questionText,
        eq.correctChoice
    FROM
        ExamModel_Question eq
        INNER JOIN
        QuestionBank q ON eq.questionID = q.ID
    WHERE 
            eq.examModelID = @examModelID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO