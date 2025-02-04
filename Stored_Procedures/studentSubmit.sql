
--------------------------------------------------------------------------------------
---------------------------------- Student Submit ------------------------------------
--------------------------------------------------------------------------------------

-- helper procedure to get the grade of the student in a certain exam
CREATE OR ALTER PROC HELPER_calcStudentGrade
    @studentID INT,
    @examModelID INT
WITH
    ENCRYPTION
AS
BEGIN
    Declare @calculatedGrade INT;
    SET @calculatedGrade  = 0;

    -- Calculate the total grade by summing the marks for correct answers
    -- Filter by studentID and examModelID

    SELECT @calculatedGrade = ISNULL(SUM(EMQ.Mark), 0.0)
    FROM ExamModel_Question EMQ
        JOIN StudentSubmit_Answer SA ON EMQ.questionID = SA.questionID
        JOIN StudentSubmit SS ON SS.ID = SA.StudentSubmitID
    WHERE EMQ.correctChoice = SA.studentAnswer
        AND SS.studentID = @studentID
        AND EMQ.examModelID = @examModelID;
    
    SELECT @calculatedGrade AS [Grade];
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
        MAX(CASE WHEN qbcRow.rn = 1 THEN qbcRow.Choice END) AS optionone,
        MAX(CASE WHEN qbcRow.rn = 2 THEN qbcRow.Choice END) AS optiontwo,
        MAX(CASE WHEN qbcRow.rn = 3 THEN qbcRow.Choice END) AS optionthree,
        MAX(CASE WHEN qbcRow.rn = 4 THEN qbcRow.Choice END) AS optionfour,
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
    INNER JOIN 
        ExamModel_Question EMQ ON qb.ID = EMQ.questionID
    INNER JOIN 
        (SELECT questionID, Choice, ROW_NUMBER() OVER (PARTITION BY questionID ORDER BY Choice) AS rn FROM QuestionBank_Choice WHERE isDeleted = 0) qbcRow
        ON qbcRow.questionID = qb.ID
    WHERE 
        SS.studentID = @studentID 
        AND SS.examModelID = @examModelID
    GROUP BY 
        ssa.questionID, qb.questionText, ssa.studentAnswer, qb.correctChoice, EMQ.mark;
END;


GO

CREATE OR ALTER PROCEDURE getAllStudentSubmitions 
AS 
BEGIN
    SELECT 
        SS.ID AS[studentSubmitID],
        SS.studentID,
        St.firstName + ' ' +St.lastName as [StudentName],
        SS.submitDate,
        C.Name AS [CourseName],
        EM.ID AS [ExamModelID],
        EM.instructorID,
        Inst.firstName + ' '    + Inst.lastName As [InstructorName]
    FROM StudentSubmit SS 
        INNER JOIN ExamModel EM ON EM.ID = SS.examModelId 
        INNER JOIN Course C ON C.ID = EM.CourseID
        INNER JOIN Instructor Inst ON Inst.ID = EM.instructorID
        INNER JOIN Student St on SS.studentID = St.ID
    WHERE SS.isDeleted = 0;
END;

GO

CREATE OR ALTER PROCEDURE getAllStudentSubmitionsPerExam 
@examModelId int
AS 
BEGIN
    SELECT 
        SS.ID AS[studentSubmitID],
        SS.studentID,
        St.firstName + ' ' +St.lastName as [StudentName],
        SS.submitDate,
        C.Name AS [CourseName],
        EM.ID AS [ExamModelID],
        EM.instructorID,
        Inst.firstName + ' ' + Inst.lastName As [InstructorName]
    FROM StudentSubmit SS 
        INNER JOIN ExamModel EM ON EM.ID = SS.examModelId 
        INNER JOIN Course C ON C.ID = EM.CourseID
        INNER JOIN Instructor Inst ON Inst.ID = EM.instructorID
        INNER JOIN Student St on SS.studentID = St.ID
    WHERE SS.isDeleted = 0 AND EM.ID = @examModelId;
END;

GO

CREATE OR ALTER PROCEDURE getStudentSubmitionPerStudentInCourse
@studentID INT, 
@courseId INT
AS 
BEGIN
    SELECT 
        SS.ID AS[studentSubmitID],
        SS.studentID,
        St.firstName + ' ' +St.lastName as [StudentName],
        SS.submitDate,
        C.Name AS [CourseName],
        EM.ID AS [ExamModelID],
        EM.instructorID,
        Inst.firstName + ' '    + Inst.lastName As [InstructorName]
    FROM StudentSubmit SS 
        INNER JOIN ExamModel EM ON EM.ID = SS.examModelId 
        INNER JOIN Course C ON C.ID = EM.CourseID
        INNER JOIN Instructor Inst ON Inst.ID = EM.instructorID
        INNER JOIN Student St on SS.studentID = St.ID
    WHERE SS.isDeleted = 0 AND SS.studentID = @studentID AND EM.CourseID = @courseId;
END;

GO;


CREATE Or ALTER PROCEDURE GetStudentExamMarks 
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        s.StudentID AS [StudentId],
        s.ID AS [StudentSubmitId],
        s.examModelID,
        SUM(CASE 
            WHEN sa.studentAnswer = q.correctChoice THEN q.mark 
            ELSE 0 
        END) AS TotalMarks
    FROM StudentSubmit s
    JOIN StudentSubmit_Answer sa ON s.ID = sa.StudentSubmitID
    JOIN ExamModel_Question q 
        ON sa.examModelID = q.examModelID AND sa.questionID = q.questionID
    WHERE s.StudentID = @StudentID AND sa.isDeleted = 0
    GROUP BY s.ID, s.examModelID, s.StudentID ;
END;