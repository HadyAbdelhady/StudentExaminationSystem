SELECT *
FROM ExamModel_Question

-----------------------------------------------------
----------------- ExamModel_Question ----------------
-----------------------------------------------------
GO
-- create
CREATE PROCEDURE InsertIntoExamModel_Question
    @examModelId INT,
    @questionId INT
AS
BEGIN
    SET NOCOUNT ON;
    -- To show the number of the affected rows

    -- Validate input parameters
    IF @examModelId IS NULL OR @questionId IS NULL
    BEGIN
        RAISERROR('Exam Model ID and Question ID cannot be NULL.', 16, 1);
        RETURN;
    END

    -- Check if the question exists in the QuestionBank table
    IF NOT EXISTS (SELECT 1
    FROM QuestionBank
    WHERE ID = @questionId)
    BEGIN
        RAISERROR('The specified Question ID does not exist in the QuestionBank.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION; -- Start a transaction

        -- Retrieve the correct choice for the question
        DECLARE @Correct_Choice NVARCHAR(200);
        SELECT @Correct_Choice = correctChoice
    FROM QuestionBank
    WHERE ID = @questionId;

        -- Insert into ExamModel_Question table
        INSERT INTO ExamModel_Question
        (examModelID, questionID, correctChoice)
    VALUES
        (@examModelId, @questionId, @Correct_Choice);

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
CREATE PROCEDURE DeleteQuestionsOfExamModel
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Suppress "rows affected" messages

    BEGIN TRY
        -- Delete questions associated with the exam model
        DELETE FROM ExamModel_Question
        WHERE examModelID = @examModelID;

        -- Check if any rows were deleted
        IF @@ROWCOUNT > 0
        BEGIN
        -- Return a success message with the number of questions deleted
        SELECT CAST(@@ROWCOUNT AS NVARCHAR) + ' question(s) have been deleted for this Exam Model.' AS Message;
    END
        ELSE
        BEGIN
        -- Return a message if no questions were found for the exam model
        SELECT 'No questions found for this Exam Model'+ '. The exam model or its questions may already be deleted.' AS Message;
    END
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
CREATE PROCEDURE GetTotalMarkOfExamModel
    @examModelID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the exam model ID exists in the ExamModel_Question table
        IF NOT EXISTS (SELECT 1
    FROM ExamModel_Question
    WHERE examModelID = @examModelID)
        BEGIN
        RAISERROR('The provided Exam Model ID does not exist or has no questions.', 16, 1);
        RETURN;
    END

        -- Calculate the total marks for the exam model
        SELECT SUM(mark) AS TotalMarks
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

CREATE PROCEDURE UpdateExamModelQuestion
    @examModelID INT,
    @questionID INT,
    @mark INT,
    @correctChoice NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
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
    END

        -- Update the record
        UPDATE ExamModel_Question
        SET 
            mark = @mark,
            correctChoice = @correctChoice
        WHERE 
            examModelID = @examModelID
        AND questionID = @questionID;

        -- Return success message
        SELECT 'Exam model question updated successfully.' AS Message;
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

CREATE PROCEDURE GetExamModelQuestions
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

        -- Retrieve all questions for the given exam model ID
        SELECT
        eq.questionID,
        q.questionText,
        eq.mark,
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