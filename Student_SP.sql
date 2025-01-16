--- Add a New Student
CREATE PROCEDURE AddStudent
    @firstName NVARCHAR(100),
    @lastName NVARCHAR(100),
    @gender NVARCHAR(10),
    @SSN NVARCHAR(20),
    @enrollmentDate DATETIME,
    @Email NVARCHAR(100),
    @phone NVARCHAR(15),
    @DateOfBirth DATE,
    @address NVARCHAR(200),
    @trackID INT,
    @departmentID INT
AS 
BEGIN
	DECLARE @studentID INT;
	
    INSERT INTO Student (firstName, lastName, gender, SSN, enrollmentDate, email, phone, DateOfBirth, address, trackID, departmentID)
    VALUES (@firstName, @lastName, @gender, @SSN, @enrollmentDate, @Email, @phone, @DateOfBirth, @address, @trackID, @departmentID);
	
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

END;

/***
-- auto enroll the student to the cources related to its track 
GO
CREATE TRIGGER EnrollStudentInCoursesAfterInsert
ON Student
AFTER INSERT
AS
BEGIN
    DECLARE @studentID INT;
    DECLARE @trackID INT;

    SELECT @studentID = ID, @trackID = trackID FROM INSERTED;

    INSERT INTO Course_Student (courseID, studentID, startDate)
    SELECT 
        tc.courseID,  
        @studentID,   
        GETDATE()     
    FROM 
        Track_Course tc
    WHERE 
        tc.trackID = @trackID; =
END;
 ***/
 -------------------------------------
GO
--Get Student by ID
CREATE PROCEDURE SelectStudentById
    @StudentID INT
AS
BEGIN
    SELECT * FROM Student WHERE ID = @StudentID;
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
        -- Validate StudentID
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
        BEGIN
            RAISERROR ('StudentID %d does not exist.', 16, 1, @StudentID);
            ROLLBACK TRANSACTION;
            RETURN;
        END
			------------------

        DELETE FROM ExamModel_StudentSubmit_Student
        WHERE studentID = @StudentID;

   
        DELETE FROM StudentSubmit_Answer
        WHERE StudentSubmitID IN (
            SELECT ID
            FROM StudentSubmit
            WHERE studentID = @StudentID
        );

  
        DELETE FROM StudentSubmit
        WHERE studentID = @StudentID;

        DELETE FROM Course_Student
        WHERE studentID = @StudentID;

        DELETE FROM Student
        WHERE ID = @StudentID;
			-------------
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

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
CREATE PROCEDURE UpdateStudentInfo
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
				ROLLBACK TRANSACTION;
				RETURN;
			END

			-- Check if trackID exists (optional, based on your logic)
			IF @trackID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Track WHERE ID = @trackID)
			BEGIN
				RAISERROR('Track not found.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END

			-- Check if departmentID exists
			IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = @departmentID)
			BEGIN
				RAISERROR('Department not found.', 16, 1);
				ROLLBACK TRANSACTION;
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
			ROLLBACK TRANSACTION;
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
CREATE PROCEDURE EnrollStudentInCourse
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
        c.ID AS "Course ID",
        c.Name AS "Course Name",
        cs.startDate AS "Enrollment Date"
    FROM 
        Course_Student cs
    INNER JOIN 
        Course c ON cs.courseID = c.ID
    WHERE 
        cs.studentID = @studentID
END;
------------------------------------------------------------
GO
CREATE PROCEDURE RemoveStudentEnrollment
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
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        DELETE FROM Course_Student
        WHERE courseID = @courseID AND studentID = @studentID;

        COMMIT TRANSACTION;
        PRINT 'Student successfully removed from the course.';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
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
CREATE PROCEDURE GetStudentCountInCourse
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
CREATE PROCEDURE SubmitExamAnswer
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
            ROLLBACK TRANSACTION;
            RETURN;
        END;


        IF NOT EXISTS (SELECT 1 FROM ExamModel WHERE ID = @examModelID)
        BEGIN
            RAISERROR ('Invalid examModelID.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

  
        IF NOT EXISTS (SELECT 1 FROM QuestionBank WHERE ID = @questionID)
        BEGIN
            RAISERROR ('Invalid questionID.', 16, 1);
            ROLLBACK TRANSACTION;
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
            RAISERROR ('Duplicate submission is not allowed for the same question.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

 
        INSERT INTO StudentSubmit_Answer (StudentSubmitID, examModelID, questionID, studentAnswer)
        VALUES (@StudentSubmitID, @examModelID, @questionID, @studentAnswer);

        COMMIT TRANSACTION;

        PRINT 'Answer submitted successfully.';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

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
CREATE PROCEDURE UpdateSubmittedAnswer
    @studentSubmitID INT,
    @examModelID INT,
    @questionID INT,
    @newAnswer NVARCHAR(200)
AS
BEGIN
    UPDATE StudentSubmit_Answer
    SET studentAnswer = @newAnswer
    WHERE StudentSubmitID = @studentSubmitID 
    AND examModelID = @examModelID
    AND questionID = @questionID;
END;





------------------------EXTRA MAHARAT------------------------------------------------
GO 
CREATE PROCEDURE GetExamSubmissionCountByStudent
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT COUNT(*) AS "Submitted Exams"
    FROM StudentSubmit SS
    WHERE SS.studentID = @StudentID;
END;

--------------------------------------------------------------

GO
CREATE PROCEDURE GetStudentExamNames 
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

-----------------------------------------------------------------
GO
CREATE PROCEDURE GetStudentGradesForCourses

    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
    BEGIN
        RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
        RETURN;
    END

    SELECT 
        C.Name AS Course,  SS.grade AS Grade
    FROM StudentSubmit SS
    INNER JOIN  ExamModel EM 
		ON EM.ID = SS.examModelID
    INNER JOIN  Course C 
		ON C.ID = EM.CourseID
    WHERE SS.studentID = @StudentID
    ORDER BY C.Name;
END
---------------------------------------------------------------

GO
CREATE PROCEDURE GetStudentGradeForCourse 
	@StudentID INT,
	@CourseID INT
AS
BEGIN
	
	IF NOT EXISTS (SELECT 1 FROM Student WHERE ID = @StudentID)
		BEGIN
			RAISERROR('Student with ID %d not found.', 16, 1, @StudentID);
			RETURN;
		END

    IF NOT EXISTS (SELECT 1 FROM Course WHERE ID = @CourseID)
		BEGIN
			RAISERROR('Course with ID %d not found.', 16, 1, @CourseID);
			RETURN;
		END


	SELECT SS.grade 
	FROM StudentSubmit SS
	INNER JOIN ExamModel EM
		ON EM.ID=SS.examModelID
	WHERE SS.studentID=@StudentID 
	AND  EM.CourseID=@CourseID
END

----------------------------------------------------------------------

GO
--- Get All Exam Answers Submitted by a Student
CREATE PROCEDURE GetStudentExamAnswers
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
