--------------------------------------------------------------------------------------
---------------------------------- Question Bank Choice ------------------------------
--------------------------------------------------------------------------------------


-- Get Choice
CREATE PROC getQuestionBankChoice
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
        WHERE questionID = @questionID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while retrieving choices for the question.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO


-- Update Choice
CREATE PROC updateQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
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
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while updating the choice.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO


-- Delete Choice
CREATE PROC deleteQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
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

        -- Check if the choice exists
        IF NOT EXISTS (SELECT 1 FROM QuestionBank_Choice WHERE questionID = @questionID AND Choice = @choice)
        BEGIN
            PRINT 'Choice does not exist for the specified question.';
            RETURN;
        END;

        -- Delete the choice
        DELETE FROM QuestionBank_Choice
        WHERE questionID = @questionID
          AND Choice = @choice;

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
CREATE PROC insertQuestionBankChoice
    @questionID INT,
    @choice NVARCHAR(200)
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

        -- Check if the choice already exists for the question
        IF EXISTS (SELECT 1 FROM QuestionBank_Choice WHERE questionID = @questionID AND Choice = @choice)
        BEGIN
            PRINT 'Choice already exists for the specified question.';
            RETURN;
        END;

        -- Insert the choice
        INSERT INTO QuestionBank_Choice
            (questionID, Choice)
        VALUES
            (@questionID, @choice);

        PRINT 'Choice inserted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred while inserting the choice.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END
GO