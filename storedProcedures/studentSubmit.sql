
--------------------------------------------------------------------------------------
---------------------------------- Student Submit ------------------------------------
--------------------------------------------------------------------------------------

-- helper procedure to get the grade of the student in a certain exam
CREATE PROC HELPER_calcStudentGrade
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

    SELECT @calculatedGrade = SUM(EMQ.mark)
    FROM ExamModel_Question EMQ
        JOIN StudentSubmit_Answer SA ON EMQ.questionID = SA.questionID
        JOIN StudentSubmit SS ON SS.ID = SA.StudentSubmitID
    WHERE EMQ.correctChoice = SA.studentAnswer
        AND SS.studentID = @studentID
        AND EMQ.examModelID = @examModelID;
END
GO

-- Insert Submition 
CREATE PROC insertStudentSubmition
    @stdID INT,
    @examMdlID INT
WITH ENCRYPTION
AS
BEGIN
    -- Insert the grade into the StudentSubmit table as 0 (not graded yet)
    INSERT INTO StudentSubmit
        (studentID, examModelID, grade, submitDate)
    VALUES
        (@stdID, @examMdlID, 0, GETDATE());
    SELECT SCOPE_IDENTITY();
END
GO

-- get Submittion

CREATE PROC getStudentSubmition
	@SID INT , @EID INT
WITH ENCRYPTION 
AS 
BEGIN
 SELECT * FROM StudentSubmit WHERE studentID = @SID AND examModelID = @EID
END
GO

-- Update Submittion 

CREATE PROC updateStudentSubmition
    @stdID INT,
    @examMdlID INT
WITH ENCRYPTION
AS

BEGIN
    DECLARE @stdgrade DECIMAL(5,2);

    -- Calculate the student's grade for the specific exam model
    EXEC HELPER_calcStudentGrade 
        @studentID = @stdID, 
        @examModelID = @examMdlID, 
        @calculatedGrade = @stdgrade OUTPUT;

    -- Update the grade in the StudentSubmit table
    UPDATE StudentSubmit 
    SET grade = @stdgrade
    WHERE studentID = @stdID 
      AND examModelID = @examMdlID;
END
GO

-- Delete Submittion

CREATE PROC deleteStudentExamSubmition
	@SID INT , @EID INT
WITH ENCRYPTION 
AS 
BEGIN
 DELETE FROM StudentSubmit WHERE studentID = @SID AND examModelID = @EID
END
GO