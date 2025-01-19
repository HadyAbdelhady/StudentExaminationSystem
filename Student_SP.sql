--- Add a New Student
CREATE PROCEDURE InsertStudent
    @firstName NVARCHAR(100),
    @lastName NVARCHAR(100),
    @gender NVARCHAR(10),
    @SSN NVARCHAR(20),
    @Email NVARCHAR(100),
    @phone NVARCHAR(15),
    @DateOfBirth DATE,
    @address NVARCHAR(200),
    @trackID INT,
    @departmentID INT
AS 
BEGIN
    BEGIN TRY
	DECLARE @studentID INT;
	
    INSERT INTO Student (firstName, lastName, gender, SSN, enrollmentDate, email, phone, DateOfBirth, address, trackID, departmentID)
    VALUES (@firstName, @lastName, @gender, @SSN, GETDATE(), @Email, @phone, @DateOfBirth, @address, @trackID, @departmentID);
	
    SET @studentID = SCOPE_IDENTITY();

    -- Enroll the student in all courses associated with the track
    INSERT INTO Course_Student (courseID, studentID, startDate)
    SELECT 
        tc.courseID,
        @studentID,
        GETDATE() 
    FROM 
        Track_Course tc
    WHERE 
        tc.trackID = @trackID;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of error
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        -- Raise the error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
--Get Student by ID
CREATE PROCEDURE GetStudentById
    @StudentID INT
AS
BEGIN
    SELECT Std.* , Dept.Name as [departmentName] , T.Name as [trackName]
    FROM Student Std INNER JOIN Department Dept
    ON Std.departmentID = Dept.ID
    INNER JOIN Track T 
    ON Std.trackID = T.ID
    WHERE Std.ID = @StudentID;
END;
------------------------------------------------------
GO
--Remove a Student
CREATE PROCEDURE DeleteStudent
    @StudentID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Check aginst NULL values
        IF @StudentID IS NULL OR @StudentID <= 0
        BEGIN
            RAISERROR('Invalid StudentID. StudentID must be a positive integer.', 16, 1);
            RETURN;
        END;
        -- Validate StudentID
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
        BEGIN
            RAISERROR ('StudentID %d does not exist.', 16, 1, @StudentID);
            ROLLBACK TRANSACTION;
            RETURN;
        END
			-------------
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- ensure that @@TRANCOUNT is checked before rolling back to avoid errors if the transaction is not active
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
END

---------------------------------------------
GO
--Update Student Information
CREATE PROCEDURE UpdateStudent
    @StudentID INT,
    @firstName NVARCHAR(100),
    @lastName NVARCHAR(100),
    @gender NVARCHAR(10),
    @SSN NVARCHAR(20),
    @email NVARCHAR(100),
    @phone NVARCHAR(15),
    @DateOfBirth DATE,
    @address NVARCHAR(200),
    @trackID INT,
    @departmentID INT
AS
BEGIN
    BEGIN TRANSACTION;

		BEGIN TRY
			-- Check if the student exists
			IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
			BEGIN
				RAISERROR('Student not found.', 16, 1);
				RETURN;
			END

			-- Check if trackID exists (optional, based on your logic)
			IF @trackID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Track WHERE ID = @trackID)
			BEGIN
				RAISERROR('Track not found.', 16, 1);
				RETURN;
			END

			-- Check if departmentID exists
			IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @departmentID)
			BEGIN
				RAISERROR('Department not found.', 16, 1);
				RETURN;
			END

			-- Update the student information
			UPDATE Student
			SET firstName = @firstName,
				lastName = @lastName,
				gender = @gender,
				SSN = @SSN,
				email = @email,
				phone = @phone,
				DateOfBirth = @DateOfBirth,
				address = @address,
				trackID = @trackID,
				departmentID = @departmentID
			WHERE ID = @StudentID;

	COMMIT TRANSACTION;
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

--------------------------------------------------

GO
--Enroll Student in a Course
CREATE PROCEDURE InsertStudentInCourse
    @courseID INT,
    @studentID INT,
    @startDate DATETIME
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Course_Student
        WHERE courseID = @courseID AND studentID = @studentID
    )
    BEGIN
        RAISERROR ('The student is already enrolled in the specified course.', 16, 1);
        RETURN;
    END

    INSERT INTO Course_Student (courseID, studentID, startDate)
    VALUES (@courseID, @studentID, @startDate);
END;

------------------------------------------------

GO
--Get Courses Enrolled by a Student
CREATE PROCEDURE GetCoursesEnrolledByStudent
    @studentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @studentID)
    BEGIN
        RAISERROR('Student not found.', 16, 1);
        RETURN;
    END

 
    SELECT 
        c.ID ,
        c.Name ,
        cs.startDate 
    FROM 
        Course_Student cs
    INNER JOIN 
        Course c ON cs.courseID = c.ID
    WHERE 
        cs.studentID = @studentID
END;
------------------------------------------------------------
GO
CREATE PROCEDURE DeleteCourseForStudent
    @courseID INT,
    @studentID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Course_Student
            WHERE courseID = @courseID AND studentID = @studentID
        )
        BEGIN
            RAISERROR('No matching record found for the given course and student.', 16, 1);
            RETURN;
        END;

        DELETE FROM Course_Student
        WHERE courseID = @courseID AND studentID = @studentID;

        COMMIT TRANSACTION;
        PRINT 'Student successfully removed from the course.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
		SELECT  @ErrorMessage = ERROR_MESSAGE(), 
				@ErrorSeverity = ERROR_SEVERITY(), 
				@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

-------------------------------------------------
GO
--Count Students Enrolled in a Course
CREATE PROCEDURE GetCountStudentInCourse
    @courseID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @courseID)
    BEGIN
        RAISERROR ('The specified course ID does not exist.', 16, 1);
        RETURN;
    END;
    SELECT COUNT(CS.studentID) AS StudentCount
    FROM Course_Student CS
    WHERE CS.courseID = @courseID;
END;

-------------------------------------------------------------------

GO
--Submit Answer for a Question
CREATE PROCEDURE InsertAnswerForStudentSubmition
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
            RAISERROR ('Duplicate submission answer is not allowed for the same question.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

 
        INSERT INTO StudentSubmit_Answer (StudentSubmitID, examModelID, questionID, studentAnswer)
        VALUES (@StudentSubmitID, @examModelID, @questionID, @studentAnswer);

        COMMIT TRANSACTION;

        PRINT 'Answer submitted successfully.';
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
CREATE PROCEDURE UpdateStudentSubmitAnswer
    @studentSubmitID INT,
    @examModelID INT,
    @questionID INT,
    @newAnswer NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
    UPDATE StudentSubmit_Answer
    SET studentAnswer = @newAnswer
    WHERE StudentSubmitID = @studentSubmitID 
    AND examModelID = @examModelID
    AND questionID = @questionID;

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
            ROLLBACK TRANSACTION;
            RETURN;
        END;

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





------------------------EXTRA MAHARAT------------------------------------------------
GO 
CREATE PROCEDURE GetCountExamAnsweredByStudent
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT COUNT(*)
    FROM StudentSubmit SS
    WHERE SS.studentID = @StudentID;
END;

--------------------------------------------------------------

GO
CREATE PROCEDURE GetExamCourseNamesByStudent
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT C.Name AS ExamName
    FROM Course C
    INNER JOIN ExamModel EM
        ON C.ID = EM.CourseID
    INNER JOIN StudentSubmit SS
        ON EM.ID = SS.examModelID
    WHERE SS.studentID = @StudentID;
END;

----------------------------------------------------------------------

GO
--- Get All Exam Answers Submitted by a Student
CREATE PROCEDURE GetStudentAnswersPerExam
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
    INNER JOIN ExamModel_StudentSubmit_Student emss 
        ON ssa.StudentSubmitID = emss.studentSubmitID
    WHERE emss.studentID = @studentID 
      AND emss.examModelID = @examModelID
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
        CASE 
            WHEN ssa.studentAnswer = qb.correctChoice THEN 'Correct'
            ELSE 'Incorrect'
        END AS AnswerStatus
    FROM 
        StudentSubmit_Answer ssa
    INNER JOIN 
        ExamModel_StudentSubmit_Student emss ON ssa.StudentSubmitID = emss.studentSubmitID
    INNER JOIN 
        QuestionBank qb ON ssa.questionID = qb.ID
    WHERE 
        emss.studentID = @studentID 
        AND emss.examModelID = @examModelID;
END;