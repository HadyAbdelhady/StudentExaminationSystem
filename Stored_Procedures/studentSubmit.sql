
--------------------------------------------------------------------------------------
---------------------------------- Student Submit ------------------------------------
--------------------------------------------------------------------------------------

-- helper procedure to get the grade of the student in a certain exam
CREATE OR ALTER PROC HELPER_calcStudentGrade
    @studentID INT,
    @examModelID INT,
    @calculatedGrade DECIMAL(5,2) OUTPUT
WITH
    ENCRYPTION
AS
BEGIN
    SET @calculatedGrade = 0.0;

    -- Calculate the total grade by summing the marks for correct answers
    -- Filter by studentID and examModelID

    SELECT @calculatedGrade = ISNULL(SUM(EMQ.Mark), 0.0)
    FROM ExamModel_Question EMQ
        JOIN StudentSubmit_Answer SA ON EMQ.questionID = SA.questionID
        JOIN StudentSubmit SS ON SS.ID = SA.StudentSubmitID
    WHERE EMQ.correctChoice = SA.studentAnswer
        AND SS.studentID = @studentID
        AND EMQ.examModelID = @examModelID;
END
GO

-- Insert Submition 
CREATE OR ALTER PROC insertStudentSubmission
    @stdID INT,
    @examMdlID INT,
    @SubmissionID INT OUTPUT -- Define the output parameter
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if there is an existing submission for the student and exam
        DECLARE @existingSubmissionID INT;
        SELECT @existingSubmissionID = ID 
        FROM StudentSubmit 
        WHERE studentID = @stdID AND examModelID = @examMdlID;

        IF @existingSubmissionID IS NOT NULL
        BEGIN
            -- Check if the submission is marked as deleted
            IF EXISTS (
                SELECT 1 
                FROM StudentSubmit 
                WHERE ID = @existingSubmissionID AND isDeleted = 1
            )
            BEGIN
                -- Reactivate the submission
                UPDATE StudentSubmit
                SET isDeleted = 0
                WHERE ID = @existingSubmissionID;

                SET @SubmissionID = @existingSubmissionID; -- Return existing submission ID
            END
            ELSE
            BEGIN
                -- Duplicate active submission, return existing ID
                SET @SubmissionID = @existingSubmissionID; -- Return existing submission ID
            END

                SELECT @SubmissionID
            COMMIT TRANSACTION;
            RETURN; -- Exit after handling duplicate
        END

        -- Insert new submission
        INSERT INTO StudentSubmit (studentID, examModelID, submitDate)
        VALUES (@stdID, @examMdlID, GETDATE());

        -- Get the ID of the newly inserted submission
        SET @SubmissionID = SCOPE_IDENTITY(); -- Assign to the output parameter

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Propagate error details
        THROW;
    END CATCH
END
GO



-- get Submittion

CREATE OR ALTER PROC getStudentSubmitionDetails
	@studentID INT , @examModelID INT
WITH ENCRYPTION 
AS 
    BEGIN
        BEGIN TRY
            IF NOT EXISTS (SELECT 1 FROM STUDENT WHERE ID = @studentID AND isDeleted = 0)
                BEGIN
                    RAISERROR('Student does not esist or it may have been deleted',6,1);
                    RETURN;
                END;

            IF NOT EXISTS (SELECT 1 FROM StudentSubmit WHERE examModelID = @examModelID AND studentID = @studentID AND isDeleted = 0) 
                BEGIN
                    RAISERROR('This Student have not submitted any answers to this exam yet',6,1);
                    RETURN;
                END;

            SELECT SS.examModelID, QB.questionText, SSA.studentAnswer 
            FROM StudentSubmit SS INNER JOIN ExamModel_Question EMQ
                ON SS.examModelID = EMQ.examModelID
                INNER JOIN QuestionBank QB 
                ON QB.ID = EMQ.questionID
                INNER JOIN StudentSubmit_Answer SSA
                    ON SSA.StudentSubmitID = SS.ID
            WHERE SS.studentID = @studentID AND SS.examModelID = @examModelID
        END TRY
        BEGIN CATCH
        END CATCH
    END
GO


-- Delete Submittion
CREATE OR ALTER PROC deleteStudentExamSubmition
	@studentID INT , @examModelID INT
WITH ENCRYPTION 
AS 
BEGIN
 Update StudentSubmit SET isDeleted = 1 WHERE studentID = @studentID AND examModelID = @examModelID
 IF @@ROWCOUNT < 1 
    RAISERROR('There in no submition from this student for this exam, or it has been deleted',5,1)
END
GO

GO
--Submit Answer for a Question
CREATE OR ALTER PROCEDURE InsertAnswerForStudentSubmition
    @StudentSubmitID INT,
    @examModelID INT,
    @questionID INT,
    @studentAnswer NVARCHAR(200)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM StudentSubmit WHERE ID = @StudentSubmitID)
        BEGIN
            RAISERROR ('Invalid StudentSubmitID.', 16, 1);
            RETURN;
        END;


        IF NOT EXISTS (SELECT 1 FROM ExamModel WHERE ID = @examModelID)
        BEGIN
            RAISERROR ('Invalid examModelID.', 16, 1);
            RETURN;
        END;

  
        IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID)
        BEGIN
            RAISERROR ('Invalid questionID.', 16, 1);
            RETURN;
        END;

        -- Check for duplicate submission
        IF EXISTS (
            SELECT 1
            FROM StudentSubmit_Answer
            WHERE StudentSubmitID = @StudentSubmitID
              AND examModelID = @examModelID
              AND questionID = @questionID
        )
        BEGIN
            Update StudentSubmit_Answer
                SET studentAnswer = @studentAnswer
                WHERE StudentSubmitID = @StudentSubmitID
                    AND examModelID = @examModelID
                    AND questionID = @questionID
            RETURN;
        END;

 
        INSERT INTO StudentSubmit_Answer (StudentSubmitID, examModelID, questionID, studentAnswer)
        VALUES (@StudentSubmitID, @examModelID, @questionID, @studentAnswer);

        COMMIT TRANSACTION;

        SELECT 'Answer submitted successfully.';
    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
			SELECT @ErrorMessage = ERROR_MESSAGE(), 
				   @ErrorSeverity = ERROR_SEVERITY(), 
				   @ErrorState = ERROR_STATE();
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

-----------------------------------
GO
---------useless SP----------
-- Stored Procedure: Update a Submitted Answer
CREATE OR ALTER PROCEDURE UpdateStudentSubmitAnswer
    @studentSubmitID INT,
    @examModelID INT,
    @questionID INT,
    @newAnswer NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
    -- Check if the answer already exists
        IF NOT EXISTS (
            SELECT 1 
            FROM StudentSubmit_Answer 
            WHERE StudentSubmitID = @studentSubmitID 
              AND examModelID = @examModelID 
              AND questionID = @questionID
        )
        BEGIN
            RAISERROR('The specified answer does not exist. Cannot update.', 16, 1);
            RETURN;
        END;

        BEGIN TRANSACTION;
        
            UPDATE StudentSubmit_Answer
            SET studentAnswer = @newAnswer
            WHERE StudentSubmitID = @studentSubmitID 
                AND examModelID = @examModelID
                AND questionID = @questionID;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), 
               @ErrorSeverity = ERROR_SEVERITY(), 
               @ErrorState = ERROR_STATE();

        RAISERROR('Error updating answer: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);

        -- Return failure status
        SELECT 0 AS Status, 'Failed to update answer.' AS Message;
    END CATCH;
END;
GO

--- Get All Exam Answers Submitted by a Student with review to it 
CREATE OR ALTER PROCEDURE GetStudentAnswersPerExamWithReview 
    @studentID INT,
    @examModelID INT
AS
BEGIN

	IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @studentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @studentID);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ExamModel WHERE ID = @examModelID)
    BEGIN
        RAISERROR('Exam model with ID %d not found.', 16, 1, @examModelID);
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1 
            FROM StudentSubmit_Answer ssa
            INNER JOIN StudentSubmit SS 
                ON ssa.StudentSubmitID = SS.ID
            WHERE SS.studentID = @studentID AND SS.examModelID = @examModelID
        )
    BEGIN
        RAISERROR('No answers found for student with ID %d and exam model with ID %d.', 16, 1, @studentID, @examModelID);
        RETURN;
    END

    SELECT 
        ssa.questionID,
        qb.questionText,
        ssa.studentAnswer,
        qb.correctChoice,
        EMQ.mark,
        CASE 
            WHEN ssa.studentAnswer = qb.correctChoice THEN 'Correct'
            ELSE 'Incorrect'
        END AS AnswerStatus
    FROM 
        StudentSubmit_Answer ssa
    INNER JOIN 
        StudentSubmit SS ON ssa.StudentSubmitID = SS.ID
    INNER JOIN 
        QuestionBank qb ON ssa.questionID = qb.ID
    INNER JOIN ExamModel_Question EMQ
        ON QB.ID = EMQ.questionID
    WHERE 
        SS.studentID = @studentID 
        AND SS.examModelID = @examModelID;
END;