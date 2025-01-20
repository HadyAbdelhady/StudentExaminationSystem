--ExamModel_StudentSubmit_Student Table

--Inserting Into the table
CREATE PROCEDURE InsertIntoExamModelStudentSubmitStudent 
	@examModelID INT, @studentSubmitID INT, @studentID INT
	,@date DATETIME
AS
BEGIN
	INSERT INTO ExamModel_StudentSubmit_Student (examModelID, studentSubmitID, studentID, submitDate)
		VALUES(@examModelID, @studentSubmitID, @studentID, @date)
END
GO
--Updating ExamModel_StudentSubmit_Student Table
CREATE PROCEDURE UpdateExamModelStudentSubmitStudent 
    @examModelID INT, @studentSubmitID INT, @studentID INT,
    @date DATETIME
AS
BEGIN
    UPDATE ExamModel_StudentSubmit_Student
    SET submitDate = @date
    WHERE examModelID = @examModelID AND studentSubmitID = @studentSubmitID AND studentID = @studentID;
END;
GO
-- Deleting from ExamModel_StudentSubmit_Student'
CREATE PROCEDURE deleteExamModelStudentSubmitStudent
	@examModelID INT, @studentSubmitID INT, @studentID INT
AS
BEGIN
	DELETE FROM ExamModel_StudentSubmit_Student
		WHERE examModelID = @examModelID AND studentSubmitID = @studentSubmitID AND studentID = @studentID
END
GO

--Getting all ExamModel_StudentSubmit_Student data
CREATE PROCEDURE getAllExamModelStudentSubmitStudents
AS
BEGIN
    SELECT * FROM ExamModel_StudentSubmit_Student;
END;