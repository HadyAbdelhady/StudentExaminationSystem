--------------------------------------------------------------------------------------
---------------------------------- Question Bank Choice ------------------------------
--------------------------------------------------------------------------------------


-- Get Choice
CREATE OR ALTER PROC getQuestionBankChoice
    @questionID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        -- Check if the question exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID)
        BEGIN
            PRINT 'Question with ID ' + CAST(@questionID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Retrieve choices for the question
        SELECT * FROM QuestionBank_Choice
        WHERE questionID = @questionID
            AND isDeleted = 0;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving choices for the question.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO



-- Update Choice
CREATE OR ALTER PROC updateQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
            BEGIN TRY
                BEGIN TRANSACTION
                IF EXISTS (
            SELECT 1 
            FROM StudentSubmit_Answer ssa
            INNER JOIN ExamModel_Question emq 
                ON ssa.questionID = emq.questionID
            WHERE emq.questionID = @questionID
        )
        BEGIN
            RAISERROR('Cannot update choices - question is used in submitted exams', 16, 1);
            RETURN;
        END;

        -- Check if the question exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID)
        BEGIN
            PRINT 'Question with ID ' + CAST(@questionID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Check if the choice exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank_Choice WHERE questionID = @questionID AND Choice = @choice)
        BEGIN
            PRINT 'Choice does not exist for the specified question.';
            RETURN;
        END;

        -- Update the choice
        UPDATE QuestionBank_Choice
        SET Choice = @choice
        WHERE questionID = @questionID;

        PRINT 'Choice updated successfully.';
        COMMIT
    END TRY
    BEGIN CATCH
        -- Handle errors
        IF @@ROWCOUNT > 0
            ROLLBACK;
        PRINT 'An error occurred while updating the choice.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO


-- Delete Choice
CREATE OR ALTER PROC deleteQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
            BEGIN TRY
            IF EXISTS (
            SELECT 1 
            FROM StudentSubmit_Answer ssa
            INNER JOIN ExamModel_Question emq 
                ON ssa.questionID = emq.questionID
            WHERE emq.questionID = @questionID
        )
        BEGIN
            RAISERROR('Cannot delete choices - question is used in submitted exams', 16, 1);
            RETURN;
        END;
        
        -- Check if the question exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID AND isDeleted = 0)
        BEGIN
            PRINT 'Question with ID ' + CAST(@questionID AS NVARCHAR) + ' does not exist.';
            RETURN;
        END;

        -- Check if the choice exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank_Choice WHERE questionID = @questionID AND Choice = @choice)
        BEGIN
            PRINT 'Choice does not exist for the specified question.';
            RETURN;
        END;

        -- Delete the choice
        DELETE FROM QuestionBank_Choice
        WHERE questionID = @questionID AND Choice = @choice;

        PRINT 'Choice deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while deleting the choice.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO



-- Insert Choice
CREATE OR ALTER PROC insertQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
AS
        BEGIN
            BEGIN TRY
                BEGIN TRANSACTION;
                IF EXISTS (
            SELECT 1 
            FROM StudentSubmit_Answer ssa
            INNER JOIN ExamModel_Question emq 
                ON ssa.questionID = emq.questionID
            WHERE emq.questionID = @questionID
        )
        BEGIN
            RAISERROR('Cannot add choices - question is used in submitted exams', 16, 1);
            RETURN;
        END

        -- Check if the question exists and get its type
        DECLARE @questionType NVARCHAR(50);
        DECLARE @currentChoiceCount INT;

        SELECT @questionType = Type 
        FROM QuestionBank 
        WHERE ID = @questionID AND isDeleted = 0;

        IF @questionType IS NULL
        BEGIN
            RAISERROR('Question with ID %d does not exist or is deleted.', 16, 1, @questionID);
            RETURN;
        END;

        -- Get current active choices count
        SELECT @currentChoiceCount = COUNT(*) 
        FROM QuestionBank_Choice 
        WHERE questionID = @questionID AND isDeleted = 0;

        -- Validate choice limits based on question type
        IF @questionType = 'MultipleChoice' AND @currentChoiceCount >= 4
        BEGIN
            RAISERROR('MultipleChoice questions cannot have more than 4 choices.', 16, 1);
            RETURN;
        END;

        IF @questionType = 'TrueOrFalse' AND @currentChoiceCount >= 2
        BEGIN
            RAISERROR('True/False questions cannot have more than 2 choices.', 16, 1);
            RETURN;
        END;

        -- Check for duplicate choice
        IF EXISTS (
            SELECT 1 
            FROM QuestionBank_Choice 
            WHERE questionID = @questionID 
                AND Choice = @choice
                AND isDeleted = 0
        )
        BEGIN
            RAISERROR('Choice already exists for this question.', 16, 1);
            RETURN;
        END;

        -- Insert the choice
        INSERT INTO QuestionBank_Choice (questionID, Choice)
        VALUES (@questionID, @choice);

        COMMIT TRANSACTION;
        PRINT 'Choice added successfully.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH;
END
GO