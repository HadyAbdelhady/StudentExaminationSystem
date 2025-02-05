/****************************QuestionBank Table**********************************/
GO
--create
CREATE OR ALTER PROCEDURE InsertQuestion
    @Type NVARCHAR(50),
    @CorrectChoice NVARCHAR(100),
    @InstructorID INT,
    @CourseID INT,
    @QuestionText NVARCHAR(1000),
    @QuestionID INT OUTPUT
AS
BEGIN
    -- Check for validation of the Instructor ID and the CourseID
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE isDeleted = 0)
            BEGIN
                RAISERROR('Invalid instructor ID ... may be it has been delted', 16, 1)
                RETURN;
            END;

        IF NOT EXISTS (SELECT 1 FROM Course WHERE isDeleted = 0)
            BEGIN
                RAISERROR('Invalid Course ID ... may be it has been delted', 16, 1)
                RETURN;
            END;
    -- Insert the new question
    INSERT INTO QuestionBank
        (Type, CorrectChoice, InstructorID, CourseID, insertionDate, QuestionText)
    VALUES
        (@Type, @CorrectChoice, @InstructorID, @CourseID, GETDATE(), @QuestionText);

    -- Get the ID of the inserted question
    SET @QuestionID = SCOPE_IDENTITY();
END;
GO

--Read ---------------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SelectQuestion
    @ID INT
AS
BEGIN
    SELECT *
    FROM QuestionBank
    WHERE ID = @ID AND isDeleted = 0;
END;
GO

--Update
CREATE OR ALTER PROCEDURE UpdateQuestion
    @ID INT,
    @Type NVARCHAR(50),
    @CorrectChoice NVARCHAR(200),
    @InstructorID INT,
    @CourseID INT,
    @QuestionText NVARCHAR(1000)
AS
BEGIN
    -- Check if the question exists and is not deleted
    IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @ID AND isDeleted = 0)
    BEGIN
        RAISERROR('Question does not exist or is deleted.', 16, 1);
        RETURN;
    END;

    -- Check for validation of the Instructor ID and the CourseID
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE isDeleted = 0)
            BEGIN
                RAISERROR('Invalid instructor ID ... may be it has been delted', 16, 1)
                RETURN;
            END;

        IF NOT EXISTS (SELECT 1 FROM Course WHERE isDeleted = 0)
            BEGIN
                RAISERROR('Invalid Course ID ... may be it has been delted', 16, 1)
                RETURN;
            END;
    -- Update the question
    UPDATE QuestionBank 
    SET Type = @Type, 
        CorrectChoice = @CorrectChoice, 
        InstructorID = @InstructorID, 
        CourseID = @CourseID, 
        insertionDate = GETDATE(), 
        QuestionText = @QuestionText 
    WHERE ID = @ID AND isDeleted = 0;
END;
GO

--Delete
CREATE OR ALTER PROCEDURE DeleteQuestion
    @questionID INT
AS
BEGIN
    -- Check if the question exists and is not already deleted
    IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID AND isDeleted = 0)
    BEGIN
        RAISERROR('Question does not exist or is already deleted.', 16, 1);
        RETURN;
    END;

    -- Mark the question as deleted
    UPDATE QuestionBank
    SET isDeleted = 1
    WHERE ID = @questionID;
END;
GO

--get all questions for specific course
CREATE OR ALTER PROCEDURE GetQuestionsByCourse
    @CourseID INT
AS
BEGIN

    SELECT *
    FROM QuestionBank
    WHERE CourseID = @CourseID AND isDeleted = 0;
END;
GO

CREATE OR ALTER PROCEDURE GenerateRandomExamModel
    @CourseID INT,
    @InstructorID INT,
    @StartTime TIME,
    @EndTime TIME,
    @Date DATE,
    @markForEachQuestion INT = 1,
    @NumOfTrueOrFalse INT = NULL,
    @NumOfMultiple INT = NULL,
    @ExamModelID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate at least one question type is requested
        IF COALESCE(@NumOfTrueOrFalse, 0) + COALESCE(@NumOfMultiple, 0) = 0
        BEGIN
            RAISERROR('Must specify at least one question type count (True/False or Multiple Choice)', 16, 1);
            RETURN;
        END;

        -- Create exam model
        INSERT INTO ExamModel (CourseID, InstructorID, StartTime, EndTime, Date, CreationDate)
        VALUES (@CourseID, @InstructorID, @StartTime, @EndTime, @Date, GETDATE());
        SET @ExamModelID = SCOPE_IDENTITY();

        -- Table for selected questions
        DECLARE @SelectedQuestions TABLE (
            QuestionID INT PRIMARY KEY,
            CorrectChoice NVARCHAR(200),
            QuestionType NVARCHAR(50)
        );

        -- True/False questions handling
        IF @NumOfTrueOrFalse > 0
        BEGIN
            INSERT INTO @SelectedQuestions (QuestionID, CorrectChoice, QuestionType)
            SELECT TOP (@NumOfTrueOrFalse) 
                ID, 
                CorrectChoice, 
                Type
            FROM QuestionBank
            WHERE CourseID = @CourseID
                AND Type = 'TrueOrFalse'
                AND isDeleted = 0
            ORDER BY NEWID();

            -- Validate sufficient questions
            IF @@ROWCOUNT < @NumOfTrueOrFalse
            BEGIN
                DECLARE @tfAvailable INT = (
                    SELECT COUNT(*) 
                    FROM QuestionBank 
                    WHERE CourseID = @CourseID
                        AND Type = 'TrueOrFalse'
                        AND isDeleted = 0
                );
                ROLLBACK TRANSACTION;
                RAISERROR('Requested %d True/False questions, but only %d available.', 16, 1, @NumOfTrueOrFalse, @tfAvailable);
                RETURN;
            END;
        END;

        -- Multiple Choice questions handling
        IF @NumOfMultiple > 0
        BEGIN
            INSERT INTO @SelectedQuestions (QuestionID, CorrectChoice, QuestionType)
            SELECT TOP (@NumOfMultiple) 
                ID, 
                CorrectChoice, 
                Type
            FROM QuestionBank
            WHERE CourseID = @CourseID
                AND Type = 'MultipleChoice'
                AND isDeleted = 0
            ORDER BY NEWID();

            -- Validate sufficient questions
            IF @@ROWCOUNT < @NumOfMultiple
            BEGIN
                DECLARE @mcAvailable INT = (
                    SELECT COUNT(*) 
                    FROM QuestionBank 
                    WHERE CourseID = @CourseID
                        AND Type = 'MultipleChoice'
                        AND isDeleted = 0
                );
                ROLLBACK TRANSACTION;
                RAISERROR('Requested %d Multiple Choice questions, but only %d available.', 16, 1, @NumOfMultiple, @mcAvailable);
                RETURN;
            END;
        END;

        -- Insert selected questions into ExamModel_Question
        INSERT INTO ExamModel_Question (ExamModelID, QuestionID, correctChoice, mark)
        SELECT 
            @ExamModelID,
            QuestionID,
            CorrectChoice,
            @markForEachQuestion -- Default mark = 1;
        FROM @SelectedQuestions;

        -- Commit transaction if everything succeeds
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction on any error
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        -- Rethrow the error with full details
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(),
                @ErrorSeverity INT = ERROR_SEVERITY(),
                @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO



-- Procedure to Get Questions by Topic with Random Selection for Specific Types
CREATE OR ALTER PROCEDURE GetRandomQuestionsByTopic
    @CourseID INT,
    @mark INT,
    @Topic NVARCHAR(50),
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
            AND CT.Topic = @Topic
            AND QB.isDeleted = 0;

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
            AND CT.Topic = @Topic
            AND QB.isDeleted = 0
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
            AND CT.Topic = @Topic
            AND QB.isDeleted = 0;

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
            AND QB.isDeleted = 0
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
GO

CREATE OR ALTER PROCEDURE GetQuestionDetailsWithOptions
AS
BEGIN
    SET NOCOUNT ON;

    WITH QuestionOptions AS (
        SELECT 
            QB.ID AS QuestionID,
            QB.QuestionText,
            QB.Type AS QuestionType,
            QB.CorrectChoice AS ModelAnswer,
            QC.Choice,
            ROW_NUMBER() OVER (
                PARTITION BY QB.ID 
                ORDER BY QC.Choice
            ) AS ChoiceNum
        FROM QuestionBank QB
        LEFT JOIN QuestionBank_Choice QC 
            ON QB.ID = QC.QuestionID 
        WHERE QB.isDeleted = 0
    )
    
    SELECT 
        q.QuestionID,
        q.QuestionText,
        MAX(CASE WHEN q.ChoiceNum = 1 THEN q.Choice END) AS OptionOne,
        MAX(CASE WHEN q.ChoiceNum = 2 THEN q.Choice END) AS OptionTwo,
        CASE WHEN q.QuestionType = 'MultipleChoice' 
            THEN MAX(CASE WHEN q.ChoiceNum = 3 THEN q.Choice END) 
            ELSE NULL END AS OptionThree,
        CASE WHEN q.QuestionType = 'MultipleChoice' 
            THEN MAX(CASE WHEN q.ChoiceNum = 4 THEN q.Choice END) 
            ELSE NULL END AS OptionFour,
        q.ModelAnswer
    FROM QuestionOptions q
    GROUP BY q.QuestionID, q.QuestionText, q.ModelAnswer, q.QuestionType
    ORDER BY q.QuestionID;
END;

GO


CREATE OR ALTER PROCEDURE GetQuestionDetailsWithOptionsInCourse
@courseId INT
AS
BEGIN
    SET NOCOUNT ON;

    WITH QuestionOptions AS (
        SELECT 
            QB.ID AS QuestionID,
            QB.QuestionText,
            QB.Type AS QuestionType,
            QB.CorrectChoice AS ModelAnswer,
            QC.Choice,
            ROW_NUMBER() OVER (
                PARTITION BY QB.ID 
                ORDER BY QC.Choice
            ) AS ChoiceNum
        FROM QuestionBank QB
        LEFT JOIN QuestionBank_Choice QC 
            ON QB.ID = QC.QuestionID
        WHERE QB.isDeleted = 0 AND QB.courseID = @courseId
    )
    SELECT 
        q.QuestionID,
        q.QuestionText,
        MAX(CASE WHEN q.ChoiceNum = 1 THEN q.Choice END) AS OptionOne,
        MAX(CASE WHEN q.ChoiceNum = 2 THEN q.Choice END) AS OptionTwo,
        CASE WHEN q.QuestionType = 'Multiple Choice' 
            THEN MAX(CASE WHEN q.ChoiceNum = 3 THEN q.Choice END) 
            ELSE NULL END AS OptionThree,
        CASE WHEN q.QuestionType = 'Multiple Choice' 
            THEN MAX(CASE WHEN q.ChoiceNum = 4 THEN q.Choice END) 
            ELSE NULL END AS OptionFour,
        q.ModelAnswer
    FROM QuestionOptions q
    GROUP BY q.QuestionID, q.QuestionText, q.ModelAnswer, q.QuestionType
    ORDER BY q.QuestionID;
END;
EXEC GetQuestionDetailsWithOptionsInCourse @courseId = 1;