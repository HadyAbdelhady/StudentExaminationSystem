/****************************QuestionBank Table**********************************/
GO
--create
CREATE PROCEDURE InsertQuestion
    @Type NVARCHAR(50),
    @CorrectChoice NVARCHAR(100),
    @InstructorID INT,
    @CourseID INT,
    @QuestionText NVARCHAR(1000),
    @QuestionID INT OUTPUT
AS
BEGIN
    -- Insert the new question
    INSERT INTO QuestionBank
        (Type, CorrectChoice, InstructorID, CourseID, LastEditDate, QuestionText)
    VALUES
        (@Type, @CorrectChoice, @InstructorID, @CourseID, GETDATE(), @QuestionText);

    -- Get the ID of the inserted question
    SET @QuestionID = SCOPE_IDENTITY();
END;

GO

--Read
CREATE PROCEDURE SelectQuestion
    @ID INT
AS
BEGIN
    SELECT *
    FROM QuestionBank
    WHERE ID = @ID
END

GO
--Update
CREATE PROCEDURE UpdateQuestion
    @ID INT,
    @Type NVARCHAR(50),
    @CorrectChoice NVARCHAR(200),
    @InstructorID INT,
    @CourseID INT,
    @QuestionText NVARCHAR(1000)
AS
BEGIN
    UPDATE QuestionBank SET Type = @Type, CorrectChoice = @CorrectChoice, InstructorID = @InstructorID, 
	CourseID = @CourseID, LastEditDate = GETDATE(), QuestionText = @QuestionText 
	WHERE ID = @ID
END

GO
--Delete
CREATE PROCEDURE DeleteQuestion
    @ID INT
AS
BEGIN
    DELETE FROM QuestionBank 
	WHERE ID = @ID
END

GO

--get all questions for specific course
CREATE PROCEDURE GetQuestionsByCourse
    @CourseID INT
AS
BEGIN
    SELECT *
    FROM QuestionBank
    WHERE CourseID = @CourseID;
END

GO

--Generate random questions with specific numbers of true or false and MCQ Questions using courseID
CREATE PROCEDURE GetRandomQuestions
    @CourseID INT,
    @NumOfTrueOrFalse INT = NULL,
    @NumOfMultiple INT = NULL
AS
BEGIN
    BEGIN TRY
        -- Temporary table to hold selected questions
        CREATE TABLE #Questions
    (
        QuestionID INT,
        QuestionText VARCHAR(1000),
        QuestionType VARCHAR(50)
    );

        -- Handle True/False questions
        IF @NumOfTrueOrFalse IS NOT NULL
        BEGIN
        DECLARE @AvailableTrueOrFalse INT;
        SELECT @AvailableTrueOrFalse = COUNT(*)
        FROM QuestionBank
        WHERE CourseID = @CourseID AND Type = 'TrueOrFalse';

        IF @NumOfTrueOrFalse > @AvailableTrueOrFalse
            BEGIN
            RAISERROR('The number of requested True/False questions exceeds the available questions. Available: %d', 16, 1, @AvailableTrueOrFalse);
            RETURN;
        END

        INSERT INTO #Questions
            (QuestionID, QuestionText, QuestionType)
        SELECT TOP (@NumOfTrueOrFalse)
            ID, QuestionText, Type
        FROM QuestionBank
        WHERE CourseID = @CourseID AND Type = 'TrueOrFalse'
        ORDER BY NEWID();
    END

        -- Handle Multiple Choice questions
        IF @NumOfMultiple IS NOT NULL
        BEGIN
        DECLARE @AvailableMultiple INT;
        SELECT @AvailableMultiple = COUNT(*)
        FROM QuestionBank
        WHERE CourseID = @CourseID AND Type = 'MultipleChoice';

        IF @NumOfMultiple > @AvailableMultiple
            BEGIN
            RAISERROR('The number of requested Multiple Choice questions exceeds the available questions. Available: %d', 16, 1, @AvailableMultiple);
            RETURN;
        END

        INSERT INTO #Questions
            (QuestionID, QuestionText, QuestionType)
        SELECT TOP (@NumOfMultiple)
            ID, QuestionText, Type
        FROM QuestionBank
        WHERE CourseID = @CourseID AND Type = 'MultipleChoice'
        ORDER BY NEWID();
    END

        -- Return the selected questions
        SELECT QuestionID, QuestionText, QuestionType
    FROM #Questions;

        -- Drop the temporary table
        DROP TABLE #Questions;

    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO
-- Procedure to Get Questions by Topic with Random Selection for Specific Types
CREATE PROCEDURE GetRandomQuestionsByTopic
    @CourseID INT,
    @Topic NVARCHAR(50) = NULL,
    @NumOfTrueOrFalse INT = NULL,
    @NumOfMultiple INT = NULL
AS
BEGIN
    BEGIN TRY
        -- Temporary table to store results
        CREATE TABLE #SelectedQuestions
    (
        QuestionID INT,
        QuestionText NVARCHAR(1000),
        QuestionType NVARCHAR(50)
    );

        -- Handle True/False questions
        IF @NumOfTrueOrFalse IS NOT NULL
        BEGIN
        DECLARE @AvailableTrueOrFalse INT;
        SELECT @AvailableTrueOrFalse = COUNT(*)
        FROM QuestionBank QB
            JOIN Course_Topic CT ON QB.CourseID = CT.CourseID
        WHERE QB.CourseID = @CourseID
            AND QB.Type = 'TrueOrFalse'
            AND (CT.Topic = @Topic OR @Topic IS NULL);

        IF @AvailableTrueOrFalse < @NumOfTrueOrFalse
            BEGIN
            RAISERROR('Not enough True/False questions available for the specified topic. Only %d questions exist.', 16, 1, @AvailableTrueOrFalse);
            RETURN;
        END

        INSERT INTO #SelectedQuestions
            (QuestionID, QuestionText, QuestionType)
        SELECT TOP (@NumOfTrueOrFalse)
            QB.ID, QB.QuestionText, QB.Type
        FROM QuestionBank QB
            JOIN Course_Topic CT ON QB.CourseID = CT.CourseID
        WHERE QB.CourseID = @CourseID
            AND QB.Type = 'TrueOrFalse'
            AND (CT.Topic = @Topic OR @Topic IS NULL)
        ORDER BY NEWID();
    END

        -- Handle Multiple Choice questions
        IF @NumOfMultiple IS NOT NULL
        BEGIN
        DECLARE @AvailableMultiple INT;
        SELECT @AvailableMultiple = COUNT(*)
        FROM QuestionBank QB
            JOIN Course_Topic CT ON QB.CourseID = CT.CourseID
        WHERE QB.CourseID = @CourseID
            AND QB.Type = 'MultipleChoice'
            AND (CT.Topic = @Topic OR @Topic IS NULL);

        IF @AvailableMultiple < @NumOfMultiple
            BEGIN
            RAISERROR('Not enough Multiple Choice questions available for the specified topic. Only %d questions exist.', 16, 1, @AvailableMultiple);
            RETURN;
        END

        INSERT INTO #SelectedQuestions
            (QuestionID, QuestionText, QuestionType)
        SELECT TOP (@NumOfMultiple)
            QB.ID, QB.QuestionText, QB.Type
        FROM QuestionBank QB
            JOIN Course_Topic CT ON QB.CourseID = CT.CourseID
        WHERE QB.CourseID = @CourseID
            AND QB.Type = 'MultipleChoice'
            AND (CT.Topic = @Topic OR @Topic IS NULL)
        ORDER BY NEWID();
    END

        -- Return the selected questions
        SELECT *
    FROM #SelectedQuestions;

        -- Drop the temporary table
        DROP TABLE #SelectedQuestions;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


